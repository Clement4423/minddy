import 'dart:convert';

import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/utils/capitalize_first_letter.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:intl/intl.dart' as intl;

class DueDateInfo {
  bool isCompleted;
  DateTime? completedOn;
  String? completedBy;

  String toJson() {
    return jsonEncode({
      "is_completed": isCompleted,
      "completed_on": completedOn?.toIso8601String(),
      "completed_by": completedBy
    });
  }

  static DueDateInfo? fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);

      return DueDateInfo(
        isCompleted: map['is_completed'], 
        completedOn: DateTime.tryParse(map['completed_on'] ?? ''), 
        completedBy: map['completed_by']
      );
    } catch (e) {
      return null;
    }
  }

  DueDateInfo({required this.isCompleted, required this.completedOn, required this.completedBy});
}

class CalendarEventRecurrenceReplacement {
  DateTime calculatedDate;
  CalendarEvent replacementEvent;

  CalendarEventRecurrenceReplacement({required this.calculatedDate, required this.replacementEvent});

  String toJson() {
    return jsonEncode({
      'calculated_date': calculatedDate.toIso8601String(),
      'replacement_event': replacementEvent.toJson()
    });
  }

  static CalendarEventRecurrenceReplacement? fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);

      return CalendarEventRecurrenceReplacement(
        calculatedDate: DateTime.parse(map['calculated_date']), 
        replacementEvent: CalendarEvent.fromJson(map['replacement_event'])!
      );

    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return {
      'calculated_date': calculatedDate.toIso8601String(),
      'replacement_event': replacementEvent.toJson()
    }.toString();
  }
}

enum CalendarEventRecurenceType {
  daily,
  weekly,
  monthly,
  yearly
}

class CalendarEventRecurenceText{
  final String typeAndInterval;
  final String happensOn;

  CalendarEventRecurenceText({required this.typeAndInterval, required this.happensOn});
}

class CalendarEventRecurence {
  /// The type of event recurence
  /// 
  /// Defines the minimal interval between two dates
  /// 
  /// ex: Every week, every day...
  CalendarEventRecurenceType type;

  /// Defines the interval between the type, 
  /// 
  /// If type is set to daily, and interval is set to 2, recurence will happen every 2 days.
  int interval;

  /// Defines the spefic dates withing which recurences happens.
  /// 
  /// If type is set to monthly, happens on will define on which day it will happen.
  List<int> happensOn;

  /// The list of dates that has been excluded -> If user clicked delete only this instance, the deleted date will be saved in this list.
  List<DateTime> exludedDates;

  /// The list of modified dates -> If user clicked modify only this instance, the replacement instance will be saved in this list.
  List<CalendarEventRecurrenceReplacement> modifiedDates;

  /// The end date of the recurence.
  DateTime? endDate;

  CalendarEventRecurence({required this.type, required this.interval, required this.happensOn, this.exludedDates = const [], this.modifiedDates = const [], required this.endDate});

  /// This will return a string, representing the recurence setup.
  /// 
  /// ex: Every 2 weeks, monday and sunday.
  CalendarEventRecurenceText generateRecurenceText() {
    String typeAndInterval = '';

    switch (type) {
      case CalendarEventRecurenceType.daily:
        typeAndInterval = S.current.calendar_button_event_preview_recurence_text_every_day(interval);
        break;
      case CalendarEventRecurenceType.weekly:
        typeAndInterval = S.current.calendar_button_event_preview_recurence_text_every_week(interval);
        break;
      case CalendarEventRecurenceType.monthly:
        typeAndInterval = S.current.calendar_button_event_preview_recurence_text_every_month(interval);
        break;
      case CalendarEventRecurenceType.yearly:
        typeAndInterval = S.current.calendar_button_event_preview_recurence_text_every_year(interval);
        break;
    }

    String happensOnText = '';

    for (int number in happensOn) {
      switch (type) {
        case CalendarEventRecurenceType.daily:
          happensOnText = '';
          break;
        case CalendarEventRecurenceType.weekly:
          DateTime date = DateTime(2025, 1, 6 + (number - 1));
          String stringDay = intl.DateFormat('EEEE').format(date);
          if (happensOn.indexOf(number) == 0) {
            happensOnText = capitalizeFirstLetter(stringDay);
          } else {
            happensOnText += ', ${capitalizeFirstLetter(stringDay)}';
          }
          break;
        case CalendarEventRecurenceType.monthly:
          String numberPadded = AppDate.padIfNecessary(number);
          if (happensOn.indexOf(number) == 0) {
            happensOnText = numberPadded;
          } else {
            happensOnText += ', $numberPadded';
          }
          break;
        case CalendarEventRecurenceType.yearly:
          DateTime date = DateTime(2025, number, 1);
          String monthName = intl.DateFormat('MMMM').format(date);
          if (happensOn.indexOf(number) == 0) {
            happensOnText = capitalizeFirstLetter(monthName);
          } else {
            happensOnText += ', ${capitalizeFirstLetter(monthName)}';
          }
          break;
      }
    }

    return CalendarEventRecurenceText(
      typeAndInterval: typeAndInterval, 
      happensOn: happensOnText
    );
  }

  String toJson() {
    return jsonEncode({
      'type': type.index,
      'interval': interval,
      'happens_on': happensOn,
      'exluded_dates': exludedDates.map((date) => date.toIso8601String()).toList(),
      'modified_dates': modifiedDates.map((event) => event.toJson()).toList(),
      'end_date': endDate?.toIso8601String(),
    });
  }

  static CalendarEventRecurence? fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);

      return CalendarEventRecurence(
        type: CalendarEventRecurenceType.values.elementAt(map['type']), 
        interval: map['interval'], 
        happensOn: (map['happens_on'] as List).whereType<int>().toList(), 
        exludedDates: (map['exluded_dates'] as List).map((e) => DateTime.parse(e.toString())).toList(),
        modifiedDates: (map['modified_dates'] as List)
            .map((eventJson) => CalendarEventRecurrenceReplacement.fromJson(eventJson)!)
            .toList(),
        endDate: map['end_date'] != null 
          ? DateTime.parse(map['end_date']) 
          : null
      );
      
    } catch (e) {
      return null;  
    }
  } 
}

class CalendarEvent {
  String title;
  int eventId;
  String description;
  DateTime start;
  DateTime end;
  int calendarId;
  CalendarEventRecurence? recurrence;
  bool isDueDate;
  DueDateInfo? dueDateInfo;
  bool isRecurrence;
  CalendarEvent? originalEvent;

  CalendarEvent({
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    required this.calendarId,
    required this.recurrence,
    required this.isDueDate,
    required this.eventId,
    required this.dueDateInfo,
    this.isRecurrence = false,
    this.originalEvent

  });

  bool isSameDay(DateTime date, DateTime date2) {
    return date.year == date2.year && date.month == date2.month && date.day == date2.day;
  }

 List<CalendarEvent> generateRecurrences(DateTime rangeStart, DateTime rangeEnd, [bool includeOriginal = true, bool includeModifiedEvents = true]) {
    assert(recurrence != null, () {
      throw AssertionError("generateRecurrences was called, but event doesn't have a recurrence. Event n°$eventId");
    });

    List<CalendarEvent> recurrences = [];
    recurrence!.happensOn.sort();
    DateTime occurrence = start;
    bool isFirstOccurrence = true;

    while (occurrence.isBefore(rangeEnd) && (recurrence!.endDate == null || occurrence.isBefore(recurrence!.endDate!))) {
      if (occurrence.isAfter(rangeStart) || (includeOriginal && isFirstOccurrence)) {
        bool isExcluded = recurrence!.exludedDates.map((e) => e.isAtSameMomentAs(occurrence)).contains(true);
        if (!isExcluded) {
          CalendarEvent? modifiedEvent = recurrence!.modifiedDates.where((e) => isSameDay(e.calculatedDate, occurrence)).firstOrNull?.replacementEvent;
          if (modifiedEvent != null && includeOriginal) {
            modifiedEvent
              ..isRecurrence = true
              ..originalEvent = this;
            if (recurrence!.endDate != null && modifiedEvent.end.isAfter(recurrence!.endDate!)) {
              return recurrences;
            }
          } else {
            modifiedEvent = null;
          }
          if (recurrence!.endDate != null && occurrence.add(end.difference(start)).isAfter(recurrence!.endDate!)) {
            return recurrences;
          }
          recurrences.add(
            modifiedEvent ?? CalendarEvent(
            title: title,
            description: description,
            start: occurrence,
            end: occurrence.add(end.difference(start)),
            calendarId: calendarId,
            recurrence: recurrence,
            isDueDate: isDueDate,
            dueDateInfo: dueDateInfo,
            eventId: eventId,
            isRecurrence: true,
            originalEvent: this
          ));
        }
      }

      switch (recurrence!.type) {
        case CalendarEventRecurenceType.daily:
          occurrence = occurrence.add(Duration(days: recurrence!.interval));
          break;

        case CalendarEventRecurenceType.weekly:
          int currentWeekday = occurrence.weekday;
          int nextWeekdayIndex = recurrence!.happensOn.indexWhere((day) => day > currentWeekday);
          
          if (nextWeekdayIndex == -1) { 
            occurrence = occurrence.add(Duration(days: 7 * recurrence!.interval - (currentWeekday - recurrence!.happensOn.first)));
          } else { 
            occurrence = occurrence.add(Duration(days: recurrence!.happensOn[nextWeekdayIndex] - currentWeekday));
          }
          break;

        case CalendarEventRecurenceType.monthly:
          int currentDay = occurrence.day;
          int nextDayIndex = recurrence!.happensOn.indexWhere((day) => day > currentDay);

          bool canPassNextMonth = nextDayIndex == -1; // Can pass next month if the last occurence has been created
          int nextOccurrenceMonth = occurrence.month;
          bool needToPassThisDate = false;

          if (canPassNextMonth) {
            nextOccurrenceMonth += recurrence!.interval;
          }

          if (_getNumbersOfDayInMonth(nextOccurrenceMonth, getYearAfterMonthAddition(occurrence.month, recurrence!.interval, occurrence.year)) < (recurrence!.happensOn.elementAt(nextDayIndex == - 1 ? 0 : nextDayIndex))) {
            needToPassThisDate = true;
          }

          if (needToPassThisDate) {
            nextDayIndex = recurrence!.happensOn.indexWhere((day) => day > (recurrence!.happensOn.elementAt(nextDayIndex == - 1 ? 0 : nextDayIndex)));
            canPassNextMonth = nextDayIndex == -1;
          }

          DateTime approximateOccurence = occurrence.add(Duration(days: canPassNextMonth ? 31 * recurrence!.interval - (recurrence!.happensOn.elementAt(nextDayIndex == - 1 ? 0 : nextDayIndex)) - currentDay: (recurrence!.happensOn.elementAtOrNull(nextDayIndex == - 1 ? 100 : nextDayIndex) ?? recurrence!.happensOn.first) - currentDay));
          occurrence = DateTime(approximateOccurence.year, occurrence.month +(canPassNextMonth ? recurrence!.interval : 0), recurrence!.happensOn.elementAt(nextDayIndex == - 1 ? 0 : nextDayIndex), occurrence.hour, occurrence.minute);
          break;
        case CalendarEventRecurenceType.yearly:
          int currentMonth = occurrence.month;
          int nextMonthIndex = recurrence!.happensOn.indexWhere((month) => month > currentMonth);

          bool canPassNextYear = nextMonthIndex == -1;

          DateTime approximateOccurrence = DateTime(
            occurrence.year + (canPassNextYear ? recurrence!.interval : 0),
            canPassNextYear ? recurrence!.happensOn.first : recurrence!.happensOn[nextMonthIndex],
            occurrence.day,
            occurrence.hour,
            occurrence.minute,
          );

          int daysInTargetMonth = _getNumbersOfDayInMonth(approximateOccurrence.month, approximateOccurrence.year);
          int targetDay = occurrence.day;

          bool needToPassThisDate = false;

          if (daysInTargetMonth < targetDay) {
            needToPassThisDate = true;
          }

          if (needToPassThisDate) {
            nextMonthIndex = recurrence!.happensOn.indexWhere((day) => day > (recurrence!.happensOn.elementAt(nextMonthIndex == - 1 ? 0 : nextMonthIndex)));
            canPassNextYear = nextMonthIndex == -1; 
          }

          occurrence = DateTime(
            approximateOccurrence.year,
            approximateOccurrence.month,
            targetDay,
            occurrence.hour,
            occurrence.minute,
          );
          break;
      }

      isFirstOccurrence = false;
    }

    if (!includeOriginal) {
      recurrences.removeWhere((e) => e.start == start && e.end == end);
    }
    
    return recurrences;
  }

  int _getNumbersOfDayInMonth(int month, int year) {
    DateTime selectedYear = DateTime(year);

    List<int> daysPerMonthIndex = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (selectedYear.isLeapYear) {
      daysPerMonthIndex[1] = 29;
    }

    return daysPerMonthIndex[month - 1];
  }

  int getYearAfterMonthAddition(int currentMonth, int monthsToAdd, int currentYear) {
    int newMonthIndex = (currentMonth + monthsToAdd);
    return currentMonth + (newMonthIndex / 12).floor();
  }

  String toJson() {
    return jsonEncode({
      'title': title,
      'description': description,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'calendarId': calendarId,
      'eventId': eventId,
      'recurrence': recurrence?.toJson(),
      'isDueDate': isDueDate,
      'dueDateInfo': dueDateInfo?.toJson()
    });
  }

  static CalendarEvent? fromJson(String jsonString) {
    try {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      return CalendarEvent(
        title: jsonData['title'],
        description: jsonData['description'],
        start: DateTime.parse(jsonData['start']),
        end: DateTime.parse(jsonData['end']),
        calendarId: jsonData['calendarId'],
        recurrence: jsonData['recurrence'] != null 
          ? CalendarEventRecurence.fromJson(jsonData['recurrence'])
          : null,
        isDueDate: jsonData['isDueDate'],
        dueDateInfo: DueDateInfo.fromJson(jsonData['dueDateInfo'] ?? ''),
        eventId: jsonData['eventId']
      );
    } catch (e) {
      return null;
    }
  }

  CalendarEvent copy() {
    return CalendarEvent(
      title: title, 
      description: description, 
      start: start, end: end, 
      calendarId: calendarId, 
      recurrence: recurrence, 
      isDueDate: isDueDate, 
      eventId: eventId, 
      dueDateInfo: dueDateInfo
    );
  }
}