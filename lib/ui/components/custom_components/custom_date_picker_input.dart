import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDatePickerInput extends StatefulWidget {
  const CustomDatePickerInput({
    super.key, 
    required this.onCompleted, 
    required this.initialValue, 
    required this.onTimeChanged, 
    required this.initialTime, 
    required this.useTime, 
    required this.timeLowerLimit, 
    required this.timeUpperLimit
  });

  final bool useTime;
  final Function(DateTime?) onCompleted; 
  final Function(DateTime?) onTimeChanged;
  final DateTime? initialValue;
  final DateTime? initialTime;
  final DateTime? timeLowerLimit;
  final DateTime? timeUpperLimit;

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
              selectionColor: theme.secondary.withOpacity(0.5)
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
                        hintStyle: theme.bodyMedium.copyWith(color: theme.onPrimary.withOpacity(0.6)),
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
                      color: theme.onPrimary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(1)
                    ),
                  ),
                  // Time
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        onChanged: (value) => _onTimeChanged(value, timeController),
                        onEditingComplete: () => _validateTime(timeController, _timeFocusNode, widget.onTimeChanged, widget.timeLowerLimit, widget.timeUpperLimit),
                        onTapOutside: (event) {
                          _validateTime(timeController, _timeFocusNode, widget.onTimeChanged, widget.timeLowerLimit, widget.timeUpperLimit);
                        },
                        focusNode: _timeFocusNode,
                        controller: timeController,
                        style: theme.bodyMedium,
                        cursorColor: theme.onPrimary,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^[0-9:]+$'))
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${_padIfNecessary(DateTime.now().hour)}:${_padIfNecessary(DateTime.now().minute)}',
                          hintStyle: theme.bodyMedium.copyWith(color: theme.onPrimary.withOpacity(0.6)),
                          contentPadding: const EdgeInsets.only(bottom: 7)
                        ),
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


void _onTimeChanged(String value, TextEditingController timeController) {
  String digitsOnly = value.replaceAll(RegExp(r'[^\d:]'), '');
  String newValue = '';

  // Handle hours
  if (digitsOnly.isNotEmpty) {
    if (int.parse(digitsOnly[0].replaceAll(':', '').isEmpty ? '0' : digitsOnly[0].replaceAll(':', '')) > 2) {
      newValue = '0${digitsOnly[0]}';
    } else {
      newValue = digitsOnly[0];
    }
  }
  if (digitsOnly.length >= 2) {
    int secondDigit = int.parse(digitsOnly[1].replaceAll(':', '').isEmpty ? '0' : digitsOnly[1].replaceAll(':', ''));
    if (newValue[0] == '2' && secondDigit > 3) {
      newValue += '3';
    } else {
      newValue += digitsOnly[1];
    }
  }

  // Add colon if length is 2 or more and doesn't contain a colon
  if (newValue.length >= 2 && !newValue.contains(':')) {
    newValue += ':';
  }

  // Handle minutes
  if (digitsOnly.length >= 3) {
    String minutes = digitsOnly.substring(3);
    if (minutes.isNotEmpty) {
      int firstMinuteDigit = int.parse(minutes[0].replaceAll(':', '').isEmpty ? '0' : minutes[0].replaceAll(':', ''));
      if (firstMinuteDigit > 5) {
        newValue += '0${minutes[0]}';
      } else {
        newValue += minutes[0];
      }
      if (minutes.length > 1) {
        newValue += minutes[1];
      }
    }
  }

  // Ensure we don't exceed HH:mm format
  if (newValue.length > 5) {
    newValue = newValue.substring(0, 4);
  }

  // Update the controller only if the value has changed
  timeController.value = TextEditingValue(
    text: newValue,
    selection: TextSelection.collapsed(offset: newValue.length),
  );
}

void _validateTime(TextEditingController timeController, FocusNode focusNode, Function(DateTime?) onTimeChanged, DateTime? timeLowerLimit, DateTime? timeUpperLimit) {
  String timeText = timeController.text;

  // Split the input into hours and minutes using the colon
  List<String> timeParts = timeText.split(':');

  if (timeParts.length == 2) {
    String hours = timeParts[0];
    String minutes = timeParts[1];

    // Ensure hours are valid (0-23)
    if (hours.length == 1) {
      hours = '0$hours'; // Add leading zero if necessary
    }
    int hourValue = int.parse(hours);
    if (hourValue > 23) {
      hours = '23'; // Cap hours at 23
    }

    hours = hourValue.clamp(timeLowerLimit?.hour ?? 00, timeUpperLimit?.hour ?? 23).toString();

    if (hours.length == 1) {
      hours = '0$hours';
    }

    if (minutes.isEmpty) {
      minutes = '00';
    }

    // Ensure minutes are valid (0-59)
    if (minutes.length == 1) {
      minutes = '0$minutes'; // Add leading zero if necessary
    }
    int minuteValue = int.parse(minutes);
    if (minutes.isNotEmpty) {
      if (minuteValue > 59) {
        minutes = '59'; // Cap minutes at 59
      }
    }

    if (hourValue == timeLowerLimit?.hour) {
      minutes = minuteValue.clamp(timeLowerLimit?.minute ?? 00, timeUpperLimit?.minute ?? 59).toString();
    }

    if (minutes.length == 1) {
      minutes = '0$minutes';
    }

    // Combine the hours and minutes into the final valid time
    String validatedTime = '$hours:$minutes';
    onTimeChanged(DateTime(0, 0, 0, int.parse(hours), int.parse(minutes)));

    // Update the text field with the validated time
    timeController.value = TextEditingValue(
      text: validatedTime,
    );
  } else if (timeParts.length == 1 && timeParts[0].isNotEmpty) {
    // If the user entered only the hours (no colon), auto-complete with ":00"
    String hours = timeParts[0].length == 1 ? '0${timeParts[0]}' : timeParts[0];
    hours = int.parse(hours.replaceAll(':', '').isEmpty ? '00' : hours.replaceAll(':', '')).clamp(timeLowerLimit?.hour ?? 00, timeUpperLimit?.hour ?? 23).toString();
    hours = hours.length == 1 ? '0$hours' : hours;
    String validatedTime = '$hours:00';
    onTimeChanged(DateTime(0, 0, 0, int.parse(hours), 00));

    timeController.value = TextEditingValue(
      text: validatedTime,
    );
  } else {
    // If the input is invalid or empty, reset the input
    timeController.clear();
  }
  focusNode.unfocus();
}