import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDatePickerInput extends StatefulWidget {
  const CustomDatePickerInput({
    super.key, 
    required this.onCompleted, 
    required this.initialValue, 
    required this.updateStartTime,
    required this.updateEndTime, 
    required this.updateWidget,
    required this.initialTime, 
    required this.useTime, 
    required this.startTime,
    required this.endTime,
    required this.startDate, 
    required this.endDate,
    required this.isEndDate,
    required this.mode
  });

  final bool useTime;
  final Function(DateTime?) onCompleted; 
  final Function(DateTime?) updateStartTime;
  final Function(DateTime?) updateEndTime;
  final Function updateWidget;
  final DateTime? initialValue;
  final DateTime? initialTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isEndDate;
  final CustomDatePickerMode mode;

  @override
  State<CustomDatePickerInput> createState() => _CustomDatePickerInputState();
}

class _CustomDatePickerInputState extends State<CustomDatePickerInput> {

  bool useUsFormat = false;
  String hint = '';
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final _dateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();
  
  bool hasError = false;

  @override
  dispose() {
    timeController.dispose();
    dateController.dispose();
    _timeFocusNode.dispose();
    _dateFocusNode.unfocus();
    super.dispose();
  }

  Future<void> getHint() async {
    DateTime now = DateTime.now();

    String value = '';

    if (useUsFormat) {
      value = '${_padIfNecessary(now.month)}/${_padIfNecessary(now.day)}/${now.year}';
    } else {
      value = '${_padIfNecessary(now.day)}/${_padIfNecessary(now.month)}/${now.year}';
    }
    hint = formatToDashFormat(value);
  }

  String formatToDashFormat(String text) {
    return text.replaceAll(RegExp(r'[-./ _:,.]'), '-');
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      String isoString = AppDate.formatDateAsString(widget.initialValue!);
      setState(() {
        AppDate.formatIso8601StringToPreferedDateFormatString(isoString, false).then((v) {
          dateController.text = formatToDashFormat(v!).replaceAll('-', '/');
        });
      });
    }
    if (widget.initialTime != null) {
      timeController.text = '${_padIfNecessary(widget.initialTime!.hour)}:${_padIfNecessary(widget.initialTime!.minute)}';
    }
    
    getHint().then((value) {
      setState(() {});
    });

    AppConfig.getConfigValue('prefer_us_date_format').then((value) {
      useUsFormat = value ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: widget.useTime ? 183 : 120,
      height: 40,
      decoration: BoxDecoration(
        color: theme.primary,
        border: hasError ? Border.all(color: theme.error) : null,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: CustomTooltip(
          message: dateController.text.isNotEmpty 
            ? hasError 
              ? S.of(context).custom_date_picker_invalid_date 
              : '' 
            : '',
          textColor: theme.onError,
          background: theme.error,
          child: TextSelectionTheme(
            data: TextSelectionThemeData(
              selectionColor: theme.secondary.withValues(alpha: 0.5)
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: dateController,
                      onChanged: (value) {
                        _onDateChanged(value, dateController, useUsFormat);
                      },
                      onEditingComplete: () async {
                        bool isValid = await _validateDate(dateController, widget.onCompleted, formatToDashFormat);
                        _dateFocusNode.unfocus();
                        setState(() {
                          hasError = isValid;
                        });
                      },
                      onTapOutside: (event) async {
                        bool isValid = await _validateDate(dateController, widget.onCompleted, formatToDashFormat);
                        _dateFocusNode.unfocus();
                        setState(() {
                          hasError = isValid;
                        });
                      },
                      focusNode: _dateFocusNode,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9/]+$'))
                      ],
                      style: theme.bodyMedium,
                      cursorColor: theme.onPrimary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint.replaceAll('-', '/'),
                        hintStyle: theme.bodyMedium.copyWith(color: theme.onPrimary.withValues(alpha: 0.6)),
                        contentPadding: const EdgeInsets.only(bottom: 7)
                      ),
                    ),
                  ),
                ),
                if (widget.useTime)
                ...[
                  // Separator
                  Container(
                    width: 2,
                    height: 20,
                    decoration: BoxDecoration(
                      color: theme.onPrimary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(1)
                    ),
                  ),
                  // Time
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CustomTimePicker(
                        key: UniqueKey(), 
                        theme: theme,
                        time: widget.isEndDate 
                          ? widget.endTime
                          : widget.startTime,
                        onSelected: (time) {
                          _validateTime(widget, time);
                        },
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _padIfNecessary(int value) {
  if (value.toString().length == 1) {
    return '0$value';
  } else {
    return value.toString();
  }
}

void _onDateChanged(String value, TextEditingController dateController, bool useUsFormat) {
  // Remove any non-numeric and non-slash characters
  String digitsOnly = value.replaceAll(RegExp(r'[^0-9/]'), '');
  String newValue = '';

  // Split the input by the slash
  List<String> parts = digitsOnly.split('/');

  String handleDay(List<String> parts) {
    String dayPart = useUsFormat ? parts[1] : parts[0];
    if (dayPart.length == 1 && int.parse(dayPart) > 3) {
      return '0$dayPart';
    } else if (dayPart.length == 2) {
      return dayPart;
    } else {
      return dayPart;
    }
  }

  String handleMonth(List<String> parts) {
    String monthPart = useUsFormat ? parts[0] : parts[1];
    if (monthPart.length == 1 && int.parse(monthPart) > 1) {
      return '0$monthPart';
    } else if (monthPart.length == 2) {
      return monthPart;
    } else if (monthPart.isNotEmpty) {
      return monthPart;
    } else {
      return '';
    }
  }

  if (parts.isNotEmpty) {
    // Handle day part
    
    if (useUsFormat) {
      newValue += handleMonth(parts);
    } else {
      newValue += handleDay(parts);
    }

    // Add slash after day part
    if (newValue.length == 2 && !newValue.contains('/')) {
      newValue += '/';
    }
  }

  if (parts.length >= 2) {
    // Handle month part
   
    if (useUsFormat) {
      newValue += handleDay(parts);
    } else {
      newValue += handleMonth(parts);
    }

    // Add slash after month part
    if (newValue.length == 5 && !newValue.endsWith('/')) {
      newValue += '/';
    }
  }

  if (parts.length >= 3) {
    // Handle year part (4 digits max)
    String yearPart = parts[2];
    newValue += yearPart.substring(0, yearPart.length > 4 ? 4 : yearPart.length);
  }

  // Ensure the final format doesn't exceed DD/MM/YYYY
  if (newValue.length > 10) {
    newValue = newValue.substring(0, 10);
  }

  // Update the date controller with the new value
  dateController.value = TextEditingValue(
    text: newValue,
    selection: TextSelection.collapsed(offset: newValue.length),
  );
}

Future<bool> _validateDate(TextEditingController dateController, Function(DateTime?) onCompleted, String Function(String) formatToDashFormat) async {
  if (dateController.text.isEmpty) {
    return false;
  }
  DateTime? formatted = await AppDate.formatDateWithTheCorrectOrder(formatToDashFormat(dateController.text));
  if (formatted != null) {
    if (formatted.year.toString().length >= 3) {
      formatted = DateTime(
        formatted.year.clamp(1900, 2300),
        formatted.month,
        formatted.day
      );
    }
    await onCompleted(formatted);
    return false;
  } else {
    return true;
  }
}

bool _isDateTheSameDay(DateTime? date, DateTime? comparedTo) {
  if (date == null || comparedTo == null) {
    return false;
  }
  return date.year == comparedTo.year && date.month == comparedTo.month && date.day == comparedTo.day;
}


void _validateTime(CustomDatePickerInput widget, DateTime selectedTime) {
  if (widget.mode == CustomDatePickerMode.single) {
    widget.updateStartTime(selectedTime);
    widget.updateWidget();
    return;
  }

  if (widget.startDate == null || widget.endDate == null || widget.startTime == null || widget.endTime == null) {
    return;
  }

  if (!_isDateTheSameDay(widget.startDate, widget.endDate)) {
    if (widget.isEndDate) {
      widget.updateEndTime(selectedTime);
    } else {
      widget.updateStartTime(selectedTime);
    }
    widget.updateWidget();
    return;
  }

  if (widget.isEndDate) {
    if (selectedTime.isBefore(widget.startTime!)) {
      widget.updateEndTime(selectedTime);
      widget.updateStartTime(selectedTime.subtract(const Duration(hours: 1)));
    } else {
      widget.updateEndTime(selectedTime);
    }
  } else {
    if (selectedTime.isAfter(widget.endTime!)) {
      widget.updateStartTime(selectedTime);
      widget.updateEndTime(selectedTime.add(const Duration(hours: 1)));
    } else {
      widget.updateStartTime(selectedTime);
    }
  }
  widget.updateWidget();
}


class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    required this.theme,
    required this.onSelected,
    this.time
  });

  final StylesGetters theme;
  final DateTime? time;
  final Function(DateTime) onSelected;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> with SingleTickerProviderStateMixin {

  DateTime selected = DateTime.now();

  GlobalKey key = GlobalKey();

  late AnimationController _controller;
  late Animation<double> _animation;

  OverlayEntry? entry;

  late PageController hourController = PageController(viewportFraction: 0.25, initialPage: selected.hour);
  late PageController minuteController = PageController(viewportFraction: 0.25, initialPage: getMinuteIndex(selected.minute));

  int getMinuteIndex(int minutes) {
    int roundexMinutes = (minutes / 5).round() * 5;

    List<int> minutesList = [for (int i = 0; i < 60; i += 5) i];

    int index = minutesList.indexOf(roundexMinutes);

    return index;
  }

  int getMinutesFromIndex(int index) {
    List<int> minutesList = [for (int i = 0; i < 60; i += 5) i];

    if (index < 0 || index >= minutesList.length) {
      throw RangeError('Index out of range');
    }

    return minutesList[index];
  }

  void _confirmSelection() {
    _controller.reverse().then((_) {
      entry?.remove();
      entry = null;
      widget.onSelected(selected);
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var buttonSize = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    double width = 300;
    double height = 200;

    Size screensize = MediaQuery.of(context).size;

    double top = offset.dy - (height / 2) + (buttonSize.height / 2);
    double left = offset.dx  - (width / 2) + (buttonSize.width / 2);

    if (top + height + 45 > screensize.height) {

      top = screensize.height - height - 45;
    }

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _confirmSelection,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  width: width,
                  height: height + 45,
                  decoration: BoxDecoration(
                    color: widget.theme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                      width: 0.5
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Stack(
                        children: [
                          Positioned(
                            top: (height / 2) - 20,
                            left: 10,
                            child: Container(
                              width: width - 20,
                              height: 40,
                              decoration: BoxDecoration(
                                color: widget.theme.surface,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  ":",
                                  style: widget.theme.titleLarge
                                    .copyWith(color: widget.theme.onPrimary),
                                ),
                              ),
                            )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 100,
                                child: PageView(
                                  scrollDirection: Axis.vertical,
                                  controller: hourController,
                                  pageSnapping: true, 
                                  onPageChanged: (value) {
                                    selected = selected.copyWith(hour: value);
                                  },
                                  allowImplicitScrolling: true,
                                  children: List.generate(24, (index) => Container(
                                      width: 10, 
                                      height: 15, 
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent
                                      ),
                                      child: Center(
                                          child: Text(
                                            AppDate.padIfNecessary((index)),
                                            style: widget.theme.titleLarge
                                              .copyWith(color: widget.theme.onPrimary),
                                          )
                                        ),
                                    )
                                  )
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                width: 100,
                                child: PageView(
                                  scrollDirection: Axis.vertical,
                                  controller: minuteController,
                                  pageSnapping: true, 
                                  onPageChanged: (value) {
                                    selected = selected.copyWith(minute: getMinutesFromIndex(value));
                                  },
                                  allowImplicitScrolling: true,
                                  children: List.generate(12, (index) => Container(
                                      width: 10,
                                      height: 15, 
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent
                                      ),
                                      child: Center(
                                          child: Text(
                                            AppDate.padIfNecessary((index * 5)),
                                            style: widget.theme.titleLarge
                                              .copyWith(color: widget.theme.onPrimary)
                                          )
                                        ),
                                    )
                                  )
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            child: SizedBox(
                              width: width,
                              height: (height / 2) - 20, 
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: SizedBox(
                                    width: width,
                                    height: (height / 2) - 20,
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            bottom: 45,
                            child: SizedBox(
                              width: width,
                              height: (height / 2) - 20, 
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: SizedBox(
                                    width: width,
                                    height: (height / 2) - 20,
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            top: height + 5,
                            left: width - (width - 7.5),
                            width: width - 15,
                            height: 30,
                            child: CustomTextButton(
                              S.of(context).submenu_artilces_image_description_button, 
                              _confirmSelection,
                              false, 
                              false
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      )
    ); 
  }

  void _showOverlayMenu(BuildContext context) {
    entry = _createOverlayEntry(context);
    Overlay.of(context).insert(entry!);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.time != null) {
      selected = widget.time!;
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200)
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showOverlayMenu(context);
        },
        child: Text(
          key: key,
          '${AppDate.padIfNecessary(selected.hour)}:${AppDate.padIfNecessary(((selected.minute / 5).round() * 5).clamp(0, 55))}',
          style: widget.theme.bodyMedium
            .copyWith(color: widget.theme.onPrimary.withValues(alpha: widget.time != null ? 1 : 0.5)),
          overflow: TextOverflow.ellipsis
        ),
      ),
    );

  }
}