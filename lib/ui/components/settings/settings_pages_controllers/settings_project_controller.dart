import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/projects/app_project.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class ProjectSettingsViewModel extends ChangeNotifier {
  final ProjectInfo projectInfo;
  final Function _function;
  late String _projectName;

  String _errorMessage = "";


  ProjectSettingsViewModel(this.projectInfo, this._function) {
    _projectName = projectInfo.name;
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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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
          await AppProject.removeProject(projectInfo.name);
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        actionLabel: S.of(context).snackbar_delete_button, 
        duration: NotificationDuration.long
      )
    );
  }
}