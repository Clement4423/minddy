import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/create_unique_id.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/model/project_note_module_category_model.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/system/projects/get_module_data.dart';

class ProjectsNotesModuleController extends ChangeNotifier implements IProjectModuleController {
  @override
  int id;

  final int _globalId = 0;
  // This globalId is made to ensure that one project can have only one notes list.
  // Otherwise, it would create a note file for each id that is created.
  //
  // We still need to keep the original id, so that the 
  // delete function and duplicate function keep working

  @override
  String projectPath;


  double width = 0;
  double height = 0;

  List<NoteModel> _projectNotes = [];

  List<NoteModel> get projectNotes => _projectNotes;
 
  Function(int) deleteFunction = (int i) {};

  Function(int) duplicateFunction = (int i) {};

  Widget actualView = Container();

  List<ProjectNoteModuleCategoryModel> categories = [];

  ProjectsNotesModuleController({required this.id, required this.projectPath}) {
    getCategories().then((value) => notifyListeners());
    getProjectNotes();
  }

  @override
  Future<bool> savingMethod() async {
    try {
      Map<String, dynamic> notesMap = await _convertModelToJson(_projectNotes, 'PROJECT');
      bool isSaved = await StaticVariables.fileSource.writeJsonFile(
        '$projectPath/${ProjectsModules.notes.name}/$_globalId.json',
        notesMap
      );
      return isSaved;
    } catch(e) {
      await AppLogs.writeError(e, 'projects_modules_note_view_controller.dart - savingMethod');
      return false;
    }
  }

  void viewChanged() {
    notifyListeners();
  }

  Future<void> getCategories() async {
    categories = await AppNotes.getCategories();
    categories.insert(
      0, 
      ProjectNoteModuleCategoryModel(
        title: S.current.projects_module_notes_project_notes_title, 
        categoryName: "PROJECT", 
        isPrivate: false,
        icon: Icons.chair_outlined, 
        noteCount: await getProjectNotes().then((value) => value.length)
      )
    );
  }

  Future<bool> modifyProjectNote(NoteModel updatedNote) async {
  try {
    Map<String, dynamic>? fileContent = await getModuleData(_globalId, ProjectsModules.notes, projectPath);
    if (fileContent != null) {
      List<dynamic> notes = fileContent["notes"] ?? [];

      int noteIndex = notes.indexWhere((element) => element['id'] == updatedNote.id);
      if (noteIndex != -1) {
        notes[noteIndex] = await AppNotes.convertModelToJson(updatedNote);

        bool savedFile = await StaticVariables.fileSource.writeJsonFile(
          "$projectPath/${ProjectsModules.notes.name}/$_globalId.json",
          {
            'category' : 'PROJECT',
            'private': false,
            'notes': notes
          }
        );
        return savedFile;
      } else {
        return false;
      }
    }
    return false;
  } catch (e) {
    await AppLogs.writeError(e, "projects_modules_note_view_controller.dart - modifyProjectNote");
    return false;
  }
}
  
  Future<List<NoteModel>> getProjectNotes() async {
    Map<String, dynamic>? moduleData = await getModuleData(_globalId, ProjectsModules.notes, projectPath);
    if (moduleData != null) {
      List<dynamic> projectNotes = moduleData['notes'] ?? [];

      List<NoteModel> projectNotesModels = AppNotes.convertJsonToModels(projectNotes, "PROJECT");
      _projectNotes = projectNotesModels;
      return projectNotesModels;
    } else {
      await StaticVariables.fileSource.createFile("$projectPath/${ProjectsModules.notes.name}/$_globalId.json");
      await StaticVariables.fileSource.writeJsonFile(
        "$projectPath/${ProjectsModules.notes.name}/$_globalId.json", 
        {
          'category' : 'PROJECT',
          'private': false,
          'notes': []
        }
      );
      return [];
    }
  }

  Future<bool> deleteProjectNote(NoteModel noteToRemove) async {
    try {
      Map<String, dynamic>? fileContent = await getModuleData(_globalId, ProjectsModules.notes, projectPath);
      if (fileContent != null) {
        List<dynamic> notes = fileContent["notes"] ?? [];

        notes.removeWhere((element) => element['id'] == noteToRemove.id);

        bool savedFile = await StaticVariables.fileSource.writeJsonFile(
          "$projectPath/${ProjectsModules.notes.name}/$_globalId.json",
          {
            'category' : 'PROJECT',
            'private': false,
            'notes': notes
          }
        );
        return savedFile;
      }
      return false;
    } catch(e) {
      await AppLogs.writeError(e, "articles_notes.dart - deleteNote");
      return false;
    }
  }

  Future<bool> addProjectNote(NoteModel noteToAdd) async {
    try {
      Map<String, dynamic>? fileContent = await getModuleData(_globalId, ProjectsModules.notes, projectPath);
      if (fileContent != null) {
        List<dynamic> notes = fileContent["notes"] ?? [];

        notes.add(await AppNotes.convertModelToJson(noteToAdd));

        bool savedFile = await StaticVariables.fileSource.writeJsonFile(
          "$projectPath/${ProjectsModules.notes.name}/$_globalId.json",
          {
            'category' : 'PROJECT',
            'private': false,
            'notes': notes
          }
        );
        return savedFile;
      }
      return false;
    } catch(e) {
      await AppLogs.writeError(e, "projects_modules_note_view_controller.dart - addNote");
      return false;
    }
  }

    Future<bool> moveProjectNote(NoteModel noteModel, String destinationCategory) async {
    try {
      bool added = await AppNotes.addNote(noteModel, destinationCategory);
      if (added) {
        bool deleted = await deleteProjectNote(noteModel);
        return deleted;
      }
      return false;
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_note_view_controller.dart - moveProjectNote");
      return false;
    }
  }

  Future<bool> duplicateProjectNote(NoteModel noteModel) async {
    try {
      NoteModel duplicateNote = NoteModel(
        title: "${noteModel.title} (${S.current.system_files_copy_text})",
        id: createUniqueId(),
        category: noteModel.category,
        lastModified: noteModel.lastModified,
        content: noteModel.content,
      );

      return await addProjectNote(duplicateNote);
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_note_view_controller.dart - duplicateProjectNote");
      return false;
    }
  }

  Future<Map<String, dynamic>> _convertModelToJson(List<NoteModel> models, String category) async {
    List<Map> allNotesMap = [];
    for (NoteModel model in models) {
      allNotesMap.add(await AppNotes.convertModelToJson(model));
    }
    return {'category': category, 'private': false, 'notes': allNotesMap};
  }
}
