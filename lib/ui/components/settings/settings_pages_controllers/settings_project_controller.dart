import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/projects/app_project.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class ProjectSettingsViewModel extends ChangeNotifier {
  final ProjectInfo projectInfo;
  final Function _function;
  late String _projectName;
  late bool isPrivate;

  late bool isInitiallyPrivate;

  late Color color;

  String _errorMessage = "";

  ProjectSettingsViewModel(this.projectInfo, this._function) {
    _projectName = projectInfo.name;
    color = projectInfo.color;
    isPrivate = projectInfo.isPrivate;
    isInitiallyPrivate = projectInfo.isPrivate;
  }

  String get projectName => projectInfo.name;
  String get errorMessage => _errorMessage;


  projectNameChanged(String newProjectName) async {
    _projectName = newProjectName;
  }

  Future<bool> modifyProjectName(BuildContext context) async {
    try {
      if (_projectName == "") {
        _errorMessage = "New project name cannot be empty";
        notifyListeners();
        return false;
      }
      await AppProject.modifyProperty(projectInfo.path, "name", _projectName);
      _errorMessage = "";
      _function();
      if (context.mounted) {
        Navigator.pop(context);
      }
      notifyListeners();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> modifyColor(BuildContext context) async {
    try {
      HSLColor hsl = HSLColor.fromColor(color);
      await AppProject.modifyProperty(projectInfo.path, "color", hslToHex(hsl));
      _function();
      if (context.mounted) {
        Navigator.pop(context);
      }
      notifyListeners();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> modifyIsPrivate(bool newValue, BuildContext context) async {
    try {
      if (isInitiallyPrivate) {
        bool isUnlocked = await showUnlockContentSubMenu(context);
        if (isUnlocked) {
          await AppProject.modifyProperty(projectInfo.path, "is_private", newValue);
        } else {
          notifyListeners();
          return false;
        }
      } else {
        await AppProject.modifyProperty(projectInfo.path, "is_private", newValue);
      }
      isPrivate = newValue;
      _function();
      notifyListeners();
      return true;
    } catch(e) {
      return false;
    }
  }

  void deleteProject(BuildContext context) async {
    NotificationHandler.addNotification(
      NotificationModel(
        content: S.of(context).snackbar_delete_element_text(projectInfo.name),
        action: () async {
          if (projectInfo.isPrivate) {
            bool isUnlocked = await showUnlockContentSubMenu(context);
            if (isUnlocked) {
              await AppProject.removeProject(projectInfo.path);
              _function();
            }
          } else {
            await AppProject.removeProject(projectInfo.path);
            _function();
          }
        }, 
        actionLabel: S.of(context).snackbar_delete_button, 
        duration: NotificationDuration.long
      )
    );
  }
}