import 'dart:convert';

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

class CalendarEventRecurence {
  CalendarEventRecurenceType type;
  int interval;

  List<int> happensOn;

  List<DateTime> exludedDates;

  List<CalendarEventRecurrenceReplacement> modifiedDates;

  DateTime? endDate;

  CalendarEventRecurence({required this.type, required this.interval, required this.happensOn, this.exludedDates = const [], this.modifiedDates = const [], required this.endDate});

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
        endDate: map['end_date']
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
          } else {
            modifiedEvent = null;
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
          int dayOfMonth = recurrence!.happensOn.firstWhere((day) => day >= occurrence.day, orElse: () => 1);
          occurrence = DateTime(occurrence.year, occurrence.month + recurrence!.interval, dayOfMonth, occurrence.hour, occurrence.minute);
          break;

        case CalendarEventRecurenceType.yearly:
          int monthOfYear = recurrence!.happensOn.firstWhere((month) => month >= occurrence.month, orElse: () => 1);
          occurrence = DateTime(occurrence.year + recurrence!.interval, monthOfYear, occurrence.day, occurrence.hour, occurrence.minute);
          break;
      }

      isFirstOccurrence = false;
    }

    if (!includeOriginal) {
      recurrences.removeWhere((e) => e.start == start && e.end == end);
    }
    
    return recurrences;
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