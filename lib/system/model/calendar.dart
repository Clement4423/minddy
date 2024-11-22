import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';

class Calendar {
  String name;

  int id;

  Color color;
  bool isPrivate;

  List<CalendarEvent> events;

  Calendar({
    required this.name, 
    required this.id, 
    required this.color, 
    required this.events,
    required this.isPrivate
  });

  List<CalendarEvent> getEventsAndRecurrencesWithin(DateTime start, DateTime end) {
    List<CalendarEvent> eventsWithRecurrences = events.where((event) => event.recurrence != null).toList();

    List<CalendarEvent> eventsWithoutRecurences = events.where((event) => event.recurrence == null).toList();

    List<CalendarEvent> eventsAndRecurrences = [];

    if (eventsWithRecurrences.isEmpty) {
      return events;
    } else {
      for (CalendarEvent event in eventsWithRecurrences) {
        List<CalendarEvent> recurrences = event.generateRecurrences(start, end, true);
        if (recurrences.isNotEmpty) {
          eventsAndRecurrences.addAll(recurrences);
        }
      }
    }

    eventsAndRecurrences.addAll(eventsWithoutRecurences);

    return eventsAndRecurrences;
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      "id": id,
      "color": hslToHex(HSLColor.fromColor(color)),
      "isPrivate": isPrivate,
      "events": events.map((event) => event.toJson()).toList()
    });
  }

  static Calendar? fromJson(String jsonString) {
    try {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      return Calendar(
        name: jsonData['name'],
        id: jsonData['id'],
        color: hexToHsl(jsonData['color']).toColor(),
        isPrivate: jsonData['isPrivate'],
        events: (jsonData['events'] as List)
            .map((eventJson) => CalendarEvent.fromJson(eventJson)!)
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }
}