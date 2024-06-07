import 'package:flutter/material.dart';

class ProjectsTasksModuleTaskModel {
  String title;
  bool isChecked;
  List<ProjectsTasksModuleSubTaskModel> subtasks;

  ProjectsTasksModuleTaskModel({required this.title, required this.isChecked, required this.subtasks});
}

class ProjectsTasksModuleSubTaskModel {
  String title;
  bool isChecked;
  Key key;

  ProjectsTasksModuleSubTaskModel({required this.title, required this.isChecked, required this.key});
} 