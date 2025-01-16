import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class WeekSelectorDatePicker extends StatefulWidget {

  const WeekSelectorDatePicker({
    super.key, 
    required this.onWeekSelected,
    required this.selectedWeek,
    required this.selectedYear, 
    required this.events, 
    required this.calendars,
    required this.controller
  });

  final Function(int week, int year) onWeekSelected;
  final CalendarWeekViewController controller;
  final int selectedWeek;
  final int selectedYear;
  final List<CalendarEvent> events;
  final List<Calendar> calendars;

  @override
  State<WeekSelectorDatePicker> createState() => _WeekSelectorDatePickerState();
}

class _WeekSelectorDatePickerState extends State<WeekSelectorDatePicker> {
  late DateTime _currentMonth;
  int? _hoveredWeek;

  @override
  void initState() {
    super.initState();
    _currentMonth = getWeekDays(year: widget.selectedYear, weekNumber: widget.selectedWeek).first;
  }

  List<DateTime> getWeekDays({
    required int year,
    required int weekNumber,
    int weekStart = DateTime.monday,M
  }) {
    DateTime firstDayOfYear = DateTime(year, 1, 1);
    int offsetToStart = (weekStart - firstDayOfYear.weekday + 7) % 7;
    DateTime firstWeekStart = firstDayOfYear.add(Duration(days: offsetToStart));
    DateTime startOfWeek = firstWeekStart.add(Duration(days: (weekNumber - 1) * 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
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
        padding: const EdgeInsets.all(8.0),
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

    List<CalendarEvent> eventsForDays = getAllEventsForDays(days.first, days.last, widget.events);

    return Column(
      children: weeks.asMap().entries.map((entry) {
        final weekIndex = entry.key + 1;
        final week = entry.value;

        return GestureDetector(
          onTap: () async {
            final weekNumber = widget.controller.getWeekNumber(week.first);
            await widget.onWeekSelected(weekNumber, widget.controller.getISOYear(week.first));
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredWeek = weekIndex),
            onExit: (_) => setState(() => _hoveredWeek = null),
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 37,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _currentMonth.year == widget.selectedYear && widget.controller.getWeekNumber(week.first) == widget.selectedWeek
                  ? theme.secondary.withValues(alpha: 0.5)
                  : _hoveredWeek == weekIndex 
                    ? Colors.blue.withValues(alpha: 0.2) 
                    : null,
              ),
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final DateTime day = week[dayIndex];
                  final bool isFaded = day.month != _currentMonth.month;
                  List<CalendarEvent> eventsThisDay = eventsForDays.where((event) => isSameDay(event.start, day) || isSameDay(event.end, day) || isBetweenStartAndEnd(event.start, event.end, day)).toList();

                  List<CalendarEvent> eventsToRemove = [];

                  for (CalendarEvent event in eventsThisDay) { // Day time is set by default to midnight
                    if (event.end.isBefore(day.add(const Duration(minutes: 1)))) { // This avoid events that ends at midnight to be part of the next day.
                      eventsToRemove.add(event);
                    }
                  }

                  if (eventsToRemove.isNotEmpty) {
                    for (CalendarEvent event in eventsToRemove) {
                      eventsThisDay.remove(event);
                    }
                  }
                  
                  return Expanded(
                    child: SizedBox(
                      height: 37,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              '${day.day}',
                              style: theme.bodyMedium
                                .copyWith(color: isFaded 
                                  ? theme.onPrimary.withValues(alpha: 0.5) 
                                  : isToday(day) 
                                    ? theme.secondary 
                                    : theme.onPrimary,
                                  fontWeight: isToday(day) 
                                    ? FontWeight.w700
                                    : FontWeight.w500
                                ),
                            ),
                          ),
                          Positioned(
                            bottom: 2.5,
                            child: _getDayEventPreview(eventsThisDay, widget.calendars, theme)
                          )
                        ],
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }

  bool isBetweenStartAndEnd(DateTime start, DateTime end, DateTime day) {
    return day.isAfter(start) && day.isBefore(end);
  }

  List<CalendarEvent> getAllEventsForDays(DateTime start, DateTime end, List<CalendarEvent> events) {
    List<CalendarEvent> allEvents = [];

    for (CalendarEvent event in events) {
      if (event.recurrence != null) {
        allEvents.addAll(event.generateRecurrences(start.subtract(const Duration(days: 1)), end.add(const Duration(days: 1)), true));
      } else {
        allEvents.add(event);
      }
    }  

    return allEvents;
  }
}

Widget _getDayEventPreview(List<CalendarEvent> eventOfDay, List<Calendar> calendars, StylesGetters theme) {

  List<Calendar> selectedCalendars = [];

  for (CalendarEvent event in eventOfDay) {
    Calendar selectedCalendar = calendars.firstWhere(
      (calendar) => calendar.id == event.calendarId,
      orElse: () => calendars.first,
    );
    if (!selectedCalendars.contains(selectedCalendar)) {
      selectedCalendars.add(selectedCalendar);
    }
  }

  if (selectedCalendars.isEmpty) {
    return const SizedBox.shrink();
  }

  if (selectedCalendars.length > 4) {
    selectedCalendars = selectedCalendars.sublist(0, 4);
  }

  if (selectedCalendars.length == 1) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selectedCalendars.first.color,
      ),
    );
  } else {
    List<Widget> circles = [];
    double overlap = 3.0;

    for (int i = 0; i < selectedCalendars.length; i++) {
      circles.add(Positioned(
        left: i * (7 - overlap),
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedCalendars[i].color,
          ),
        ),
      ));
    }

    double totalWidth = 7 + (selectedCalendars.length - 1) * (7 - overlap);

    return SizedBox(
      width: totalWidth,
      height: 7,
      child: Stack(
        children: circles,
      ),
    );
  }
}