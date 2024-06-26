import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minddy/system/create_unique_id.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_interface.dart';
import 'package:minddy/system/model/module_container_model.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/model/project_module_model.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/projects/app_project.dart';
import 'package:minddy/ui/components/custom_components/current_page_indicator_view.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';
import 'package:minddy/ui/components/projects/modules/notes/projetcs_modules_notes_view.dart';
import 'package:minddy/ui/components/projects/modules/tasks/projects_modules_tasks_view.dart';
import 'package:minddy/ui/components/projects/modules/tasks/projects_modules_tasks_view_controller.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectInfo projectInfo;

  ProjectViewModel({required this.projectInfo});

  CurrentPageIndicatorController pageIndicatorController = CurrentPageIndicatorController();

  List<ModuleContainerModel> modulesContainer = [];

  List<ProjectModuleModel> modulesModels = [];

  List<IProjectsModules> allModulesWidget = [];

  int lastPage = 0;

  bool isInitialized = false;

  Future<void> initialize() async {
    if (!isInitialized) {
      isInitialized = true;
      await _getProjectModulesModels();
      await getLastPage();
    }
  }

  Future<void> getLastPage() async {
    lastPage = await AppProject.getProperty(projectInfo.path, 'page') ?? 0;
    pageIndicatorController.currentPageIndex = lastPage;
  }

  Future<void> newModule(ProjectsModules moduleType) async {
    modulesModels.add(
      ProjectModuleModel(
        type: moduleType, 
        id: createUniqueId(),
        projectPath: projectInfo.path
      )
    );
    await saveProject();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void _getModules() {
    allModulesWidget.clear();
    for (ProjectModuleModel module in modulesModels) {
      allModulesWidget.add(_buildModule(module));
    }
  }

  buildContainers(Size screenSize) {
    double padding = screenSize.width / 4.2;
    _getModules();

    double modulesWidth = 0;
    
    pageIndicatorController.totalPages = 0;

    modulesContainer.clear();

    _createNewContainer();

    for (IProjectsModules module in allModulesWidget) {
      if (modulesWidth + module.width > screenSize.width - padding) {
        _createNewContainer();
        modulesWidth = 0;
      }
      modulesContainer.last.modules.add(module);
      modulesWidth += module.width;
    }

    pageIndicatorController.totalPages = modulesContainer.length;
  }

  Future<void> duplicateModule(int id) async {
    try {
      ProjectModuleModel moduleToDuplicate = modulesModels.firstWhere((element) => element.id == id);

      int newId = createUniqueId();

      modulesModels.add(ProjectModuleModel(type: moduleToDuplicate.type, id: newId, projectPath: moduleToDuplicate.projectPath));

      await _duplicateModuleData(id, moduleToDuplicate.projectPath, moduleToDuplicate.type, newId);
      await saveProject();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch(e) {
      await AppLogs.writeError(e, "project_viewmodel.dart - _duplicateModuleData");
    }

  }

  Future<bool> _duplicateModuleData(int id, String projectPath, ProjectsModules moduleType, int newId) async {
    try {
      String actualDataFilePath = "$projectPath/${moduleType.name}/$id.json";
      String newDataFilePath = "$projectPath/${moduleType.name}/$newId.json";
      await StaticVariables.fileSource.createFile(newDataFilePath);

      File actualDataFile = File("${StaticVariables.fileSource.documentDirectoryPath}/$actualDataFilePath");
      File newDataFile = File("${StaticVariables.fileSource.documentDirectoryPath}/$newDataFilePath");

      File duplicatedFile = await actualDataFile.copy(newDataFile.path);
      return duplicatedFile.existsSync();
    } catch(e) {
      await AppLogs.writeError(e, "project_viewmodel.dart - _duplicateModuleData");
      return false;
    }
  }

  Future<void> deleteModule(int id) async {
    try {
      ProjectModuleModel moduleToRemove = modulesModels.firstWhere((element) => element.id == id);
      bool isRemoved = modulesModels.remove(moduleToRemove);
      if (isRemoved) {
        await _deleteModuleData(id, moduleToRemove.projectPath, moduleToRemove.type);
      }
      await saveProject();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch(e) {
      await AppLogs.writeError(e, "project_viewmodel.dart - deleteModule");
    }
  }

  Future<bool> _deleteModuleData(int id, String projectPath, ProjectsModules moduleType) async {
    try {
      String dataFilePath = "$projectPath/${moduleType.name}/$id.json";
      bool isDeleted = await StaticVariables.fileSource.removeFile(dataFilePath);
      return isDeleted;
    } catch(e) {
      await AppLogs.writeError(e, "project_viewmodel.dart - _deleteModuleData");
      return false;
    }

  }

  Future<bool> saveProject() async {
    for (IProjectsModules module in allModulesWidget) {
      bool isSaved = await module.controller.savingMethod();
      if (!isSaved) {
        return false;
      }
    }
    bool isContentSaved = await AppProject.modifyProperty(projectInfo.path, 'content', _convertMapToJson());
    if (isContentSaved) {
      bool isCurrentPageSaved = await AppProject.modifyProperty(projectInfo.path, 'page', pageIndicatorController.currentPageIndex);
      return isCurrentPageSaved;
    }
    return isContentSaved;
  }

  _createNewContainer() {
    modulesContainer.add(ModuleContainerModel(modules: []));
  }

  Future<void> _getProjectModulesModels() async {
    try {
      modulesModels.clear();
      List<dynamic> projectContent = await AppProject.getProperty(projectInfo.path, 'content');

      for (Map module in projectContent) {
        modulesModels.add(_convertJsonModuleToModel(module));
      }
    } catch(e) {
      await AppLogs.writeError(e, "project_viewmodel.dart - _getProjectModulesModels");
    } 
  }

  ProjectModuleModel _convertJsonModuleToModel(Map module) {
    return ProjectModuleModel(type: ProjectsModules.values[module['type']], id: module['id'], projectPath: projectInfo.path);
  }

  List<Map> _convertMapToJson() {
    List<Map> allModules = [];
    for (ProjectModuleModel moduleModel in modulesModels) {
      allModules.add({'type': moduleModel.type.index, 'id': moduleModel.id});
    }
    return allModules;
  }

  IProjectsModules _buildModule(ProjectModuleModel module) {
    switch (module.type) {
      case ProjectsModules.tasks:
        return ProjectsTasksModule(key: UniqueKey(), duplicateFunction: duplicateModule, deleteFunction: deleteModule, controller: ProjectsTasksModuleController(id: module.id, projectPath: module.projectPath));
      case ProjectsModules.expenses:
        return ProjectsTasksModule(key: UniqueKey(), duplicateFunction: duplicateModule, deleteFunction: deleteModule, controller: ProjectsTasksModuleController(id: module.id, projectPath: module.projectPath));
      case ProjectsModules.notes:
        return ProjectsNotesModule(key: UniqueKey(), duplicateFunction: duplicateModule, deleteFunction: deleteModule, controller: ProjectsNotesModuleController(id: module.id, projectPath: module.projectPath));
    }
  }
}
