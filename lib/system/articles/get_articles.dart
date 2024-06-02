import 'dart:io';

import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:path/path.dart' as path;

/// This will get the articles paths in the [Documents/shared/articles/saved/saved_articles.json] file.
/// 
/// If the file don't already exists, it creates it.
/// 
/// The return will be the same as [getArticles]. 
Future<List<ArticleInfo>> getSavedArticles() async {
  try {
  String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
  Directory articlesDirectory = Directory("$documentDirectoryPath/shared/articles/saved");

  if (!articlesDirectory.existsSync()) {
    await AppArticles.createSavedArticlesFile();
  }

  List<ArticleInfo> articlesInfos = [];
  Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile("shared/articles/saved/saved_articles.json");
  List<dynamic> pathsList = fileContent!["articles"];
  for (dynamic articlePath in pathsList) {
      ArticleInfo? articleInfo = await _generateArticleInfo(articlePath.toString());
      if (articleInfo != null) {
        articlesInfos.add(articleInfo);
      } else {
        pathsList.remove(articlePath);
        await StaticVariables.fileSource.writeJsonFile("shared/articles/saved/saved_articles.json", {"articles": pathsList});
      }
  }
  return articlesInfos;
  }catch(e) {
    await AppLogs.writeError(e, "get_articles.dart - getSavedArticles");
    return [];
  }
}

/// To use it, indicate either the shared/articles or projects/"project name"/articles
/// 
/// Also, don't put the category inside the relative Path
Future<List<ArticleInfo>> getArticles(String? category, String relativeFolderPath) async {
  String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
  String articlesDirectoryPathNormalized = path.normalize(Directory("$documentDirectoryPath/$relativeFolderPath/${category ?? ""}").path);
  Directory articlesDirectory = Directory(articlesDirectoryPathNormalized);

  if (!await articlesDirectory.exists()) {
    await StaticVariables.fileSource.createFolder("$relativeFolderPath/${category ?? ""}");
  }

  List<ArticleInfo> articlesInfos = [];
  List<FileSystemEntity>? articles = articlesDirectory.listSync();
  for (FileSystemEntity entity in articles) {
    if (entity is File) {
      if (path.basename(entity.path).startsWith('.')) {
        continue;
      }
      String fileRelativePath = path.normalize(entity.path.substring(documentDirectoryPath.length));
      ArticleInfo? articleInfo = await _generateArticleInfo(fileRelativePath);
      if (articleInfo != null) {
        articlesInfos.add(articleInfo);
      }
    } else if (entity is Directory) {
      continue;
    }
  }
  return articlesInfos;
}

Future<ArticleInfo?> _generateArticleInfo(String fileRelativePath) async {
  try {
  return ArticleInfo(
    await AppArticles.getProperty("title", fileRelativePath),
    await AppArticles.getProperty("reading_time", fileRelativePath), 
    await AppArticles.getProperty("author", fileRelativePath), 
    await AppArticles.getProperty("is_bookmarked", fileRelativePath),
    AppArticles.getCategoryIcon(await AppArticles.getProperty("category", fileRelativePath)),
    fileRelativePath
  );
  } catch(e) {
    return null;
  }
}