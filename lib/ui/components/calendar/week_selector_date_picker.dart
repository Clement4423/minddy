import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class WeekSelectorDatePicker extends StatefulWidget {

  const WeekSelectorDatePicker({
    super.key, 
    required this.onWeekSelected,
    required this.selectedWeek,
    required this.selectedYear
  });

  final Function(int week, int year) onWeekSelected;
  final int selectedWeek;
  final int selectedYear;

  @override
  State<WeekSelectorDatePicker> createState() => _WeekSelectorDatePickerState();
}

class _WeekSelectorDatePickerState extends State<WeekSelectorDatePicker> {
  late DateTime _currentMonth;
  int? _hoveredWeek;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  void _changeMonth(int index) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        index,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.transparent,
        child: Column(
          children: [
            _buildMonthSelector(theme),
            const SizedBox(height: 8),
            _buildCalendar(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector(StylesGetters theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 300,
        child: Row(
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
                    padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 14, right: 4)),
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
                        label: intl.DateFormat('MMMM')
                          .format(DateTime(2024, index + 1))
                          .replaceFirst(
                            intl.DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first, 
                            intl.DateFormat('MMMM').format(DateTime(2024, index +1)).characters.first.toUpperCase()
                          ),
                        labelStyle: theme.bodyMedium.copyWith(color: index + 1 == DateTime.now().month && _currentMonth.year == DateTime.now().year ? DefaultAppColors.blue.color : theme.onPrimary),
                        icon: null,
                        onTap: () {
                          _changeMonth(index + 1);
                        }
                      );
                    },
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                         intl.DateFormat('MMMM')
                          .format(DateTime(2024, _currentMonth.month))
                          .replaceFirst(
                            intl.DateFormat('MMMM').format(DateTime(2024, _currentMonth.month)).characters.first, 
                            intl.DateFormat('MMMM').format(DateTime(2024, _currentMonth.month)).characters.first.toUpperCase()
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
                width: 100,
                height: 40,
                child: CustomSelectionMenu(
                  theme: theme, 
                  buttonStyle: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                    padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 7, right: 12)),
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
                      int year = 1900 + index;
                      return CustomSelectionMenuItem(
                        label: year.toString(),
                        labelStyle: theme.bodyMedium.copyWith(color: year == DateTime.now().year ? DefaultAppColors.blue.color : theme.onPrimary),
                        icon: null,
                        onTap: () {
                          setState(() {
                            _currentMonth = DateTime(year, _currentMonth.month);
                          });
                        }
                      );
                    },
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _currentMonth.year.toString(),
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
        ),
      ),
    );
  }

  Widget _buildCalendar(StylesGetters theme) {
    final daysInWeek = intl.DateFormat.E().dateSymbols.NARROWWEEKDAYS;

    final daysInWeekStartingMonday = [...daysInWeek.sublist(1), daysInWeek.first];

    return Column(
      children: [
        // Days of the week headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysInWeekStartingMonday.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: theme.titleMedium.copyWith(
                    color: theme.onPrimary
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        _buildWeeks(theme),
      ],
    );
  }

  Widget _buildWeeks(StylesGetters theme) {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = (firstDayOfMonth.weekday + 6) % 7;
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    final days = <DateTime>[];

    // Fill days from the previous month
    for (int i = firstWeekday; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Fill days of the current month
    for (int i = 0; i < daysInMonth; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i + 1));
    }

    // Fill remaining days to ensure 6 weeks
    while (days.length % 42 != 0) {
      days.add(days.last.add(const Duration(days: 1)));
    }

    final weeks = List.generate(
      days.length ~/ 7,
      (index) => days.sublist(index * 7, (index + 1) * 7),
    );

    return Column(
      children: weeks.asMap().entries.map((entry) {
        final weekIndex = entry.key + 1;
        final week = entry.value;

        return GestureDetector(
          onTap: () {
            final weekNumber = _getWeekOfYear(week.first);
            widget.onWeekSelected(weekNumber, week.first.year);
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredWeek = weekIndex),
            onExit: (_) => setState(() => _hoveredWeek = null),
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 34,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _currentMonth.year == widget.selectedYear && _getWeekOfYear(week.first) == widget.selectedWeek
                  ? theme.secondary.withValues(alpha: 0.5)
                  : _hoveredWeek == weekIndex 
                    ? Colors.blue.withValues(alpha: 0.2) 
                    : null,
              ),
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final DateTime day = week[dayIndex];
                  final bool isFaded = day.month != _currentMonth.month;
              
                  return Expanded(
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: theme.bodyMedium
                          .copyWith(color: isFaded 
                            ? theme.onPrimary.withValues(alpha: 0.5) 
                            : isToday(day) 
                              ? theme.secondary 
                              : theme.onPrimary
                          ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }

  int _getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(firstDayOfYear).inDays;
    return ((daysSinceStartOfYear + firstDayOfYear.weekday) / 7).ceil();
  }
}