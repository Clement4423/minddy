import 'dart:convert';
import 'dart:io';

import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/get_article_content_elements.dart';
import 'package:minddy/system/articles/get_dart_maps_from_articles_elements.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/articles_elements.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

import 'package:path/path.dart' as path;

class ArticlesExporter {
  static Future<bool> export(String relativeArticlePath, ArticleCategory newCategory, String destinationPath) async {
    try {
      String documentDirectoryPath = StaticVariables.fileSource.documentDirectoryPath;
      String articleFullpath = "$documentDirectoryPath/$relativeArticlePath";
      String articleFileName = "${await _getArticleTitle(relativeArticlePath)}.${articleFullpath.split('.').last}";
      File newFile = File("$destinationPath/$articleFileName");

      await newFile.create(recursive: true).then((value) async {
        List<String> imagesPathsList = await _openArticleAndCheckIfThereIsImages(relativeArticlePath, documentDirectoryPath);

        Map<String, String> imageRenamingMap = {};

        if (imagesPathsList.isNotEmpty) {
          Directory destinationImagesFolder = Directory("$destinationPath/images");

          if (!destinationImagesFolder.existsSync()) {
            await destinationImagesFolder.create(recursive: true);
          }

          for (String imagePath in imagesPathsList) {
            File actualImageFile = File(imagePath);

            // Generate a unique name for the image
            String newImageName = "${createUniqueId()}${path.extension(imagePath)}";
            String newImagePath = "${destinationImagesFolder.path}/$newImageName";

            imageRenamingMap[imagePath] = newImageName;

            // Save the new image to the destination folder
            await actualImageFile.copy(newImagePath);
          }
        }

        // Update the article content with new image paths and category
        String? contentToCopy = await _getArticleContentWithNewCategoryAndImageNames(relativeArticlePath, newCategory.index, imageRenamingMap, documentDirectoryPath);

        if (contentToCopy != null) {
          newFile.createSync(recursive: true);
          await newFile.writeAsString(contentToCopy);
        } else {
          await newFile.delete();
          return false;
        }
      });

      return true;
    } catch (e) {
      await AppLogs.writeError(e, "articles_exporter.dart - export");
      return false;
    }
  }

  static Future<String?> _getArticleContentWithNewCategoryAndImageNames(
      String articlePath, int categoryIndex, Map<String, String> imageRenamingMap, String documentDirectoryPath) async {
    try {
      Map<String, dynamic>? articleFileContent = await StaticVariables.fileSource.readJsonFile(articlePath);

      if (articleFileContent != null) {
        articleFileContent['category'] = categoryIndex;

        // Update image paths in the article content
        if (articleFileContent['content'] != null) {
          List<ArticleElement> articleElements = await getArticleContentElements(articleFileContent['content']);

          for (ArticleElement element in articleElements) {
            if (element is ArticleImageElement) {
              String originalImagePath = "$documentDirectoryPath/ressources/images/${element.data['url']}";
              String? newImageName = imageRenamingMap[originalImagePath];
              if (newImageName != null) {
                // Update the article content to use the new image path
                element.data['url'] = newImageName;
              }
            }
          }

          articleFileContent['content'] = getDartMapsFromArticlesElements(articleElements);

          // Encode updated article content back to JSON
          String encodedFile = jsonEncode(articleFileContent);
          return encodedFile;
        }
      }
      return null;
    } catch (e) {
      await AppLogs.writeError(e, "articles_exporter.dart - _getArticleContentWithNewCategoryAndImageNames");
      return null;
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

