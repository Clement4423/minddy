import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/note_model.dart';

class AppNotes {

  static NoteContentModel createNoteContentMap(dynamic element) {
    dynamic data = "";
    NoteElementContentType type = NoteElementContentType.text;

    if (element is String) {
      data = element;
      type = NoteElementContentType.text;
    } else if (element is List) {
      data = element;
      type = NoteElementContentType.list;
    } else if (element is Map) {
      if (element.containsKey('url') && element.containsKey('description')) {
        type = NoteElementContentType.image;
        data = {'url': element['url'], 'description': element['description']};
      } else if (element.containsKey('code') && element.containsKey('language')) {
        type = NoteElementContentType.code;
        data = {'code': element['code'], 'language': element['language']};
      }
    }

    return NoteContentModel(type: type, data: data);
  }

  static Future<bool> addNote(NoteModel noteToAdd, String category) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile(category);
      List<dynamic> notes = fileContent["notes"] ?? [];

      notes.add(_convertModelToJson(noteToAdd));

      bool savedFile = await _saveNotesFile(fileContent, category);
      return savedFile;
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - addNote");
      return false;
    }
  }

  static Future<bool> modifyNote(int id, List<NoteContentModel> content, String title, String category) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile(category);
      List<dynamic> notes = fileContent["notes"] ?? [];

      int noteIndex = notes.indexWhere((element) => element['id'] == id);

      if (noteIndex != -1) {
        notes[noteIndex] = {
          'id': id,
          'content': content,
          'title': title,
        };

        bool savedFile = await _saveNotesFile(fileContent, category);
        return savedFile;
      } else {
        return false;
      }
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - modifyNote");
      return false;
    }
  }

  static Future<bool> deleteNote(NoteModel noteToRemove, String category) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile(category);
      List<dynamic> notes = fileContent["notes"] ?? [];

      notes.removeWhere((element) => element['id'] == noteToRemove.id);

      bool savedFile = await _saveNotesFile(fileContent, category);
      return savedFile;
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - deleteNote");
      return false;
    }
  }

  static Map _convertModelToJson(NoteModel noteModel) {
    return {'title': noteModel.title, 'id': noteModel.id, 'content': _convertNoteContentModelToJson(noteModel.content)};
  }

  static List<Map> _convertNoteContentModelToJson(List<NoteContentModel> content) {
    try {
      List<Map> contentAsMap = [];
      for (NoteContentModel model in content) {
        contentAsMap.add(
          {'type': model.type.index, 'data': model.data}
        );
      }
      return contentAsMap; 
    } catch (e) {
      return [];
    }
  }

  static List<NoteModel> _convertJsonToModels(List notes, String category) {
    try {
      List<NoteModel> models = [];
      for (Map note in notes) {
        models.add(NoteModel(
          title: note['title'] ?? "",
          id: note['id'] ?? 0,
          category: category,
          content: _getContentModels(note['content']),
        ));
      }
      return models;
    } catch(e) {
      return [];
    }
  }

  static List<NoteContentModel> _getContentModels(List content) {
    try {
      List<NoteContentModel> models = [];
      for (Map element in content) {
        models.add(
          NoteContentModel(type: NoteElementContentType.values[element['type']], data: element['data'])
        );
      }
      return models;
    } catch(e) {
      return [];
    }
  }

  static Future<List<NoteModel>> getNotes(String category) async {
    Map<String, dynamic> fileContent = await _openNotesFile(category);
    List<dynamic> notes = fileContent["notes"];
    List<NoteModel> models = _convertJsonToModels(notes, category);
    return models;
  }

  static Future<Map<String, dynamic>> _openNotesFile(String category) async {
    try {
      Map<String, dynamic>? allNotes = await StaticVariables.fileSource.readJsonFile('ressources/notes/$category/notes.json');
      if (allNotes != null) {
        return allNotes;
      } else {
        await _createNotesFile(category);
        return await _openNotesFile(category);
      }
    } catch(e) {
      await AppLogs.writeError(e, "notes.dart - _openNoteFile");
      return {};
    }

  }

  static Future<void> _createNotesFile(String category) async {
    await StaticVariables.fileSource.createFile('ressources/notes/$category/notes.json');
    await StaticVariables.fileSource.writeJsonFile(
      'ressources/notes/$category/notes.json', 
      {
        'category': category,
        'notes': []
      }
    );
  }
  
  static Future<bool> _saveNotesFile(Map<String, dynamic> newContent, String category) async {
    return await StaticVariables.fileSource.writeJsonFile('ressources/notes/$category/notes.json', newContent);
  }
}