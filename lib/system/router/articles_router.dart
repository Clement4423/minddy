import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/interface/router_interface.dart';
import 'package:minddy/ui/components/articles/articles_menu_view/articles_menu_search_view.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_menu_search_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_menu_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_menu_view/articles_menu_view.dart';

class ArticlesRouter implements IRouter {
  
// This is empty, because we need to refresh the page everytime we click on the article,
// and to do so, we need to return a different object everytime we call the navigateTo method.
@override
final Map<String, dynamic> routes = {
  // Search returns the same instance eachtime, because otherwise, clicking the 'Search' tab would list everytime every articles.
  "/search" : ArticleMenuSearchView(S.current.articles_creativity_title, ArticleMenuSearchViewController(ArticleCategory.creativity.name, "shared/articles"))
};

@override
Widget navigateTo(String route, {BuildContext? context}) {
  switch (route) {
    case "/search":
      return routes["/search"];
    case "/creativity":
      return ArticleMenuView(S.current.articles_creativity_title, ArticleMenuViewController(ArticleCategory.creativity.name, "shared/articles"));
    case "/daily":
      return ArticleMenuView(S.current.articles_daily_life_title, ArticleMenuViewController(ArticleCategory.dailyLife.name, "shared/articles"));
    case "/pro":
      return ArticleMenuView(S.current.articles_professional_title, ArticleMenuViewController(ArticleCategory.professional.name, "shared/articles"));
    case "/wellness":
      return ArticleMenuView(S.current.articles_wellness_title, ArticleMenuViewController(ArticleCategory.wellness.name, "shared/articles"));
    case "/saved":
      return ArticleMenuView(key: UniqueKey(), S.current.articles_saved_title, ArticleMenuViewController("saved", "shared/articles"));
    case "/created":
      return ArticleMenuView(S.current.articles_my_articles_title, ArticleMenuViewController(ArticleCategory.created.name, "shared/articles"));
    case "/":
      return ArticleMenuView(S.current.articles_creativity_title, ArticleMenuViewController(ArticleCategory.creativity.name, "shared/articles"));
    case "/technology":
      return ArticleMenuView(S.current.articles_technology_title, ArticleMenuViewController(ArticleCategory.technology.name, "shared/articles"));
    case "/education":
      return ArticleMenuView(S.current.articles_education_title, ArticleMenuViewController(ArticleCategory.education.name, "shared/articles"));
    case "/science":
      return ArticleMenuView(S.current.articles_science_title, ArticleMenuViewController(ArticleCategory.science.name, "shared/articles"));
    case "/philosophy":
      return ArticleMenuView(S.current.articles_philosophy_title, ArticleMenuViewController(ArticleCategory.philosophy.name, "shared/articles"));
    case "/environment":
      return ArticleMenuView(S.current.articles_environment_title, ArticleMenuViewController(ArticleCategory.environment.name, "shared/articles"));
    case "/travel":
      return ArticleMenuView(S.current.articles_travel_title, ArticleMenuViewController(ArticleCategory.travel.name, "shared/articles"));
    case "/finance":
      return ArticleMenuView(S.current.articles_finance_title, ArticleMenuViewController(ArticleCategory.finance.name, "shared/articles"));
    case "/politics":
      return ArticleMenuView(S.current.articles_politics_title, ArticleMenuViewController(ArticleCategory.politic.name, "shared/articles"));
    case "/food":
      return ArticleMenuView(S.current.articles_food_title, ArticleMenuViewController(ArticleCategory.food.name, "shared/articles"));
    default:
      return Container();
  }
}



  @override
  Widget navigateToCustomPage(String route, dynamic argument) {
    return Container();
  }
}