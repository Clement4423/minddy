import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/model/navigation_list_tile_model.dart';
import 'package:minddy/system/router/articles_router.dart';
import 'package:minddy/ui/components/menus/center_menu/center_menu.dart';

List<NavigationListTileModel> generalListTiles = [
  NavigationListTileModel(
    title: S.current.articles_search,
    icon: const Icon(Icons.search_rounded),
    index: 0,
    routeName: "/search"
  ),
  NavigationListTileModel(
    title: S.current.articles_creativity_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.creativity.index)),
    index: 1,
    routeName: "/creativity"
  ),
  NavigationListTileModel(
    title: S.current.articles_daily_life_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.dailyLife.index)),
    index: 2,
    routeName: "/daily"
  ),
  NavigationListTileModel(
    title: S.current.articles_professional_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.professional.index)),
    index: 3,
    routeName: "/pro"
  ),
  NavigationListTileModel(
    title: S.current.articles_wellness_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.wellness.index)),
    index: 4,
    routeName: "/wellness"
  ),
  NavigationListTileModel(
    title: S.current.articles_technology_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.technology.index)),
    index: 5,
    routeName: "/technology",
  ),
  NavigationListTileModel(
    title: S.current.articles_education_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.education.index)),
    index: 6,
    routeName: "/education",
  ),
  NavigationListTileModel(
    title: S.current.articles_science_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.science.index)),
    index: 7,
    routeName: "/science",
  ),
  NavigationListTileModel(
    title: S.current.articles_philosophy_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.philosophy.index)),
    index: 8,
    routeName: "/philosophy",
  ),
  NavigationListTileModel(
    title: S.current.articles_environment_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.environment.index)),
    index: 9,
    routeName: "/environment",
  ),
  NavigationListTileModel(
    title: S.current.articles_travel_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.travel.index)),
    index: 10,
    routeName: "/travel",
  ),
  NavigationListTileModel(
    title: S.current.articles_finance_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.finance.index)),
    index: 11,
    routeName: "/finance",
  ),
  NavigationListTileModel(
    title: S.current.articles_politics_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.politic.index)),
    index: 12,
    routeName: "/politics",
  ),
  NavigationListTileModel(
    title: S.current.articles_food_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.food.index)),
    index: 13,
    routeName: "/food",
  ),
];

List<NavigationListTileModel> bottomListTiles = [
  NavigationListTileModel(
    title: S.current.articles_saved_title,
    icon: const Icon(Icons.bookmark_rounded),
    index: 14,
    routeName: "/saved"
  ),
  NavigationListTileModel(
    title: S.current.articles_my_articles_title,
    icon: Icon(AppArticles.getCategoryIcon(ArticleCategory.created.index)),
    index: 15,
    routeName: "/created"
  ),
];



Future<dynamic> showArticles(BuildContext context, {String? pageRouteName, dynamic argument}) {
    return showCenterMenu(
      context, 
      SvgPicture.asset("assets/logo/articles/logo_articles_colored.svg", width: 60), 
      ArticlesRouter(), 
      generalListTiles, 
      bottomListTiles,
      pageRouteName: pageRouteName,
      argument: argument
    );
}