import 'dart:convert';
import 'dart:io';

import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/get_article_content_elements.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/articles_elements.dart';

import 'package:path/path.dart' as path;

class ArticlesExporter {
  static Future<bool> export(String relativeArticlePath, ArticleCategory newCategory, String destinationPath) async {
    try {
      String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();

      String articleFullpath = "$documentDirectoryPath/$relativeArticlePath";

      File articleFile = File(articleFullpath);

      String articleFileName = "${await _getArticleTitle(relativeArticlePath)}.${articleFullpath.split('.').last}";

      File newFile = File("$destinationPath/$articleFileName");

      await newFile.create(recursive: true).then((value) async {
        File articleCopiedFile = await articleFile.copy("$destinationPath/$articleFileName");
        String? contentToCopy = await _getArticleContentWithNewCategory(relativeArticlePath, newCategory.index);

        if (contentToCopy != null) {
          articleCopiedFile.writeAsString(contentToCopy);
        } else {
          await articleCopiedFile.delete();
          return false;
        }
      });

      List<String> imagesPathsList = await _openArticleAndCheckIfThereIsImages(relativeArticlePath, documentDirectoryPath);

      if (imagesPathsList.isNotEmpty) {
        Directory destinationImagesFolder = Directory("$destinationPath/images");

        if (!destinationImagesFolder.existsSync()) {
          await destinationImagesFolder.create();
        }

        for (String imagePath in imagesPathsList) {
          File actualImageFile = File(imagePath);

          String imageName = imagePath.split('/').last;

          File newImageFile = File("${destinationImagesFolder.path}/$imageName");

          File createdFile = await newImageFile.create(recursive: true);

          await actualImageFile.copy(createdFile.path);
          
        }
      }
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "articles_exporter.dart - export");
      return false;
    }

  }

  static Future<List<String>> _openArticleAndCheckIfThereIsImages(String articlePath, String documentDirectoryPath) async {
    Map<String, dynamic>? articleFileContent = await StaticVariables.fileSource.readJsonFile(path.normalize(articlePath));

    List<String> imagesPathList = [];

    if (articleFileContent != null) {
      List<ArticleElement> articleElements = await getArticleContentElements(articleFileContent['content']);

      for (ArticleElement element in articleElements) {
        if (element is ArticleImageElement) {
          final String fullImagePath = "$documentDirectoryPath/ressources/images/${element.data['url']}";
          imagesPathList.add(fullImagePath);
        }
      }
    }

    return imagesPathList;
  }

  static Future<String?> _getArticleContentWithNewCategory(String articlePath, int categoryIndex) async {
    try {
      Map<String, dynamic>? articleFileContent = await StaticVariables.fileSource.readJsonFile(articlePath);

      if (articleFileContent != null) {
        articleFileContent['category'] = categoryIndex;

        String encodedFile = jsonEncode(articleFileContent);
        return encodedFile;

      }
      return null;
    } catch(e) {
      await AppLogs.writeError(e, "articles_exporter.dart - _getArticleContentWithNewCategory");
      return null;
    }
  }

  static Future<String?> _getArticleTitle(String articlePath) async {
    try {
      Map<String, dynamic>? articleFileContent = await StaticVariables.fileSource.readJsonFile(articlePath);

      if (articleFileContent != null) {
        String title = articleFileContent['title'] ?? "";
        if (title.length > 15) {
          return title.substring(0, 14);
        } else {
          return title;
        }
      }
      return null;
    } catch(e) {
      await AppLogs.writeError(e, "articles_exporter.dart - _getArticleTitle");
      return null;
    }
  }

}

