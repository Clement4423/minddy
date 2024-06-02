import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/model/articles_elements.dart';
import 'package:minddy/ui/components/cards/home_view_articles_card.dart';

class DefaultArticlesList {
  static List<HomeViewArticleCard> list = [
    HomeViewArticleCard(
      title: S.current.default_articles_articles_title, 
      description: S.current.default_articles_articles_description,
      background: SvgPicture.asset("assets/logo/articles/logo_articles_colored.svg", width: 80), 
      articleInfo: ArticleInfo(S.current.default_articles_articles_title, "1", "Minddy", false, Icons.abc, "path"),
      articleContent: [
        ArticleSubtitleElement(1, S.current.default_articles_articles_first_subtitle),
        ArticleTextElement(2, S.current.default_articles_articles_first_paragraph),
        ArticleSubtitleElement(3, S.current.default_articles_articles_second_subtitle),
        ArticleTextElement(4, S.current.default_articles_articles_second_paragraph),
        ArticleSubtitleElement(5, S.current.default_articles_articles_third_subtitle),
        ArticleTextElement(6, S.current.default_articles_articles_third_paragraph),
        ArticleSubtitleElement(7, S.current.default_articles_articles_fourth_subtitle),
        ArticleTextElement(8, S.current.default_articles_articles_fourth_paragraph),
        ArticleSubtitleElement(9, S.current.default_articles_articles_fifth_subtitle),
        ArticleTextElement(10, S.current.default_articles_articles_fifth_paragraph),
      ]
    ),
    HomeViewArticleCard(
      title: "Calendar", 
      description: "Discover the calendar in minddy",
      background: SvgPicture.asset("assets/logo/calendar/Calendar31.svg", width: 80), 
      articleInfo: ArticleInfo("Calendar", "8", "Clément", false, Icons.abc, "path"), 
      articleContent: [
        ArticleTextElement(1, "This is a text")
      ]
    ),
  ];
}