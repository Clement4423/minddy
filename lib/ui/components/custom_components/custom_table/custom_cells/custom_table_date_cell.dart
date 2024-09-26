import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableDateCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableDateCell({super.key, required this.initialValue, required this.theme, required this.cellHeight, required this.cellWidth, required this.controller}) {
    data = initialValue;
  }

  final String? initialValue;

  final double cellHeight;
  final double cellWidth;

  final CustomTableController controller;

  final StylesGetters theme;

  @override
  var data = '';

  @override
  State<CustomTableDateCell> createState() => _CustomTableDateCellState();
}

class _CustomTableDateCellState extends State<CustomTableDateCell> {

  bool isHovering = false;

  CustomDatePickerMode datePickerMode = CustomDatePickerMode.single; 

  bool isStartEndDate() {
    if (widget.data == null || widget.data as String == '') {
      return false;
    }

    String date = widget.data as String;

    return date.contains('_');
  } 

  Future<String> formatDateInAUserFriendlyWay() async {
    if (widget.data == null ) {
      return '';
    }
    String dateAsString = widget.data as String;
    
    if (dateAsString == '') {
      return '';
    }

    bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;

    if (isStartEndDate()) {
      if (dateAsString.split('_').length != 2) {
        return '';
      }

      String? firstDateInPreferedFormat = await AppDate.formatIso8601StringToPreferedDateFormatString(dateAsString.split('_').first);
      String? endDateInPreferedFormat = await AppDate.formatIso8601StringToPreferedDateFormatString(dateAsString.split('_').last);

      DateTime? firstDate = await AppDate.formatDateWithTheCorrectOrder(
        firstDateInPreferedFormat!,
        true
      );

      DateTime? endDate = await AppDate.formatDateWithTheCorrectOrder(
        endDateInPreferedFormat!,
        true
      );

      String firstDateAsString = await getDateString(firstDate, useUsFormat);
      String endDateAsString = await getDateString(endDate, useUsFormat);

      return "${S.current.projects_module_spreadsheet_date_from_text} $firstDateAsString \n${S.current.projects_module_spreadsheet_date_to_text} $endDateAsString";
    } else {
      DateTime? date = AppDate.formatDateAsDateTime(widget.data);

      return _getDateWithMonthName(date, useUsFormat); 
      // No need to use getDateString, because it crop the date month nale if it is too long, 
      // which is used when there is two dates, in which case, the 'from' and 'to' words will be added.
    }
  }

  Future<String> getDateString(DateTime? date, bool useUsFormat) async {
    if (date == null) {
      return '';
    }

    String time = '';

    if (date.hour != 0 || date.minute != 0) {
      time = '${AppDate.padIfNecessary(date.hour)}:${AppDate.padIfNecessary(date.minute)}';
    }

    if (DateFormat('MMMM').format(date).length >= (time.isEmpty ? 8 : 5)) {

      String? finalDate = await AppDate.formatIso8601StringToPreferedDateFormatString(
        AppDate.formatDateAsString(date),
        false
      );
      finalDate = '$finalDate${ time.isNotEmpty ? ', $time' : ''}';
      return finalDate.replaceAll('-', '/');
    }
    else {
      return _getDateWithMonthName(date, useUsFormat);
    }
  }

  String _getDateWithMonthName(DateTime? date, bool useUsFormat) {
    String newString = widget.data;
    String time = '';
    if (date != null) {
      if (date.hour != 0 || date.minute != 0) {
        time = '${AppDate.padIfNecessary(date.hour)}:${AppDate.padIfNecessary(date.minute)}';
      }
      if (useUsFormat) {
        newString = '${DateFormat('MMMM').format(date)} ${date.day} ${date.year}${ time.isNotEmpty ? ', $time' : ''}';
      } else {
        newString = '${date.day} ${DateFormat('MMMM').format(date)} ${date.year}${ time.isNotEmpty ? ', $time' : ''}';
      }
    }
    return newString;
  }

  @override
  void initState() {
    if (isStartEndDate()) {
      datePickerMode = CustomDatePickerMode.range;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
          final DateTime? startDate = AppDate.formatDateAsDateTime(widget.data.toString().split('_').first);
          final DateTime? endDate = AppDate.formatDateAsDateTime(widget.data.toString().split('_').last);

          CustomDatePickerResult? result = await AppDate.pickDate(
            context, 
            mode: datePickerMode,
            initialDate: startDate,
            initialEndDate: endDate,
            useTime: startDate?.hour != 00 || startDate?.minute != 0 || endDate?.hour != 0 || endDate?.minute != 0
          );
        
          if (result != null) {
            if (result.selectedDates.isEmpty) {
              widget.data = null;
            } else if (datePickerMode == CustomDatePickerMode.range) {
              if (result.selectedDates.length < 2) {
                widget.data = null;
                return;
              }
              String? startDateAsString = AppDate.formatDateAsString(result.selectedDates.first);
              String? endDateAsString = AppDate.formatDateAsString(result.selectedDates.last);

              String formattedString = '${startDateAsString}_$endDateAsString';

              widget.data = formattedString;
            } else {
              String? resultAsString = AppDate.formatDateAsString(result.selectedDates.first);
              widget.data = resultAsString;
            }
          }
        if (context.mounted) {
          setState(() {});
        } else {
          widget.controller.saveCells();
        }    
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FutureBuilder<String>(
                future: formatDateInAUserFriendlyWay(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      snapshot.data ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
                      textAlign: TextAlign.right,
                    ),
                  );
                },
              ),
            ),
            if (isHovering)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: isHovering ? 0.8 : 0.9,
                      end: isHovering ? 0.9 : 0.8,
                    ),
                    duration: const Duration(milliseconds: 100),
                    builder: (context, size, child) {
                      return Transform.scale(
                        scale: size,
                        child: IconButton(
                          onPressed: () {
                            if (datePickerMode == CustomDatePickerMode.single) {
                              if (widget.data != null && widget.data as String != '') {
                                DateTime? endDate = AppDate.formatDateAsDateTime(widget.data);
                                endDate!.add(const Duration(hours: 1));
                                widget.data = '${widget.data}_${endDate.toIso8601String()}';
                              }
                              datePickerMode = CustomDatePickerMode.range;
                            } else {
                              if (widget.data != null && widget.data as String != '') {
                                widget.data = widget.data.toString().split('_').first;
                              }
                              datePickerMode = CustomDatePickerMode.single;
                            }
                            setState(() {});
                          }, 
                          tooltip: datePickerMode == CustomDatePickerMode.range 
                            ? S.of(context).projects_module_spreadsheet_date_single_tooltip 
                            : S.of(context).projects_module_spreadsheet_date_start_end_tooltip,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(widget.theme.primary),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                            elevation: const WidgetStatePropertyAll(8)
                          ),
                          icon: Icon(datePickerMode == CustomDatePickerMode.range ? Icons.calendar_today_rounded : Icons.calendar_month_rounded, color: widget.theme.onPrimary)
                        ),
                      );
                    }
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}