import 'package:flutter/material.dart';
import 'package:minddy/system/articles/get_articles.dart';
import 'package:minddy/system/model/article_info.dart';

class ArticleMenuViewController extends ChangeNotifier {
  final String category;
  final String relativeFolderPath;


  ArticleMenuViewController(this.category, this.relativeFolderPath) {
    initalize();
  }

  initalize() {
    listArticles().then((value) => createArticlesCards(value));
  }

  Future<List<ArticleInfo>> listArticles() async {
    if (category != "saved") {
      return await getArticles(category, relativeFolderPath);
    } else {
      return await getSavedArticles();
    }
  }

  List<ArticleInfo> articlesCardsList = [];

  void createArticlesCards(List<ArticleInfo> list) {
    articlesCardsList.clear();
    for (ArticleInfo element in list) {
      articlesCardsList.add(element);
    }
    notifyListeners();
  }
}