import 'package:flutter/cupertino.dart';
import 'package:isoweek/isoweek.dart';
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
    required this.wholeDayEvents
  });
}

class CalendarWeekViewPanelController extends ChangeNotifier {
  final double width;
  final double height;
  final int week;
  final int year;
  final Function? onUpdate;
  final int? highlightedEventID;
  final Function? resetHighligthedEvent;

  CalendarWeekViewPanelController({
    required this.width,
    required this.height,
    required this.week,
    required this.year,
    this.onUpdate,
    this.highlightedEventID,
    this.resetHighligthedEvent
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
      allEvents.addAll(calendar.getEventsAndRecurrencesWithin(days.first.subtract(const Duration(days: 1)), days.last.add(const Duration(days: 1)))); 
      // Remove and add one day because the getEventRecurences don't include the rangeStart and rangeEnd
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
                calendar: getEventCalendar(event, calendars),
                overlappingChilds: dailyEvents
                  .where((a) => _isEventWholeDay(a) && a.start.day == event.start.day && a.eventId != event.eventId)
                  .map((e) => CalendarEventWeekViewPreviewModel(
                    event: e, 
                    isOverlapping: true, 
                    calendar: getEventCalendar(e, calendars)
                  )).toList(),
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
    events.sort((a, b) => a.event.start.compareTo(b.event.start));

    List<CalendarEventWeekViewPreviewModel> organizedEvents = [];

    while (events.isNotEmpty) {
      CalendarEventWeekViewPreviewModel baseEvent =
          events.reduce((a, b) => _getEventDuration(a) > _getEventDuration(b) ? a : b);
      baseEvent.isOverlapping = false;

      List<CalendarEventWeekViewPreviewModel> overlappingEvents = events.where((event) {
        return event != baseEvent && isOverlapping(baseEvent, event);
      }).toList();

      overlappingEvents.sort((a, b) => _getEventDuration(b).compareTo(_getEventDuration(a)));

      if (overlappingEvents.isNotEmpty) {
        CalendarEventWeekViewPreviewModel primaryOverlap = overlappingEvents.removeAt(0);
        primaryOverlap.isOverlapping = true;
        primaryOverlap.overlappingChilds = overlappingEvents;
        organizedEvents.add(primaryOverlap);
      }

      organizedEvents.add(baseEvent);

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

  List<DateTime> getWeekDays({required int year, required int weekNumber}) {
    Week week = Week(year: year, weekNumber: weekNumber);
    return week.days;
  }

  void updateUi() {
    notifyListeners();
    if (onUpdate != null) {
      onUpdate!();
    }
  }
}