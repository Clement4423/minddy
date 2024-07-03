import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/components/custom_components/custom_date_picker_day_container.dart';
import 'package:minddy/ui/components/custom_components/custom_input_date_picker.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.title,
    required this.onSelected,
    this.initialStartDate,
    this.initialEndDate,
    this.mode = CustomDatePickerMode.single,
  });

  final String title;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final CustomDatePickerMode mode;
  final Function(CustomDatePickerResult?) onSelected;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _currentMonth;
  late DateTime _endMonth;
  DateTime? _startDate;
  DateTime? _endDate;

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
  }

  Widget _buildCalendar(DateTime month, bool isEndDate, StylesGetters theme) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.mode == CustomDatePickerMode.startEnd)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                isEndDate ? S.current.custom_date_picker_end : S.current.custom_date_picker_start,
                style: theme.titleMedium.copyWith(color: theme.onPrimary),
              ),
            ),
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
        DropdownButton<int>(
          value: month.month,
          style: theme.bodyMedium.copyWith(color: theme.onPrimary),
          borderRadius: BorderRadius.circular(13),
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          items: List.generate(12, (index) {
            return DropdownMenuItem(
              value: index + 1,
              child: Text(
                DateFormat('MMMM')
                .format(DateTime(2024, index + 1))
                .replaceFirst(
                  DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first, 
                  DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first.toUpperCase()
                ), style: theme.bodyMedium.copyWith(color: index + 1 == DateTime.now().month && month.year == DateTime.now().year ? theme.error : theme.onPrimary),
              ),
            );
          }),
          onChanged: (value) {
            setState(() {
              if (isEndDate) {
                _endMonth = DateTime(month.year, value!, 1);
              } else {
                _currentMonth = DateTime(month.year, value!, 1);
              }
            });
          },
        ),
        DropdownButton<int>(
          value: month.year,
          style: theme.bodyMedium,
          borderRadius: BorderRadius.circular(13),
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          items: List.generate(
            (DateTime(2300).year) - (DateTime(1900).year) + 1,
            (index) {
              int year = (DateTime(1900).year) + index;
              return DropdownMenuItem(
                value: year, 
                child: Text(
                  year.toString(), 
                  style: theme.bodyMedium.copyWith(color: year == DateTime.now().year ? theme.error : theme.onPrimary),
                )
              );
            },
          ),
          onChanged: (value) {
            setState(() {
              if (isEndDate) {
                _endMonth = DateTime(value!, month.month, 1);
              } else {
                _currentMonth = DateTime(value!, month.month, 1);
              }
            });
          },
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
            child: Text(day.substring(0, 3), style: theme.bodyMedium)
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
    if (widget.mode != CustomDatePickerMode.startEnd) return true;
    
    if (isEndDate) {
      return _startDate == null || date.isAfter(_startDate!);
    } else {
      return _endDate == null || date.isBefore(_endDate!);
    }
  }

  Widget _buildDayContainer(DateTime date, bool isEndDate, StylesGetters theme, {bool isGreyedOut = false}) {
    bool isSelectable = _isDateSelectable(date, isEndDate);
    bool isSelected = (widget.mode == CustomDatePickerMode.startEnd)
        ? (isEndDate ? date == _endDate : date == _startDate)
        : (date == _startDate || date == _endDate);
    bool isInRange = widget.mode == CustomDatePickerMode.range && _isDateInRange(date);
    DateTime now = DateTime.now();
    bool isToday = date.day == now.day && date.month == now.month && date.year == now.year;

    return CustomDatePickerDayContainer(
      theme: theme, 
      date: date, 
      isSelected: isSelected, 
      isSelectable: isSelectable, 
      isGreyedOut: isGreyedOut, 
      isInRange: isInRange, 
      isEndDate: isEndDate, 
      startDate: widget.mode == CustomDatePickerMode.startEnd ? date == _startDate ? _startDate : null : null,
      endDate: widget.mode == CustomDatePickerMode.startEnd ? date == _endDate ? _endDate : null : null,
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
    while (currentDate.isBefore(_endDate!) || currentDate.day == _endDate!.day && currentDate.month == _endDate!.month && currentDate.year == _endDate!.year) {
      dateRange.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
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
          if (_startDate == null || _endDate != null || date.isBefore(_startDate!)) {
            if (_startDate == date) {
              _startDate = null;
            } else {
              _startDate = date;
            }
            _endDate = null;
          } else {
            if (date == _startDate) {
              _endDate = null;
              _startDate = null;
            } else {
              _endDate = date;
            }
          }
          break;
        case CustomDatePickerMode.startEnd:
          if (isEndDate) {
            if (_endDate == date || _startDate != null && date.isBefore(_startDate!)) {
              _endDate = null;
            } else {
              _endDate = date;
            }
          } else {
            if (_startDate == date || _endDate != null && date.isAfter(_endDate!)) {
              _startDate = null;
            } else {
              _startDate = date;
            }
            
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
      width: widget.mode == CustomDatePickerMode.startEnd ? 750 : 400,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
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
          // Main part : Calendar view
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalendar(_currentMonth, false, theme),
              if (widget.mode == CustomDatePickerMode.startEnd)
                // Separator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 4,
                    height: 300,
                    decoration: BoxDecoration(
                      color: theme.primary,
                      borderRadius: BorderRadius.circular(2)
                    ),
                  ),
                ),
              if (widget.mode == CustomDatePickerMode.startEnd)
                _buildCalendar(_endMonth, true, theme),
            ],
          ),
          // Bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _getDatesInputs(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 140,
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
        ],
      ),
    );
  }

  CustomDatePickerResult? getResults() {
    switch (widget.mode) {
      case CustomDatePickerMode.single:
        if (_startDate != null) {
          return CustomDatePickerResult([_startDate!]);
        }
        
      case CustomDatePickerMode.range:
        if (_startDate != null && _endDate != null) {
          return CustomDatePickerResult(getDateRange());
        }
      case CustomDatePickerMode.startEnd:
        if (_startDate != null && _endDate != null) {
          return CustomDatePickerResult([_startDate!, _endDate!]);
        }
    }

    return null;
  }

  Widget _getDatesInputs() {
    if (widget.mode == CustomDatePickerMode.single) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: CustomInputDatePicker(
          key: UniqueKey(),
          onCompleted: (value) {
            if (value != null) {
              _currentMonth = value;
              _selectDate(value, false);
            }
          }, 
          initialValue: _startDate, 
        ),
      );
    } else if (widget.mode == CustomDatePickerMode.range) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomInputDatePicker(
              key: UniqueKey(),
              onCompleted: (value) {
                if (value != null) {
                  _currentMonth = value;
                  _selectDate(value, false);
                }
              }, 
              initialValue: _startDate, 
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.arrow_downward_rounded),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10), 
              child: CustomInputDatePicker(
                key: UniqueKey(),
                onCompleted: (value) {
                  if (value != null) {
                    _endMonth = value;
                    _selectDate(value, true);
                  }
                }, 
                initialValue: _endDate, 
              ),
            ),
          ],
        ),
      );
    } else if (widget.mode == CustomDatePickerMode.startEnd) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CustomInputDatePicker(
              key: UniqueKey(),
              onCompleted: (value) {
                if (value != null) {
                  _currentMonth = value;
                  _selectDate(value, false);
                }
              }, 
              initialValue: _startDate, 
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.arrow_forward_rounded)
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomInputDatePicker(
                key: UniqueKey(),
                onCompleted: (value) {
                  if (value != null) {
                    _endMonth = value;
                    _selectDate(value, true);
                  }
                }, 
                initialValue: _endDate, 
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}