import 'dart:io';

import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/project_info.dart';

Future<List<ProjectInfo>> getProjects() async {
  if (!LoginState.isUnlocked) {
    return [];
  }
  String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
  Directory projectsDirectory = Directory("$documentDirectoryPath/projects");

  if (!projectsDirectory.existsSync()) {
    await StaticVariables.fileSource.createFolder("projects");
  }

  List<ProjectInfo> projectsInfo = [];
  List<FileSystemEntity> projects = projectsDirectory.listSync();

  for (var entity in projects) {
    if (entity is Directory) {
      String relativePath =  entity.path.substring(documentDirectoryPath.length);
      projectsInfo.add(ProjectInfo(await _openProjectAndGetName(relativePath) ?? "", relativePath));
    }
  }
  return projectsInfo;
}

Future<String?> _openProjectAndGetName(String path) async {
  try {
    String infosFilePath = "$path/infos.json";
      Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(infosFilePath);
      if (fileContent != null) {
        String? projectName = fileContent['name'];
        return projectName;
      }
    return null;
  } catch(e) {
    await AppLogs.writeError(e, "get_projects.dart - _openProjectAndGetName");
    return null;
  }
}


