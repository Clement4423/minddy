
import 'dart:convert';
import 'dart:io';

import 'package:minddy/system/create_unique_id.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';

/// THIS IS NOT THE CLASS TO USE TO CREATE ARTICLES, PLEASE USE [`AppArticles`] INSTEAD. THIS CLASS IS MADE TO CREATE ARTICLES FILES FOR DEBUGGING
class ArticleMaker {
  static Future<bool> createArticle(String json) async {
    try {
      Map<String, dynamic> decodedContent = jsonDecode(json);
      String encodedJson = jsonEncode(decodedContent);
      
      String createdFileName = createUniqueId().toString();

      String relativePath = "ressources/debug/articles_creator/$createdFileName.json";

      bool isFileCreated = await StaticVariables.fileSource.createFile(relativePath);
      if (isFileCreated) {
        String appDocumentsDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
        File file = File("$appDocumentsDirectoryPath/$relativePath");
        await file.writeAsString(encodedJson);
        return true;
      }
      return false;
    } catch(e) {
      await AppLogs.writeError("ERROR WHILE USING ARTICLE CREATOR : $e", "article_maker_create_article_file.dart - createArticle");
      return false;
    }

  }
}