import 'package:flutter/cupertino.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';

class CalendarEventWeekViewPreviewModel {
  CalendarEvent event;
  Calendar calendar;
  bool isOverlapping;
  List<CalendarEventWeekViewPreviewModel> overlappingChilds;

  CalendarEventWeekViewPreviewModel({
    required this.event,
    required this.isOverlapping,
    required this.calendar,
    this.overlappingChilds = const [],
  });
}

class CalendarWeekViewDayEventsList {
  int dayIndex;
  List<CalendarEventWeekViewPreviewModel> events;
  List<CalendarEventWeekViewPreviewModel> wholeDayEvents;

  CalendarWeekViewDayEventsList({
    required this.dayIndex,
    required this.events,
    required this.wholeDayEvents,
  });
}

class CalendarWeekViewPanelController extends ChangeNotifier {
  final double width;
  final double height;
  final int week;
  final int year;

  CalendarWeekViewPanelController({
    required this.width,
    required this.height,
    required this.week,
    required this.year
  });

  bool _isEventWholeDay(CalendarEvent event) {
    return event.start.hour == 0 &&
        event.start.minute == 0 &&
        event.end.hour == 23 &&
        event.end.minute == 59;
  }

  Calendar getEventCalendar(CalendarEvent event, List<Calendar> calendars) {
    return calendars.firstWhere((calendar) => calendar.id == event.calendarId);
  }


  Future<List<CalendarWeekViewDayEventsList>> getEvents() async {
    List<DateTime> days = getWeekDays(year: year, weekNumber: week);
    List<Calendar> calendars = await AppCalendar.getCalendars();

    List<CalendarEvent> allEvents = [];
    for (Calendar calendar in calendars) {
      allEvents.addAll(calendar.getEventsAndRecurrencesWithin(days.first, days.last));
    }

    List<CalendarWeekViewDayEventsList> weekEvents = [];
    for (int i = 0; i < days.length; i++) {
      DateTime dayStart = days[i];
      DateTime dayEnd = dayStart.add(const Duration(days: 1));

      List<CalendarEvent> dailyEvents = allEvents.where((event) {
        return event.start.isBefore(dayEnd) && event.end.isAfter(dayStart);
      }).toList();

      List<CalendarEventWeekViewPreviewModel> wholeDayEvents = dailyEvents
          .where(_isEventWholeDay)
          .map((event) => CalendarEventWeekViewPreviewModel(
                event: event,
                isOverlapping: false,
                overlappingChilds: dailyEvents
                  .where((e) => _isEventWholeDay(e) && e.start.day == event.start.day && e.eventId != event.eventId)
                  .map((e) => CalendarEventWeekViewPreviewModel(
                    event: e, 
                    isOverlapping: true, 
                    calendar: getEventCalendar(e, calendars)
                  )).toList(),
                calendar: getEventCalendar(event, calendars)
              ))
          .toList();

      List<CalendarEventWeekViewPreviewModel> hourlyEvents = dailyEvents
          .where((event) => !_isEventWholeDay(event))
          .map((event) => CalendarEventWeekViewPreviewModel(
                event: event,
                isOverlapping: false,
                calendar: getEventCalendar(event, calendars)
              ))
          .toList();

      List<CalendarEventWeekViewPreviewModel> organizedEvents =
          organizeOverlappingEvents(hourlyEvents);

      weekEvents.add(
        CalendarWeekViewDayEventsList(
          dayIndex: i,
          events: organizedEvents,
          wholeDayEvents: wholeDayEvents,
        ),
      );
    }

    return weekEvents;
  }

  List<CalendarEventWeekViewPreviewModel> organizeOverlappingEvents(
      List<CalendarEventWeekViewPreviewModel> events) {
    // Sort events by start time
    events.sort((a, b) => a.event.start.compareTo(b.event.start));

    // Result list to hold organized events
    List<CalendarEventWeekViewPreviewModel> organizedEvents = [];

    while (events.isNotEmpty) {
      // Find the base event with the longest duration
      CalendarEventWeekViewPreviewModel baseEvent =
          events.reduce((a, b) => _getEventDuration(a) > _getEventDuration(b) ? a : b);
      baseEvent.isOverlapping = false;

      // Find overlapping events for this base event
      List<CalendarEventWeekViewPreviewModel> overlappingEvents = events.where((event) {
        return event != baseEvent && isOverlapping(baseEvent, event);
      }).toList();

      // Sort overlapping events by duration
      overlappingEvents.sort((a, b) => _getEventDuration(b).compareTo(_getEventDuration(a)));

      // Set the second-longest event as the primary overlapping one
      if (overlappingEvents.isNotEmpty) {
        CalendarEventWeekViewPreviewModel primaryOverlap = overlappingEvents.removeAt(0);
        primaryOverlap.isOverlapping = true;
        primaryOverlap.overlappingChilds = overlappingEvents;
        organizedEvents.add(primaryOverlap);
      }

      // Add the base event
      organizedEvents.add(baseEvent);

      // Remove the base and all its overlapping events from the pool
      events.removeWhere((event) =>
          event == baseEvent || isOverlapping(baseEvent, event));
    }

    return organizedEvents;
  }

  int _getEventDuration(CalendarEventWeekViewPreviewModel event) {
    return event.event.end.difference(event.event.start).inMinutes;
  }

  bool isOverlapping(CalendarEventWeekViewPreviewModel event1, CalendarEventWeekViewPreviewModel event2) {
    return event1.event.start.isBefore(event2.event.end) ||
        event1.event.end.isAfter(event2.event.start);
  }

  List<DateTime> getWeekDays({
    required int year,
    required int weekNumber,
    int weekStart = DateTime.monday,
  }) {
    DateTime firstDayOfYear = DateTime(year, 1, 1);
    int offsetToStart = (weekStart - firstDayOfYear.weekday + 7) % 7;
    DateTime firstWeekStart = firstDayOfYear.add(Duration(days: offsetToStart));
    DateTime startOfWeek = firstWeekStart.add(Duration(days: (weekNumber - 1) * 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void updateUi() {
    notifyListeners();
  }
}