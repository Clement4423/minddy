import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/model/project_note_module_category_model.dart';

class AppNotes {

  static final Map<String, List> defaultNotesCategories = {
    "for_later": [S.current.projects_module_notes_for_later_title, Icons.timer_outlined],
    "important": [S.current.projects_module_notes_important_notes_title, Icons.star_border_rounded],
    "private": [S.current.projects_module_notes_private_notes_title, Icons.lock_outline_rounded]
  };

  static Future<void> ensureDefaultCategoriesExist() async {
    try {
      Directory categoriesDirectory = Directory("${StaticVariables.fileSource.documentDirectoryPath}/shared/notes");

      if (!categoriesDirectory.existsSync()) {
        categoriesDirectory.createSync(recursive: true);
      }

      List<FileSystemEntity> content = categoriesDirectory.listSync();

      for (String key in defaultNotesCategories.keys) {
        bool categoryExists = content.any((element) => element is Directory && element.path.split(Platform.isWindows ? '\\' : "/").last == key);
        if (!categoryExists) {
          Directory newCategoryDir = Directory("${categoriesDirectory.path}/$key");
          newCategoryDir.createSync();

          File notesFile = File("${newCategoryDir.path}/notes.json");
          Map<String, dynamic> defaultContent = {
            'category': key,
            'private': key == 'private' ? true : false,
            'notes': []
          };
          await StaticVariables.fileSource.createFile(notesFile.path.substring(StaticVariables.fileSource.documentDirectoryPath.length));
          await StaticVariables.fileSource.writeJsonFile(notesFile.path.substring(StaticVariables.fileSource.documentDirectoryPath.length), defaultContent);
        }
      }
    } catch (e) {
      await AppLogs.writeError(e, "notes.dart - ensureDefaultCategoriesExist");
    }
  }

  static Future<List<ProjectNoteModuleCategoryModel>> getCategories() async {
    try {
      Directory categoriesDirectory = Directory("${StaticVariables.fileSource.documentDirectoryPath}/shared/notes");

      if (!categoriesDirectory.existsSync()) {
        categoriesDirectory.createSync(recursive: true);
      }

      await ensureDefaultCategoriesExist();

      List<FileSystemEntity> content = categoriesDirectory.listSync();

      List<ProjectNoteModuleCategoryModel> models = [];   
      
      for (FileSystemEntity entity in content) {
        if (entity is Directory && !entity.path.split('/').last.startsWith('.')) {
          List? element = defaultNotesCategories[entity.path.split(Platform.isWindows ? '\\' : "/").last];

          String categoryName = entity.path.split(Platform.isWindows ? '\\' : "/").last;

          Map<String, dynamic> fileContent = await _openNotesFile(categoryName);
          models.add(
            ProjectNoteModuleCategoryModel(
              title: element != null ? element.first : categoryName,
              noteCount: await _openCategoryAndCountNotes(categoryName),
              isPrivate: fileContent['private'],
              icon: element != null ? element.last : Icons.account_circle_outlined,
              categoryName: categoryName
            )
          );
        }
      }
      return models;
    } catch (e) {
      await AppLogs.writeError(e, "notes.dart - getCategories");
      return [];
    }
  }

  static Future<bool> deleteCategory(String categoryName) async {
    bool isFileDeleted = await StaticVariables.fileSource.removeFolder('shared/notes/$categoryName');
    return isFileDeleted;
  }

  static Future<bool> newCategory(String categoryName, bool isPrivate) async {
    if (categoryName.isNotEmpty) {
      bool isFileCreated = await StaticVariables.fileSource.createFile('shared/notes/$categoryName/notes.json');
      if (isFileCreated) {
        bool isFileWritten = await StaticVariables.fileSource.writeJsonFile(
          'shared/notes/$categoryName/notes.json', 
          {'category': categoryName, 'private': isPrivate, 'notes': []}
        );
        return isFileWritten;
      }
    }
    return false;
  }

  static Future<bool> renameCategory(String actualCategoryName, String newCategoryName) async {
    if (newCategoryName.isNotEmpty && newCategoryName.length <= 12) {

      Map<String, dynamic> fileContent = await _openNotesFile(actualCategoryName);

      bool isFolderRenamed = await StaticVariables.fileSource.renameFolder('shared/notes/$actualCategoryName', newCategoryName);
      if (isFolderRenamed) {
        fileContent['category'] = newCategoryName;
        
        bool isFileSaved = await _saveNotesFile(fileContent, newCategoryName);
        if (isFileSaved) {
          bool isLastFolderRemoved = await StaticVariables.fileSource.removeFolder('shared/notes/$actualCategoryName');
          return isLastFolderRemoved;
        }
        return false;
      }
    }
    return false;
  }

  static Future<bool> switchIsPrivate(String category, bool newValue) async {
    Map<String, dynamic> fileContent = await _openNotesFile(category);
    fileContent['private'] = newValue;

    bool isSaved = await _saveNotesFile(fileContent, category);
    return isSaved;
  }

  static Future<bool> moveNote(NoteModel noteModel, String destinationCategory) async {
    try {
      bool added = await addNote(noteModel, destinationCategory);
      if (added) {
        bool deleted = await deleteNote(noteModel, noteModel.category);
        return deleted;
      }
      return false;
    } catch (e) {
      await AppLogs.writeError(e, "notes.dart - moveNote");
      return false;
    }
  }

  static Future<bool> duplicateNote(NoteModel noteModel) async {
    try {
      String newId = createUniqueId().toString();

      NoteModel duplicateNote = NoteModel(
        title: "${noteModel.title} (${S.current.system_files_copy_text})",
        id: int.parse(newId),
        category: noteModel.category,
        lastModified: await getCurrentTime(),
        content: noteModel.content,
      );

      return await addNote(duplicateNote, noteModel.category);
    } catch (e) {
      await AppLogs.writeError(e, "notes.dart - duplicateNote");
      return false;
    }
  }


  static Future<int> _openCategoryAndCountNotes(String category) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile(category);
      List<dynamic> notes = fileContent["notes"] ?? [];

      return notes.length;
    } catch (e) {
      await AppLogs.writeError(e, "notes.dart - _openCategoryAndCountNotes");
      return 0;
    }
  }

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

      notes.add(await convertModelToJson(noteToAdd));

      bool savedFile = await _saveNotesFile(fileContent, category);
      return savedFile;
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - addNote");
      return false;
    }
  }

  static Future<bool> modifyNote(NoteModel note) async {
    try {
      Map<String, dynamic> fileContent = await _openNotesFile(note.category);
      List<dynamic> notes = fileContent["notes"] ?? [];

      int noteIndex = notes.indexWhere((element) => element['id'] == note.id);

      if (noteIndex != -1) {
        notes[noteIndex] = await convertModelToJson(note);

        bool savedFile = await _saveNotesFile(fileContent, note.category);
        return savedFile;
      } else {
        return false;
      }
    } catch (e) {
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

  static Future<Map> convertModelToJson(NoteModel noteModel) async {

    return {
      'title': noteModel.title, 
      'id': noteModel.id, 
      'last_modified': await getCurrentTime(),
      'content': _convertNoteContentModelToJson(noteModel.content)
    };
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

  static List<NoteModel> convertJsonToModels(List notes, String category) {
    try {
      List<NoteModel> models = [];
      for (Map note in notes) {
        models.add(NoteModel(
          title: note['title'] ?? "",
          id: note['id'] ?? 0,
          category: category,
          lastModified: note['last_modified'],
          content: getContentModels(note['content']),
        ));
      }
      return models;
    } catch(e) {
      return [];
    }
  }

  static List<NoteContentModel> getContentModels(List content) {
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
    List<NoteModel> models = convertJsonToModels(notes, category);
    return models;
  }

  static Future<Map<String, dynamic>> _openNotesFile(String category) async {
    try {
      Map<String, dynamic>? allNotes = await StaticVariables.fileSource.readJsonFile('shared/notes/$category/notes.json');
      if (allNotes != null) {
        return allNotes;
      } else {
        bool isCreated = await _createNotesFile(category);
        if (isCreated) {
          return await _openNotesFile(category);
        } else {
          return {'category': category, 'private': category == 'private' ? true : false, 'notes': []};
        }
      }
    } catch(e) {
      await AppLogs.writeError(e, "notes.dart - _openNoteFile");
      return {};
    }

  }

  static Future<bool> _createNotesFile(String category) async {
    if (category == 'PROJECT') {
      return true;
    }
    await StaticVariables.fileSource.createFile('shared/notes/$category/notes.json');
    bool isWritten = await StaticVariables.fileSource.writeJsonFile(
      'shared/notes/$category/notes.json', 
      {
        'category': category,
        'private': category == 'private' ? true : false,
        'notes': []
      }
    );
    return isWritten;
  }
  
  static Future<bool> _saveNotesFile(Map<String, dynamic> newContent, String category) async {
    return await StaticVariables.fileSource.writeJsonFile('shared/notes/$category/notes.json', newContent);
  }

  static Future<String> getCurrentTime() async {
    DateTime now = DateTime.now();

    bool preferUsFormat = await AppConfig.getConfigValue("prefer_us_date_format");

    String dateFormat = preferUsFormat ? "MM/dd/yyyy" : "dd/MM/yyyy";

    String formattedDate = DateFormat(dateFormat).format(now);
    
    String formattedTime = DateFormat('HH:mm').format(now);  

    return "$formattedDate $formattedTime";
  }
}