import 'package:flutter/foundation.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/get_articles.dart';
import 'package:minddy/system/model/article_info.dart';

class ArticleMenuSearchViewController extends ChangeNotifier {
  final String category;
  final String relativeFolderPath;

  String lastInput = "";

  List<ArticleInfo> allArticles = [];

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

    String transformedInput = removeAccents(input.toLowerCase().trim());
      List<ArticleInfo> result = allArticles.where((element) {
    return removeAccents(element.title.toLowerCase().trim()).contains(transformedInput) ||
           removeAccents(element.author.toLowerCase().trim()).contains(transformedInput);
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

  String removeAccents(String input) {
    const accents = 'áàâäãåčćçďéèêëěíìîïĺľńňóòôöõøřšśťúùûüýÿžźżÁÀÂÄÃÅČĆÇĎÉÈÊËĚÍÌÎÏĹĽŃŇÓÒÔÖÕØŘŠŚŤÚÙÛÜÝŸŽŹŻ';
    const withoutAccents = 'aaaaaaccceeeeeiiiillnnoooooorrsstuuuuyyzzzaaaaaaccceeeeeiiiillnnoooooorrsstuuuuyyzzz';
    
    String result = '';
    for (int i = 0; i < input.length; i++) {
      int index = accents.indexOf(input[i]);
      if (index != -1) {
        result += withoutAccents[index];
      } else {
        result += input[i];
      }
    }
    return result;
  }
}