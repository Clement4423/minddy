import 'package:flutter/foundation.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/get_articles.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/components/cards/articles_card.dart';

class ArticleMenuSearchViewController extends ChangeNotifier {
  final String category;
  final String relativeFolderPath;

  String lastInput = "";

  List<ArticleInfo> allArticles = [];

  List<ArticleCard> allArticlesWidgets = [];

  bool isSearchEmpty = false;


  ArticleMenuSearchViewController(this.category, this.relativeFolderPath) {
    initalize();
  }

  initalize() {
    listAllArticles().then((value) {
      allArticles = value;
      notifyListeners();
    });
  }

  Future<void> readFirstArticle(ArticleCard firstCard) async {
    await firstCard.readFunction();
  }

  Future<List<ArticleInfo>> listAllArticles() async {
    List<ArticleInfo> allArticlesList = [];
    for (ArticleCategory category in ArticleCategory.values) {
      List<ArticleInfo> articles = await getArticles(category.name, relativeFolderPath);
      for (var article in articles) { 
        allArticlesList.add(article);
      }
    }
    return allArticlesList;
  }

  void searchArticles(String input) {

    String transformedInput = SearchTextFormatter.format(input);
      List<ArticleInfo> result = allArticles.where((element) {
    return SearchTextFormatter.format(element.title).contains(transformedInput) ||
           SearchTextFormatter.format(element.author).contains(transformedInput);
    }).toList();

    isSearchEmpty = result.isEmpty ? true : false;
    
    createArticlesCards(result);
  }

  List<ArticleInfo> articlesCardsList = [];

  void createArticlesCards(List<ArticleInfo> list) {
    articlesCardsList.clear();
    for (ArticleInfo element in list) {
      articlesCardsList.add(element);
    }
    notifyListeners();
  }

  void clearArticlesCards() {
    articlesCardsList.clear();
    notifyListeners();
  }
}