import 'package:flutter/material.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/model/article_info.dart';

class ArticleCardController extends ChangeNotifier {
  final ArticleInfo infos;
  bool isBookmarked = false;
  bool hasJustBeenSave = false;

  ArticleCardController(this.infos) {
    isBookmarked = infos.isBookmarked;
  }

  Future<void> toggleBookmark() async {
    await AppArticles.bookmarkArticle(infos.path);
    isBookmarked = !isBookmarked;
    infos.isBookmarked = !infos.isBookmarked;
    notifyListeners();
  }

  Future<void> deleteArticle(Function resetFunction) async {
    await AppArticles.deleteArticle(infos.path);
    resetFunction();
  }
}