import 'package:flutter/foundation.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';

class AppNotes {

  static const String _notesFilePath = "ressources/notes/notes.json";

  static const Map<String, dynamic> _defaultNotesFileContent = {
    "notes" : [], 
  };

  static Future<bool> addNote(dynamic noteToAdd) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile();
      List<dynamic> notes = fileContent["notes"];

      if (noteToAdd is String || noteToAdd is List) {
        notes.add(noteToAdd);
      } else if (noteToAdd is Map) {
        if (noteToAdd.keys.contains('code')) {
          notes.add({'code' : noteToAdd['code'], 'language': noteToAdd['language']});
        } else {
          notes.add({'url': noteToAdd['url'], "description": noteToAdd['description']});
        }
      }

      bool savedFile = await _saveNotesFile(fileContent);
      return savedFile;
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - addNote");
      return false;
    }

  }

static Future<bool> deleteNote(dynamic noteToRemove) async {
  Map<String, dynamic> fileContent = await _openNotesFile();
  List<dynamic> notes = fileContent["notes"];

  if (noteToRemove is String) {
    notes.remove(noteToRemove);
  } else if (noteToRemove is List) {
    notes.removeWhere((element) => element is List && listEquals(element, noteToRemove));
  } else if (noteToRemove is Map) {
    if (noteToRemove.containsKey('code')) {
      notes.removeWhere((element) {
        if (element is Map && element.containsKey('code') && element['code'] == noteToRemove['code']) {
          return true;
        }
        return false;
      });
    } else {
      notes.removeWhere((element) {
        if (element is Map && element.containsKey('url') && element['url'] == noteToRemove['url']) {
          return true;
        }
        return false;
      });
    }

  }

  bool savedFile = await _saveNotesFile(fileContent);
  return savedFile;
}



  static Future<List<dynamic>> getNotes() async {
    Map<String, dynamic> fileContent = await _openNotesFile();
    List<dynamic> notes = fileContent["notes"];
    return notes;
  }

  static Future<Map<String, dynamic>> _openNotesFile() async {
    Map<String, dynamic>? allNotes = await StaticVariables.fileSource.readJsonFile(_notesFilePath);
    if (allNotes != null) {
      return allNotes;
    }
    else {
      await _createNotesFile();
      return _defaultNotesFileContent;
    }
  }

  static Future<void> _createNotesFile() async {
    await StaticVariables.fileSource.createFile(_notesFilePath);
    await StaticVariables.fileSource.writeJsonFile(_notesFilePath, _defaultNotesFileContent);
  }
  
  static Future<bool> _saveNotesFile(Map<String, dynamic> newContent) async {
    return await StaticVariables.fileSource.writeJsonFile(_notesFilePath, newContent);
  }
}