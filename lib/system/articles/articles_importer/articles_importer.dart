import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/menus/sub_menus/articles_importer_add_images_sub_menu.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';


class ArticlesImporter {
  static Future<bool?> import(BuildContext context) async {

    dynamic result = await StaticVariables.filePicker.pickFiles(allowMultiplesFiles: true);
    if (result != null) {
      String documentDirectoryPath = StaticVariables.fileSource.documentDirectoryPath;
      if (result is List) {
        for (String path in result) {
          if (path.split('.').last.toLowerCase() != 'json') {
            return false;
          }
          ArticleCategory? category = await _openArticleAndGetCategory(path);
          await _saveBasedOnCategory(category ?? ArticleCategory.creativity, path, documentDirectoryPath);
        }

        List<String> imagesPathsList = await _checkIfThereIsAnImage(result.first);

        if (imagesPathsList.isNotEmpty) {
          if (context.mounted) {
            showSubMenu(context, ArticlesImporterImagesImportSubMenu(imagesPathsList: imagesPathsList));
          }
        }

        return true;
      }
    } else {
      return false;
    }
  return null;
  }
  
  static Future<ArticleCategory?> _openArticleAndGetCategory(String path) async {
    try {
      File file = File(path);
      String fileContent = await file.readAsString();
      Map<String, dynamic>? content = jsonDecode(fileContent);

      if (content != null) {
        int? categoryIndex = content['category'];

        if (categoryIndex is int) {
          return ArticleCategory.values[categoryIndex];
        }
      }

      return null;  
    } catch(e) {
      await AppLogs.writeError(e, 'articles_importer.dart - _openArticleAndGetCategory');
      return null;
    }
  }

  static _saveBasedOnCategory(ArticleCategory category, String path, String documentDirectoryPath) async {
    Directory destinationDirectory = Directory("$documentDirectoryPath/shared/articles/${category.name}");

    if (!destinationDirectory.existsSync()) {
      await StaticVariables.fileSource.createFolder(destinationDirectory.path);
    }

    String fileContent = await File(path).readAsString();
    Map<String, dynamic>? decodedContent = await jsonDecode(fileContent);

    if (decodedContent != null) {
      final String newFilePath = "/shared/articles/${category.name}/${createUniqueId().toString()}.json";

      await StaticVariables.fileSource.createFile(newFilePath);

      await StaticVariables.fileSource.writeJsonFile(newFilePath, decodedContent);
    }
  }

  static const List<String> _imagesExtensions = [
    "jpg",
    "png",
    "jpeg"
  ];

  static Future<List<String>> _checkIfThereIsAnImage(String singleFilePath) async {
    try {File file = File(singleFilePath);
    Directory parentDirectory = file.parent;

    List<FileSystemEntity> parentDirectoryContent = parentDirectory.listSync();

    List<String> imagesPathList = [];

    for (FileSystemEntity entity in parentDirectoryContent) {
      if (entity is Directory) {
        List<FileSystemEntity> entityContent =  entity.listSync();

        for (FileSystemEntity element in entityContent) {
          if (element is File) {
            String fileExtension = element.path.split("/").last.split(".").last.toLowerCase();
            if (_imagesExtensions.contains(fileExtension)) {
              imagesPathList.add(element.path);
            }
          }
        }
      } else if (entity is File) {
          String fileExtension = entity.path.split("/").last.split(".").last.toLowerCase();
          if (_imagesExtensions.contains(fileExtension)) {
            imagesPathList.add(entity.path);
          }
      }
    }

    return imagesPathList;
    } catch(e) {
      await AppLogs.writeError(e, "articles_importer.dart - _checkIfThereIsAnImage");
      return [];
    }
  }
}