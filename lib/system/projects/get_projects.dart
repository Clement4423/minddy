import 'dart:io';
import 'dart:ui';

import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';

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
      ProjectInfo? projectInfo = await _getProjectInfos(relativePath);
      if (projectInfo != null) {
        projectsInfo.add(projectInfo);
      }
    }
  }
  return projectsInfo;
}

Future<ProjectInfo?> _getProjectInfos(String path) async {
  try {
    String infosFilePath = "$path/infos.json";
      Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(infosFilePath);
      if (fileContent != null) {
        String? projectName = fileContent['name'];
        bool isPrivate = fileContent['is_private'] ?? true;
        DateTime lastChanged = DateTime.parse(fileContent['last_change']);
        Color color = hexToHsl(fileContent['color'] ?? '0000FF').toColor();
        return ProjectInfo(projectName ?? S.current.articles_card_untitled, isPrivate, color, lastChanged, path);
      }
    return null;
  } catch(e) {
    await AppLogs.writeError(e, "get_projects.dart - _openProjectAndGetName");
    return null;
  }
}


