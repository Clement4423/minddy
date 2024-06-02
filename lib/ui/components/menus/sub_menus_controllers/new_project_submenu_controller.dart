import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/projects/app_project.dart';

class NewProjectSubMenuController extends ChangeNotifier {
  final Function specialAction;
  NewProjectSubMenuController({required this.specialAction});
  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  String projectName = "";

  void nameChanged(String newName) {
    if (newName != "") {
      projectName = newName;
    }
  }

  Future<bool> validateName(context) async {
    if (projectName.replaceAll(' ', '').isEmpty) {
      _errorMessage = S.current.submenu_new_project_errorMessage;
      notifyListeners();
      return false;
    }
    if (projectName != "") {
      await AppProject.createProject(projectName);
      await specialAction();
      _errorMessage = "";
      Navigator.pop(context);
      notifyListeners();
      return true;
    }
    else {
      _errorMessage = S.current.submenu_new_project_errorMessage;
      notifyListeners();
      return false;
    }
  }
}