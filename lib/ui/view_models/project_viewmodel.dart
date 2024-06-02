import 'package:flutter/material.dart';
import 'package:minddy/system/model/project_info.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectInfo projectInfo;

  ProjectViewModel({required this.projectInfo});
}