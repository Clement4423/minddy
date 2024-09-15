import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list.dart';
import 'package:minddy/ui/components/custom_components/custom_code_display.dart';
import 'package:minddy/ui/components/custom_components/custom_image_display.dart';
import 'package:minddy/ui/components/custom_components/custom_text_area.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';

class NoteEditingSubMenuController extends ChangeNotifier {
  final NoteModel noteModel;

  final Function? onClosed;

  List<IArticlesWriteElement> noteContentWidgets = [];

  final ProjectsNotesModuleController notesModuleController;

  NoteEditingSubMenuController({required this.noteModel, required this.notesModuleController, this.onClosed});

  Future<bool> saveNote() async {
    List<NoteContentModel> noteContentModelList = [];
    for (IArticlesWriteElement element in noteContentWidgets) {
      NoteContentModel? contentModel = getContentModelFromElementType(element);

      if (contentModel != null) {
        noteContentModelList.add(contentModel);
      }
    }

    noteModel.content = noteContentModelList;


    if (noteModel.category == 'PROJECT') {
      bool isSaved = await notesModuleController.modifyProjectNote(noteModel);
      return isSaved;
    } else {
      bool isSaved = await AppNotes.modifyNote(noteModel);
      return isSaved;
    }
  }

  NoteContentModel? getContentModelFromElementType(IArticlesWriteElement element) {
    NoteContentModel model = AppNotes.createNoteContentMap(element.data);
    return model;
  }

  Future<void> addNoteElement(NoteElementContentType elementType) async {
    await saveNote();
    switch (elementType) {
      case NoteElementContentType.code:
        noteModel.content.add(NoteContentModel(type: elementType, data: {'code': '', 'language': 0}));
        break;
      case NoteElementContentType.text:
        noteModel.content.add(NoteContentModel(type: elementType, data: ''));
        break;
      case NoteElementContentType.image:
        noteModel.content.add(NoteContentModel(type: elementType, data: {'url': '', 'description': ''}));
        break;
      case NoteElementContentType.list:
        noteModel.content.add(NoteContentModel(type: elementType, data: []));
        break;
    }
    notifyListeners();
  }

  Future<void> deleteNoteElement(Key key) async {
    noteContentWidgets.removeWhere((element) => element.key == key);
    await saveNote();
    notifyListeners();
  }

  Future<bool> moveNote(String destinationCategory) async {
    try {
      if (noteModel.category == 'PROJECT' || destinationCategory == 'PROJECT') {
        bool isProjectNoteMoved = await notesModuleController.moveProjectNote(noteModel, destinationCategory);
        return isProjectNoteMoved;
      } else {
        bool isNoteMoved = await AppNotes.moveNote(noteModel, destinationCategory);
        return isNoteMoved;
      }
    } catch (e) {
      await AppLogs.writeError(e, 'note_editing_submenu_controller.dart - moveNote');
      return false;
    }
  }

  Future<bool> duplicateNote() async {
    try {
      if (noteModel.category == 'PROJECT') {
        bool isProjectNoteDuplicated = await notesModuleController.duplicateProjectNote(noteModel);
        return isProjectNoteDuplicated;
      } else {
        bool isNoteDuplicated = await AppNotes.duplicateNote(noteModel);
        return isNoteDuplicated;
      }
    } catch (e) {
      await AppLogs.writeError(e, 'note_editing_submenu_controller.dart - duplicateNote');
      return false;
    }
  }

  Future<bool> deleteNote() async {
    try {
      if (noteModel.category == 'PROJECT') {
        bool isProjectNoteDeleted = await notesModuleController.deleteProjectNote(noteModel);
        return isProjectNoteDeleted;
      } else {
        bool isNoteDeleted = await AppNotes.deleteNote(noteModel, noteModel.category);
        return isNoteDeleted;
      }
    } catch (e) {
      await AppLogs.writeError(e, 'note_editing_submenu_controller.dart - deleteNote');
      return false;
    }
  }

  String formatDate(String lastModified) {
    String date = lastModified.split(' ').first;
    String hour = lastModified.split(' ').last;

    String year = date.split('/').last;

    int? yearAsInt = int.tryParse(year);

    if (yearAsInt != null) {
      int currentYear = DateTime.now().year;
      if (yearAsInt == currentYear) {
        String dateWithoutYear = "${date.substring(0, 5)} $hour";
        return dateWithoutYear;
      }
    }
    return lastModified;
  }

  Future<bool> closeNote() async {
    if (_getAllNoteText().replaceAll(' ', '').isEmpty) {
      await deleteNote();
      return true;
    } else {
      bool isSaved = await saveNote();
      return isSaved;
    }
  }

  String _getAllNoteText() {
    String totalText = "";
    for (Widget element in noteContentWidgets) {
      if (element is CustomTextArea) {
        totalText += "${element.data} ";
      }
      if (element is CustomCodeDisplay) {
        totalText += "${element.data['code'] ?? ''} ";
      }
      if (element is CustomImageDisplay) {
        totalText += "${element.data['description'] ?? ''} ";
      }
      if (element is CustomBulletedList) {
        List data = element.data as List;
        totalText += "${data.join(' ')} ";
      }
    }
    return totalText;
  }
}