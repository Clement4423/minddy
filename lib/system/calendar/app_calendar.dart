import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:minddy/generated/l10n.dart';
import 'package:path/path.dart' as path;

import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';

class AppCalendar {

  static String calendarsFolderPath = "shared/calendars";
 
  static Future<List<Calendar>> getCalendars() async {
    List<Calendar> calendars = [];

    try {
      Directory calendarsDirectory = Directory("${StaticVariables.fileSource.documentDirectoryPath}/$calendarsFolderPath");

      if (!calendarsDirectory.existsSync()) {
        calendarsDirectory.createSync(recursive: true);
      }

      List<FileSystemEntity> calendarsFolders = calendarsDirectory.listSync();

      for (FileSystemEntity entity in calendarsFolders) {
        if (entity is Directory) {
          if (path.basename(entity.path).startsWith('.')) {
            continue;
          }
          String fileRelativePath = path.normalize("${entity.path.substring(StaticVariables.fileSource.documentDirectoryPath.length)}/calendar.json");
          Map<String, dynamic>? fileDataMap = await StaticVariables.fileSource.readJsonFile(fileRelativePath);
          Calendar? calendar = Calendar.fromJson(jsonEncode(fileDataMap));
          if (calendar != null) {
            calendars.add(calendar);
          }
        }
      }

      await _cleanCalendarFolders();

      if (calendars.isEmpty) {
        Calendar defaultCalendar = Calendar(
          name: S.current.calendar_main_calendar_name, 
          id: createUniqueId(), 
          color: const Color.fromARGB(255, 40, 122, 222), 
          events: [], 
          isPrivate: false
        );

        await createCalendar(defaultCalendar);

        calendars.add(defaultCalendar);
      }

      return calendars;
    } catch (e) {
      await AppLogs.writeError(e, "app_calendar.dart - getCalendars");
      return calendars;
    }
  }

  /// This function is cleaning the calendars fodler, as at random moments, empty calendar folders are created, creating lags in the app.
  static Future<void> _cleanCalendarFolders() async {
    try {
      Directory calendarsDirectory = Directory("${StaticVariables.fileSource.documentDirectoryPath}/$calendarsFolderPath");

      List<FileSystemEntity> calendarsFolders = calendarsDirectory.listSync();

      for (FileSystemEntity entity in calendarsFolders) {
        if (entity is Directory) {
          if (path.basename(entity.path).startsWith('.')) {
            continue;
          }
          if (File(path.normalize("${entity.absolute.path}/calendar.json")).readAsStringSync().isEmpty) {
            await StaticVariables.fileSource.removeFolder(entity.path.substring(StaticVariables.fileSource.documentDirectoryPath.length));
          }
        }
      }
    } catch (e) {
      await AppLogs.writeError(e, '_cleanCalendarFolders - app_calendar.dart');
      return;
    }
  }

  static Future<bool> createCalendar(Calendar calendar) async {
    String filePath = "$calendarsFolderPath/${calendar.id}/calendar.json";

    await StaticVariables.fileSource.createFile(filePath);

    bool isCreated = await StaticVariables.fileSource.writeJsonFile(filePath, jsonDecode(calendar.toJson()));

    return isCreated;
  }

  static Future<bool> deleteCalendar(Calendar calendar) async {
    String folderPath = "$calendarsFolderPath/${calendar.id}";

    bool isDeleted = await StaticVariables.fileSource.removeFolder(folderPath);

    return isDeleted;
  }

  static Future<bool> addEvent(CalendarEvent event) async {
    try {
      String filePath = "$calendarsFolderPath/${event.calendarId}/calendar.json";

      Map<String, dynamic>? map = await StaticVariables.fileSource.readJsonFile(filePath);

      if (map == null) {
        return false;
      }

      (map["events"] as List).add(event.toJson());

      bool isSaved = await StaticVariables.fileSource.writeJsonFile(filePath, map);

      return isSaved;
    } catch (e) {
      await AppLogs.writeError(e, "app_calendar.dart - addEvent");
      return false;
    }
  }  

  static Future<bool> deleteEvent(CalendarEvent event) async {
    try {
      String filePath = "$calendarsFolderPath/${event.calendarId}/calendar.json";

      Map<String, dynamic>? map = await StaticVariables.fileSource.readJsonFile(filePath);

      if (map == null) {
        return false;
      }

      (map["events"] as List).removeWhere((e) => CalendarEvent.fromJson(e)?.eventId == event.eventId);

      bool isSaved = await StaticVariables.fileSource.writeJsonFile(filePath, map);

      return isSaved;
    } catch (e) {
      await AppLogs.writeError(e, "app_calendar.dart - deleteEvent");
      return false;
    }
  }  
}