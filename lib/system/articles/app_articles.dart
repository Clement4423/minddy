import 'package:flutter/material.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/get_article_content_elements.dart';
import 'package:minddy/system/articles/get_dart_maps_from_articles_elements.dart';
import 'package:minddy/system/files/config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/model/articles_elements.dart';

/// A utility class for managing articles.
class AppArticles {
  /// A map containing category names and their associated icons.
  /// A map containing category names and their associated icons.
  static const Map<ArticleCategory, IconData> _categoryIcons = {
    ArticleCategory.creativity: Icons.brush_rounded,
    ArticleCategory.dailyLife: Icons.emoji_emotions_outlined,
    ArticleCategory.professional: Icons.work_outline_rounded,
    ArticleCategory.wellness: Icons.local_florist_rounded,
    ArticleCategory.created: Icons.account_circle_outlined,
    ArticleCategory.technology: Icons.computer_rounded,
    ArticleCategory.education: Icons.school_rounded,
    ArticleCategory.science: Icons.science_outlined,
    ArticleCategory.philosophy: Icons.psychology_alt_rounded,
    ArticleCategory.environment: Icons.eco_rounded,
    ArticleCategory.travel: Icons.airplanemode_active_rounded,
    ArticleCategory.finance: Icons.attach_money_rounded,
    ArticleCategory.politic: Icons.public_rounded,
    ArticleCategory.food: Icons.restaurant_rounded,
  };

  static IconData getCategoryIcon(int categoryIndex) {
    ArticleCategory category = ArticleCategory.values[categoryIndex];
    return _getIconBasedOnCategory(category); 
  }

  /// Get the icon associated with the given category.
  static IconData _getIconBasedOnCategory(ArticleCategory category) {
    return _categoryIcons[category] ?? Icons.error_rounded;
  }
  
  /// Convert the category enum value to a string.
  static String getCategoryString(ArticleCategory category) {
    return category.name.toString();
  }


  /// Creates an article file with the provided information.
  ///
  /// Returns an [ArticleInfo] element if the file creation and writing are successful, otherwise returns null.
  ///
  /// The [relativeFolderPath] should be either 'shared/articles' or 'projects/[project name]/articles'.
  /// Do not include the category inside the relative path.
  ///
  /// The author name is defined by the username retrieved from the configuration.
  static Future<ArticleInfo?> createArticle({
    required String title,
    required String relativeFolderPath,
    required bool isMultiLanguage,
    required String languageCode,
    required ArticleCategory category,
  }) async {
    try {
      String author = await AppConfig.getConfigValue("username");

      // This creates the article content Map
      final Map<String, dynamic> article = {
        "title": title,
        "language": languageCode,
        "author": author,
        "reading_time": "0",
        "is_bookmarked": false,
        "category": category.index,
        "sources": [],
        "content": []
      };

      String fileRelativePath = "";
      String fileName = createFileName(title);

      if (isMultiLanguage) {
        fileRelativePath = "$relativeFolderPath/${getCategoryString(category)}/$fileName/$languageCode.json";
      } else {
        fileRelativePath = "$relativeFolderPath/${getCategoryString(category)}/$fileName.json";
      }

      final bool createdFile = await StaticVariables.fileSource.createFile(fileRelativePath);
      final bool writtenFile = await StaticVariables.fileSource.writeJsonFile(fileRelativePath, article);

      if (createdFile && writtenFile) {
        return ArticleInfo(
            article["title"], 
            article["reading_time"], 
            author, 
            article["is_bookmarked"], 
            getCategoryIcon(category.index), 
            fileRelativePath
          );
      } else {
        await AppLogs.writeError("An error occurred while creating an article.", "app_articles - createArticle");
        return null;
      }
    } catch (e) {
      await AppLogs.writeError(e, "app_articles.dart - createArticle");
      return null;
    }
  }

  /// Creates a unique file name based on the provided title.
  static String createFileName(String title) {
    double hashDividedTitle = title.hashCode / (DateTime.now().microsecond + 1);
    return hashDividedTitle.hashCode.toString().substring(1, 10).padRight(10, '0');
  }


  /// This function will delete article file as well as ressources used like images.
  static Future<bool> deleteArticle(String articleRelativePath) async {
    try {
      final Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(articleRelativePath);

      if (fileContent != null) {
        List<dynamic> articleContent = fileContent['content'];

        List<ArticleElement> articleElementsList = await getArticleContentElements(articleContent);

        List<String> imagesToDelete = [];

        for (ArticleElement element in articleElementsList) {
          if (element is ArticleImageElement) {
            var data = element.data;
            imagesToDelete.add(data['url']);
          }
        }

        for (String imageName in imagesToDelete) {
          await StaticVariables.fileSource.removeFile("ressources/$imageName");
        }

        if (fileContent['is_bookmarked']) {
          await AppArticles.bookmarkArticle(articleRelativePath);
        }

        StaticVariables.fileSource.removeFile(articleRelativePath);

        return true;
    }
    return false;
    } catch(e) {
      await AppLogs.writeError(e, "app_articles.dart - deleteArticle");
      return false;
    }
  }

  /// Rewrites specific values of the article.
  ///
  /// Returns true if the rewrite is successful, otherwise returns false.
  ///
  /// If only a single property needs to be changed, use [AppArticles.modifyProperty] instead.
  /// 
  static Future<bool> rewriteArticle({
    required String fileRelativePath,
    List<ArticleElement>? content,
    String? title,
    String? readingTime,
    ArticleCategory? category,
    List<dynamic>? sources,
  }) async {
    try {
      bool writtenFile = false;

      if (content != null) {
        writtenFile = await modifyProperty("content", getDartMapsFromArticlesElements(content), fileRelativePath);
      }

      if (title != null) {
        writtenFile = await modifyProperty("title", title, fileRelativePath);
      }

      if (readingTime != null) {
        writtenFile = await modifyProperty("reading_time", readingTime, fileRelativePath);
      }

      if (category != null) {
        writtenFile = await modifyProperty("category", category.index, fileRelativePath);
      }

      if (sources != null) {
        writtenFile = await modifyProperty("sources", sources, fileRelativePath);
      }

      return writtenFile;
    } catch (e) {
      await AppLogs.writeError(e, "app_articles.dart - rewriteArticle");
      return false;
    }
  }

  /// Retrieves a specific property from the article file.
  static Future<dynamic> getProperty(String property, String fileRelativePath) async {
    try {
      Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(fileRelativePath);
      return fileContent?[property];
    } catch (e) {
      await AppLogs.writeError(e, "app_articles.dart - getProperty");
      return null;
    }
  }

  /// Modifies a specific property of the article file.
  ///
  /// Returns true if the modification is successful, otherwise returns false.
  /// 
  /// If you have mulitiples properties to modify, please use [`AppArticles.rewriteArticle`]
  static Future<bool> modifyProperty(String property, dynamic newValue, String fileRelativePath) async {
    try {
      Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(fileRelativePath);
      if (fileContent != null) {
        fileContent[property] = newValue;
        bool savedFile = await StaticVariables.fileSource.writeJsonFile(fileRelativePath, fileContent);
        return savedFile;
      }
      return false;
    } catch (e) {
      await AppLogs.writeError(e, "app_articles.dart - modifyProperty");
      return false;
    }
  }

  /// Toggles the bookmark status of the article.
  ///
  /// Returns true if the bookmark status is successfully toggled, otherwise returns false.
  static Future<bool> bookmarkArticle(String articlePath) async {
    try {
      String savedArticlesFileRelativePath = "shared/articles/saved/saved_articles.json";
      Map<String, dynamic>? savedArticlesFileContent = await StaticVariables.fileSource.readJsonFile(savedArticlesFileRelativePath);
      if (savedArticlesFileContent == null) {
        bool createdFile = await createSavedArticlesFile();
        if (createdFile) {
          bookmarkArticle(articlePath);
        }
      }
      if (savedArticlesFileContent != null) {
        if (!savedArticlesFileContent.containsKey("articles")) {
          savedArticlesFileContent.addEntries(_savedArticlesFileDefaultContent.entries);
          await StaticVariables.fileSource.writeJsonFile(savedArticlesFileRelativePath, savedArticlesFileContent);
        }
      }
      List<dynamic> articlesList = savedArticlesFileContent!["articles"];
      if (articlesList.contains(articlePath)) {
        articlesList.remove(articlePath);
        await modifyProperty("is_bookmarked", false, articlePath);
      } else {
        articlesList.add(articlePath);
        await modifyProperty("is_bookmarked", true, articlePath);
      }
      bool savedFile = await StaticVariables.fileSource.writeJsonFile(savedArticlesFileRelativePath, savedArticlesFileContent);
      return savedFile;
    } catch (e) {
      await AppLogs.writeError(e, "app_articles.dart - saveArticle");
      return false;
    }
  }

  /// Creates the saved articles file if it does not exist.
  static Future<bool> createSavedArticlesFile() async {
    bool createdFile = await StaticVariables.fileSource.createFile("shared/articles/saved/saved_articles.json");
    bool writtenFile = await StaticVariables.fileSource.writeJsonFile("shared/articles/saved/saved_articles.json", _savedArticlesFileDefaultContent);
    return createdFile && writtenFile;
  }

  /// Default content for the saved articles file.
  static final Map<String, dynamic> _savedArticlesFileDefaultContent = {
    "articles": []
  };
}
