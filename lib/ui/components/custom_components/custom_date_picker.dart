import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/custom_components/custom_date_picker_day_container.dart';
import 'package:minddy/ui/components/custom_components/custom_date_picker_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.title,
    required this.onSelected,
    this.initialStartDate,
    this.initialEndDate,
    this.mode = CustomDatePickerMode.single,
    this.useTime = false,
    this.allowChangeUseTime = true
  });

  final String title;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final CustomDatePickerMode mode;
  final Function(CustomDatePickerResult?) onSelected;
  final bool useTime;
  final bool allowChangeUseTime;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  bool useTime = false;
  late DateTime _currentMonth;
  late DateTime _endMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialStartDate ?? DateTime.now();
    _endMonth = widget.initialEndDate ?? DateTime.now();
    if (widget.initialStartDate != null) {
      _startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      _endDate = widget.initialEndDate;
    }
    useTime = widget.useTime;
    if (useTime) {
      _startTime = _startDate;
      _endTime = _endDate;
    }
  }

  Widget _buildCalendar(DateTime month, bool isEndDate, StylesGetters theme) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMonthYearSelector(month, isEndDate, theme),
          const SizedBox(height: 8),
          _buildDayHeaders(theme),
          SizedBox(
            height: 300,
            child: _buildCalendarDays(month, isEndDate, theme),
          ),
        ],
      ),
    );
  }

  void _nextMonth(bool isEndDate, {int? newDay}) {
    late DateTime newCurrentMonth;

    if (isEndDate) {
      if (_endMonth.month == DateTime.december) {
        newCurrentMonth = DateTime(_endMonth.year + 1, 1, newDay ?? _endMonth.day);
      }

      newCurrentMonth = DateTime(_endMonth.year, _endMonth.month + 1, newDay ?? _endMonth.day);
    } else {
      if (_currentMonth.month == DateTime.december) {
        newCurrentMonth = DateTime(_currentMonth.year + 1, 1, newDay ?? _currentMonth.day);
      }

      newCurrentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, newDay ?? _currentMonth.day);
    }
    
    setState(() {
      if (isEndDate) {
        _endMonth = newCurrentMonth;
      } else {
        _currentMonth = newCurrentMonth;
      }
    });
  }

  void _previousMonth(bool isEndDate ,{int? newDay}) {
    late DateTime newCurrentMonth;

    if (isEndDate) {
      if (_currentMonth.month == DateTime.january) {
        newCurrentMonth = DateTime(_endMonth.year - 1, 12, newDay ?? _endMonth.day);
      }

      newCurrentMonth = DateTime(_endMonth.year, _endMonth.month - 1, newDay ?? _endMonth.day);
    } else {
      if (_currentMonth.month == DateTime.january) {
        newCurrentMonth = DateTime(_currentMonth.year - 1, 12, newDay ?? _currentMonth.day);
      }

      newCurrentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, newDay ?? _currentMonth.day);
    }
  
    setState(() {
      if (isEndDate) {
        _endMonth = newCurrentMonth;
      } else {
        _currentMonth = newCurrentMonth;
      }
    });
  }

  Widget _buildMonthYearSelector(DateTime month, bool isEndDate, StylesGetters theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          type: MaterialType.transparency,
          child: SizedBox(
            width: 150,
            height: 40,
            child: CustomSelectionMenu(
              theme: theme, 
              buttonStyle: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 7, right: 4)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                elevation: const WidgetStatePropertyAll(0)
              ),
              menuMaxHeight: 300,
              enableSearch: true,
              items: List.generate(12, (index) {
                  return CustomSelectionMenuItem(
                    label: DateFormat('MMMM')
                      .format(DateTime(2024, index + 1))
                      .replaceFirst(
                        DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first, 
                        DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first.toUpperCase()
                      ),
                    labelStyle: theme.bodyMedium.copyWith(color: index + 1 == DateTime.now().month && month.year == DateTime.now().year ? DefaultAppColors.blue.color : theme.onPrimary),
                    icon: null,
                    onTap: () {
                      setState(() {
                        if (isEndDate) {
                          _endMonth = DateTime(month.year, index + 1, 1);
                        } else {
                          _currentMonth = DateTime(month.year, index + 1, 1);
                        }
                      });
                    }
                  );
                },
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                     DateFormat('MMMM')
                      .format(DateTime(2024, month.month))
                      .replaceFirst(
                        DateFormat('MMMM').format(DateTime(2024, month.month)).characters.first, 
                        DateFormat('MMMM').format(DateTime(2024, month.month)).characters.first.toUpperCase()
                      ),
                      style: theme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: theme.onPrimary,
                  )
                ],
              )
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: SizedBox(
            width: 120,
            height: 40,
            child: CustomSelectionMenu(
              theme: theme, 
              buttonStyle: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 7, right: 4)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                elevation: const WidgetStatePropertyAll(0)
              ),
              menuMaxHeight: 300,
              enableSearch: true,
              items: List.generate(
                (DateTime(2300).year) - (DateTime(1900).year) + 1,
                (index) {
                  int year = (DateTime(1900).year) + index;
                  return CustomSelectionMenuItem(
                    label: year.toString(),
                    labelStyle: theme.bodyMedium.copyWith(color: year == DateTime.now().year ? DefaultAppColors.blue.color : theme.onPrimary),
                    icon: null,
                    onTap: () {
                      setState(() {
                        if (isEndDate) {
                          _endMonth = DateTime(year, month.month, 1);
                        } else {
                          _currentMonth = DateTime(year, month.month, 1);
                        }
                      });
                    }
                  );
                },
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      month.year.toString(),
                      style: theme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: theme.onPrimary,
                  )
                ],
              )
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeaders(StylesGetters theme) {
    List<String> daysAsStrings = [];
    for (int i = 0; i < 7; i++) {
      daysAsStrings.add(
        DateFormat('EEE')
          .format(DateTime(2024, 1, i + 1))
          .replaceFirst(
            DateFormat('EEE').format(DateTime(2024, 1, i + 1)).characters.first, 
            DateFormat('EEE').format(DateTime(2024, 1, i + 1)).characters.first.toUpperCase()
          )
      );
    }
    return Row(
      children: daysAsStrings.map((day) => 
        Expanded(
          child: Center(
            child: Text(
              "${day.substring(0, 3)}.", 
              style: theme.bodyMedium
            )
          )
        )
      ).toList(),
    );
  }

  List<Widget> _buildWeeks(DateTime month, bool isEndDate, StylesGetters theme) {
    List<Widget> weeks = [];
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;
    
    // Calculate days from previous month
    DateTime prevMonth = DateTime(month.year, month.month - 1, 1);
    int daysInPrevMonth = DateTime(month.year, month.month, 0).day;
    List<DateTime> days = [];
    for (int i = daysInPrevMonth - firstWeekday + 2; i <= daysInPrevMonth; i++) {
      days.add(DateTime(prevMonth.year, prevMonth.month, i));
    }

    // Add days of current month
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(DateTime(month.year, month.month, day));
    }

    // Add days from next month
    int remainingDays = 42 - days.length;
    DateTime nextMonth = DateTime(month.year, month.month + 1, 1);
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(nextMonth.year, nextMonth.month, i));
    }

    // Create weeks
    for (int i = 0; i < days.length; i += 7) {
      weeks.add(
        Row(
          children: days.sublist(i, i + 7).map((date) => 
            _buildDayContainer(date, isEndDate, theme, isGreyedOut: date.month != month.month)
          ).toList(),
        )
      );
    }

    return weeks;
  }

  Widget _buildCalendarDays(DateTime month, bool isEndDate, StylesGetters theme) {
    return PageView.builder(
      key: UniqueKey(),
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        Timer.periodic(
          const Duration(milliseconds: 600),
          (timer) {
            if (timer.tick == 1) {
              if (index == 0) {
                _previousMonth(isEndDate);
              } else {
                _nextMonth(isEndDate);
              }
            }
            timer.cancel();
          });
        
      },
      itemCount: 3,
      controller: PageController(initialPage: 1),
      itemBuilder: ((context, index) {
        if (index == 0) {
          DateTime previousMonth = DateTime(month.year, month.month - 1, 1);
          return SingleChildScrollView(child: Column(children: _buildWeeks(previousMonth, isEndDate, theme)));
        } else if (index == 1) {
          return SingleChildScrollView(child: Column(children: _buildWeeks(month, isEndDate, theme)));
        } else {
          DateTime nextMonth = DateTime(month.year, month.month + 1, 1);
          return SingleChildScrollView(child: Column(children: _buildWeeks(nextMonth, isEndDate, theme)));
        }
      })
    );
  }

  bool _isDateSelectable(DateTime date, bool isEndDate) {    
    if (isEndDate) {
      return _startDate == null || date.isAfter(_startDate!);
    } else {
      return _endDate == null 
        || date.isBefore(_endDate!) 
        || date == _endDate
        || widget.mode == CustomDatePickerMode.range && date.isAfter(_endDate!);
    }
  }

  bool _isDateTheSameDay(DateTime date, DateTime? comparedTo) {
    if (comparedTo == null) {
      return false;
    }
    return date.year == comparedTo.year && date.month == comparedTo.month && date.day == comparedTo.day;
  }

  Widget _buildDayContainer(DateTime date, bool isEndDate, StylesGetters theme, {bool isGreyedOut = false}) {
    bool isSelectable = _isDateSelectable(date, isEndDate);
    bool isSelected = _isDateTheSameDay(date, _startDate) || _isDateTheSameDay(date, _endDate);
    bool isInRange = widget.mode == CustomDatePickerMode.range && _isDateInRange(date);
    DateTime now = DateTime.now();
    bool isToday = _isDateTheSameDay(date, now);

    return CustomDatePickerDayContainer(
      theme: theme, 
      date: date, 
      isSelected: isSelected, 
      isSelectable: isSelectable, 
      isGreyedOut: isGreyedOut, 
      isInRange: isInRange, 
      isEndDate: isEndDate, 
      startDate: widget.mode == CustomDatePickerMode.range ? date == _startDate ? _startDate : null : null,
      endDate: widget.mode == CustomDatePickerMode.range ? date == _endDate ? _endDate : null : null,
      isToday: isToday, 
      onSelected: _selectDate,
      onGreyedOutDayClicked: _selectGreyedOutDate,
    );
  }

  bool _isDateInRange(DateTime date) {
    if (_startDate != null && _endDate != null) {
      return date.isAfter(_startDate!) && date.isBefore(_endDate!);
    }
    return false;
  }

  List<DateTime> getDateRange() {
  if (_startDate != null && _endDate != null) {
    List<DateTime> dateRange = [];
    DateTime currentDate = _startDate!;
    while (currentDate.isBefore(_endDate!)) {
      dateRange.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
    dateRange.add(_endDate!);
    return dateRange;
  }
  return [];
}

  void _selectDate(DateTime date, bool isEndDate) {
    setState(() {
      switch (widget.mode) {
        case CustomDatePickerMode.single:
          if (_startDate == date) {
            _startDate = null;
          } else {
            _startDate = date;
          }
          _endDate = null;
          break;
        case CustomDatePickerMode.range:
          if (_startDate != null && _endDate != null) {
            if (date.isAtSameMomentAs(_endDate!) || date.isAtSameMomentAs(_startDate!)) {
              _startDate = date;
              _endDate = date;
              return;
            }
            else if (date.isAfter(_startDate!)) {
              _endDate = date;
              return;
            }
          } 
          
          if (_startDate == null || date.isBefore(_startDate!)) {
            _startDate = date;
            _endDate = date;
          } else if (date == _endDate) {
            _startDate = date;
          } else if (date.isAfter(_startDate!)) {
            _endDate = date;
          } else if (date == _startDate) {
            _startDate = null;
            _endDate = null;
          }
          break;
        }
    });
  }

  void _selectGreyedOutDate(DateTime date, bool isEndDate) {
    if (date.isBefore(_currentMonth)) {
      _previousMonth(isEndDate, newDay: date.day);
    } else if (date.isAfter(_currentMonth)) {
      _nextMonth(isEndDate, newDay: date.day);
    }
    _selectDate(date, isEndDate);
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                   style: theme.titleLarge
                   .copyWith(color: theme.onPrimary)
                ),
              ],
            ),
          ),
          Center(
            child: _buildCalendar(_currentMonth, false, theme)
          ),
          // Bottom
          Row(
            key: UniqueKey(),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _getDatesInputs(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.allowChangeUseTime)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 160,
                          height: 60,
                          child: SwitchTile(
                            useTime, 
                            S.of(context).custom_date_picker_include_hour, 
                            (newValue) {
                              setState(() {
                                useTime = newValue;
                                if (!useTime) {
                                  _startTime = null;
                                  _endTime = null;
                                }
                              });
                            }, 
                            false
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 160,
                        height: 40,
                        child: CustomTextButton(
                          S.of(context).submenu_artilces_image_description_button, 
                          () async {
                            await widget.onSelected(getResults());
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }, 
                          false,
                          false
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CustomDatePickerResult getResults() {
    switch (widget.mode) {
      case CustomDatePickerMode.single:
        if (_startDate != null) {
          _startDate = _startDate!.copyWith(hour: _startTime?.hour, minute: _startTime?.minute);
          return CustomDatePickerResult([_startDate!]);
        }
        
      case CustomDatePickerMode.range:
        if (_startDate != null && _endDate != null) {
          _startDate = _startDate!.copyWith(hour: _startTime?.hour, minute: _startTime?.minute);
          _endDate = _endDate!.copyWith(hour: _endTime?.hour, minute: _endTime?.minute);
          return CustomDatePickerResult(getDateRange());
        }
    }

    return CustomDatePickerResult([]);
  }

  Widget _getDatesInputs() {
    if (widget.mode == CustomDatePickerMode.single) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: CustomDatePickerInput(
          key: UniqueKey(),
          updateStartTime: (value) {
            if (value != null) {
              _startTime = value;
            }
          },
          updateEndTime: (value) {
            if (value != null) {
              _endTime = value;      
            }
          },
          updateWidget: () {
            setState(() {});
          },
          onCompleted: (value) {
            if (value != null) {
              _currentMonth = value;
              _selectDate(value, false);
            }
          }, 
          mode: widget.mode,
          initialValue: _startDate, 
          initialTime: _startTime,
          isEndDate: false,
          startDate: _startDate,
          endDate: _endDate,
          startTime: _startTime,
          endTime: _endTime,
          useTime: useTime
        ),
      );
    } else if (widget.mode == CustomDatePickerMode.range) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          key: UniqueKey(),
          children: [
            CustomDatePickerInput(
              key: UniqueKey(),
              updateStartTime: (value) {
                if (value != null) {
                  _startTime = value;
                }
              },
              updateEndTime: (value) {
                if (value != null) {
                  _endTime = value;
                }
              },
              updateWidget: () {
                setState(() {});
              },
              onCompleted: (value) {
                if (value != null) {
                  _currentMonth = value;
                  _selectDate(value, false);
                }
              }, 
              mode: widget.mode,
              initialValue: _startDate, 
              initialTime: _startTime,
              startDate: _startDate,
              endDate: _endDate,
              startTime: _startTime,
              endTime: _endTime,
              isEndDate: false,
              useTime: useTime
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.arrow_downward_rounded),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10), 
              child: CustomDatePickerInput(
                key: UniqueKey(),
                updateStartTime: (value) {
                  if (value != null) {
                    _startTime = value;
                  }
                },
                updateEndTime: (value) {
                  if (value != null) {
                    _endTime = value;                
                  }
                },
                updateWidget: () {
                  setState(() {});
                },
                onCompleted: (value) {
                  if (value != null) {
                    _endMonth = value;
                    _selectDate(value, true);
                  }
                }, 
                mode: widget.mode,
                initialValue: _endDate, 
                initialTime: _endTime,
                isEndDate: true,
                startDate: _startDate,
                endDate: _endDate,
                startTime: _startTime,
                endTime: _endTime,
                useTime: useTime
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}