import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/projects_modules.dart';

class AppProject {
  AppProject();

  static Future<bool> createProject(String projectName, bool isPrivate, Color color) async {

    String projectFolderName = createUniqueId().toString();

    bool isProjectGenerated = await _generateProjectFiles(projectFolderName);
    bool isInfoFileGenerated = await _createInfoFile(projectName, isPrivate, color, projectFolderName);
    return isProjectGenerated && isInfoFileGenerated;
  }

  static Future<bool> duplicateProject(String path) async {
    Directory? duplicatedFolder = await StaticVariables.fileSource.duplicateFolder(path, "projects");
    if (duplicatedFolder != null) {
      String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
      String initialProjectName = await getProperty(path, "name");
      await modifyProperty(duplicatedFolder.path.substring(documentDirectoryPath.length), "name", "$initialProjectName (${S.current.system_files_copy_text})");
      return true;
    }
    return false;
  }

  static Future<bool> removeProject(String path) async {
    bool isFolderDeleted = await StaticVariables.fileSource.removeFolder(path);
    return isFolderDeleted;
  }

  static Future<bool> modifyProperty(String projectPath, String propety, dynamic newValue) async {
    try {
      String infoFilePath = "$projectPath/infos.json";
      Map<String, dynamic>? infoFileContent = await StaticVariables.fileSource.readJsonFile(infoFilePath);
      if (infoFileContent != null) {
        infoFileContent[propety] = newValue;
        bool isSaved = await StaticVariables.fileSource.writeJsonFile(infoFilePath, infoFileContent);
        return isSaved;
      } else {
        await AppLogs.writeError("Tried to modify a non-existing file", "project.dart - modifyProperty");
        return false;
      }
    } catch(e) {
      await AppLogs.writeError(e, "app_project.dart - modifyProperty");
      return false;
    }
  }

  static Future<dynamic> getProperty(String path, String propety) async {
    try {
      String infoFilePath = "$path/infos.json";
      Map<String, dynamic>? infoFileContent = await StaticVariables.fileSource.readJsonFile(infoFilePath);
      if (infoFileContent != null) {
        return infoFileContent[propety];
      } else {
        await AppLogs.writeError("Tried to access a non-existing file", "project.dart - getProperty");
        return null;
      }
    } catch(e) {
      await AppLogs.writeError(e, "app_project.dart - getPropety");
      return null;  
    }
  }


  static Future<bool> _generateProjectFiles(String projectFolderName) async {
    try {
      for (ProjectsModulesTypes module in ProjectsModulesTypes.values) {
        await _createFolders(projectFolderName, module.name);
      }
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "app_project.dart - _generateProjectFiles");
      return false;
    }
  }

  static Future<void> _createFolders(String projectFolderName, String folder) async {
    final String path =  "projects/$projectFolderName/$folder";
    await StaticVariables.fileSource.createFolder(path);
  }

  static Future<bool> _createInfoFile(String projectName, bool isPrivate, Color color, String projectFolderName) async {
    try {
      final String username = await AppConfig.getConfigValue("username");
      final date = DateTime.now().toIso8601String();

      HSLColor hsl = HSLColor.fromColor(color);

      final Map<String, dynamic> infos = {
        "name": projectName,
        "is_private": isPrivate,
        "color": hslToHex(hsl),
        "creator": username,
        "creation_date": date,
        "last_change": date,
        "page": null,
        "content": []
      };

      String infoFilePath = "projects/$projectFolderName/infos.json";
      await StaticVariables.fileSource.createFile(infoFilePath);
      await StaticVariables.fileSource.writeJsonFile(infoFilePath, infos);
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "app_project.dart - _createInfoFile");
      return false;
    }
  }
}