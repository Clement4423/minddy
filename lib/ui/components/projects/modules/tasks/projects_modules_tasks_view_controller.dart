import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/model/projects_tasks_module_task_model.dart';
import 'package:minddy/system/projects/get_module_data.dart';
import 'package:minddy/ui/components/projects/modules/tasks/project_sub_task_element.dart';
import 'package:minddy/ui/components/projects/modules/tasks/project_task_element.dart';

class ProjectsTasksModuleController extends ChangeNotifier implements IProjectModuleController {

  @override
  final String projectPath;
  
  @override
  final int id;

  @override
  set id(int newId) {}
  
  @override
  set projectPath(String newProjectPath) {}

  late final File _dataFile;

  List<ProjectsTasksModuleTaskModel> tasks = [];
  List<ProjectTaskElement> tasksWidgets = [];

  ProjectsTasksModuleController({required this.projectPath, required this.id}) {
    _dataFile = File("${StaticVariables.fileSource.documentDirectoryPath}/$projectPath/${ProjectsModules.tasks.name}/$id.json");
    initialize();
  }

  Future<void> initialize() async {
    await getTasks();
    notifyListeners();
  }

  Future<void> newTask() async {
    ProjectsTasksModuleTaskModel newTask = ProjectsTasksModuleTaskModel(title: '', isChecked: false, subtasks: []);
    tasks.add(newTask);
    tasksWidgets.add(ProjectTaskElement(data: newTask, key: UniqueKey(), controller: this));
    await savingMethod();
    notifyListeners();
  }

  Future<void> getTasks() async {
    try {
      if (!await _dataFile.exists()) {
        _dataFile.createSync(recursive: true);
        return;
      }
      Map<String, dynamic>? data = await getModuleData(id.toString(), ProjectsModules.tasks, projectPath);
      if (data != null) {
        for (Map task in data['tasks']) {
          ProjectsTasksModuleTaskModel? taskModel = await _converMapToTaskModel(task);
          if (taskModel != null) {
            tasksWidgets.add(ProjectTaskElement(data: taskModel, key: UniqueKey(), controller: this));
            tasks.add(taskModel);
          }
        }
        return;
      }
      return;
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_tasks_view_controller.dart - getTasks");
      return;
    }
  }

  Future<void> completedOneTask() async {
    await savingMethod();
    notifyListeners();
  }

  Future<void> deleteTask(Key key) async {
    tasksWidgets.removeWhere((element) => element.key == key);
    await savingMethod();
    notifyListeners();
  }

  Future<void> deleteSubtask(Key parentTaskKey, Key subtaskKey) async {
    tasksWidgets.firstWhere((element) => element.key == parentTaskKey).data.subtasks.removeWhere((element) => element.key == subtaskKey);
    await savingMethod();
    notifyListeners();
  }

  @override
  Future<bool> savingMethod() async {
    final Map<String, dynamic> map = await _convertTaskModelToMap();
    bool isSaved = await StaticVariables.fileSource.writeJsonFile(_dataFile.path.substring(StaticVariables.fileSource.documentDirectoryPath.length), map);
    return isSaved;
  }

  Future<void> newSubtask(Key key) async {
    tasksWidgets.firstWhere((element) => element.key == key).data.subtasks.add(ProjectsTasksModuleSubTaskModel(title: '', isChecked: false, key: UniqueKey()));
    await savingMethod();
    notifyListeners();
  }

  List<Widget> buildSubtasks(Key key) {
    List<Widget> subtasksList = [];
    for (ProjectsTasksModuleSubTaskModel subtask in tasksWidgets.firstWhere((element) => element.key == key, orElse: () {
      return ProjectTaskElement(data: ProjectsTasksModuleTaskModel(title: "", isChecked: false, subtasks: []), controller: this);
    }).data.subtasks) {
      subtasksList.add(ProjectSubTaskElement(data: subtask, controller: this, key: subtask.key, parentTaskKey: key));
    }
    return subtasksList;
  }

  Future<Map<String, dynamic>> _convertTaskModelToMap() async {
    try {
      List<Map> allTasks = [];
      for (ProjectTaskElement task in tasksWidgets) {
        allTasks.add({
          'title': task.data.title,
          'isChecked': task.data.isChecked,
          'subtasks': await _convertSubTaskModelToMap(task.data.subtasks),
        });
      }
      Map<String, dynamic> map = {'tasks': allTasks};
      return map;
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_tasks_view_controller.dart - _convertTaskModelToMap");
      return {'tasks': []};
    }
  }

  Future<List<Map>> _convertSubTaskModelToMap(List<ProjectsTasksModuleSubTaskModel> subtasks) async {
    try {
      List<Map> list = [];
      for (ProjectsTasksModuleSubTaskModel subtask in subtasks) {
        list.add({'title': subtask.title, 'isChecked': subtask.isChecked});
      }
      return list;
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_tasks_view_controller.dart - _convertSubTaskModelToMap");
      return [];
    }
  }

  Future<ProjectsTasksModuleTaskModel?> _converMapToTaskModel(Map task) async {
    try {
      return ProjectsTasksModuleTaskModel(
        title: task['title'],
        isChecked: task['isChecked'],
        subtasks: await _convertMapToSubTaskModel(task['subtasks']),
      );
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_tasks_view_controller.dart - _converMapToTaskModel");
      return null;
    }
  }

  Future<List<ProjectsTasksModuleSubTaskModel>> _convertMapToSubTaskModel(List subtasks) async {
    try {
      List<ProjectsTasksModuleSubTaskModel> list = [];
      for (Map subtask in subtasks) {
        list.add(ProjectsTasksModuleSubTaskModel(title: subtask['title'], isChecked: subtask['isChecked'], key: UniqueKey()));
      }
      return list;
    } catch (e) {
      await AppLogs.writeError(e, "projects_modules_tasks_view_controller.dart - _convertMapToSubTaskModel");
      return [];
    }
  }
}