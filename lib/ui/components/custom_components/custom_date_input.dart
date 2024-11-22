import 'package:flutter/material.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDateInput extends StatefulWidget {
  const CustomDateInput({
    super.key,
    required this.title,
    this.endTitle,
    this.date,
    this.endDate,
    required this.useTime,
    this.allowChangeUseTime = false,
    required this.onSelected,
    required this.theme,
    this.mode = CustomDatePickerMode.single
  });
  
  final String title;
  final String? endTitle;
  final DateTime? date;
  final DateTime? endDate;
  final CustomDatePickerMode mode;
  final Function(List<DateTime>) onSelected;
  final StylesGetters theme;
  final bool useTime;
  final bool allowChangeUseTime;

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {

  DateTime date = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    if (widget.date != null) {
      date = widget.date!;
    } if (widget.endDate != null) {
      endDate = widget.endDate!;
    } 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          CustomDatePickerResult? result = await AppDate.pickDate(
            context, 
            useTime: widget.useTime, 
            initialDate: date, 
            initialEndDate: widget.mode == CustomDatePickerMode.single 
            ? null 
            : endDate, 
            allowChangeUseTime: widget.allowChangeUseTime,
            mode: widget.mode
          );
          if (result != null) {
            if (result.selectedDates.isNotEmpty) {
              date = result.selectedDates.first;
              endDate = result.selectedDates.length > 1
                ? result.selectedDates.last 
                : date.add(const Duration(hours: 1));
              setState(() {});
              await widget.onSelected(result.selectedDates);
            }
          } 
        },
        child: Container(
          height: widget.mode == CustomDatePickerMode.single 
            ? 45
            : 80,
          padding: const EdgeInsets.only(left: 10, right: 6, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: widget.theme.surface,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onSurface),
                  ),
                  FutureBuilder(
                    future: AppDate.formatIso8601StringToPreferedDateFormatString(date.toIso8601String(), widget.useTime), 
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: widget.theme.primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            child: Text(
                              snapshot.data ?? date.toIso8601String(),
                              style: widget.theme.bodyMedium
                                .copyWith(color: widget.theme.onPrimary),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  ),
                ],
              ),
              if (widget.mode == CustomDatePickerMode.range)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.endTitle ?? widget.title,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onSurface),
                    ),
                    FutureBuilder(
                      future: AppDate.formatIso8601StringToPreferedDateFormatString(endDate.toIso8601String(), widget.useTime), 
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                              color: widget.theme.primary,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              child: Text(
                                snapshot.data ?? endDate.toIso8601String(),
                                style: widget.theme.bodyMedium
                                  .copyWith(color: widget.theme.onPrimary),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    ),
                  ],
                ),
            ],
          )
        ),
      ),
    );
  }
}