import 'package:flutter/material.dart';

class ProjectNoteModuleCategoryModel {
  String title;
  int noteCount;
  IconData icon;
  bool isPrivate;
  String categoryName;

  ProjectNoteModuleCategoryModel({required this.title, required this.icon, required this.noteCount, required this.isPrivate, required this.categoryName});
}