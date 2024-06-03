import 'package:flutter/material.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/model/project_module_model.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/projects/app_project.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectInfo projectInfo;

  List<Widget> containers = [];

  Future<List<ProjectModuleModel>> getProjectModulesModels() async {
    List<dynamic> projectContent = await AppProject.getProperty(projectInfo.path, 'content');

    List<ProjectModuleModel> modules = [];

    for (Map module in projectContent) {
      modules.add(convertJsonModuleToModel(module));
    }
    return modules;
  }

  ProjectModuleModel convertJsonModuleToModel(Map module) {
    return ProjectModuleModel(type: ProjectsModules.values[module['type']], id: module['id']);
  }

  ProjectViewModel({required this.projectInfo});
}
