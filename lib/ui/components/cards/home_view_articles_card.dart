import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/model/articles_elements.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class HomeViewArticleCard extends StatelessWidget {
  const HomeViewArticleCard({super.key, required this.title, required this.description, required this.background, required this.articleInfo, required this.articleContent});

  final String title;
  final String description;
  final Widget background;
  final ArticleInfo articleInfo;
  final List<ArticleElement> articleContent;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            await showArticle(ArticlesViewController(articleInfo, () {}, readOnly: true, initialContent: articleContent), context);
          },
          child: Tooltip(
            message: S.of(context).home_articles_card_open_hint,
            waitDuration: const Duration(seconds: 1),
            child: Container(
              width: 185,
              height: 185,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 5),
                    blurStyle: BlurStyle.normal,
                    blurRadius: 10,
                    color: theme.shadow.withOpacity(0.05)                        
                  )
                ]
              ),
              child: Column(
                children: [
                  // Background element
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: theme.surface
                    ),
                    child: Center(child: background),
                  ),
                  // Infos box
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        color: theme.primary
                      ),
                      child: SizedBox(
                        width: 185,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                              child: Text(
                                title,
                                style: theme.titleMedium.
                                copyWith(color: theme.onPrimary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              child: Text(
                                description,
                                maxLines: 2,
                                style: theme.bodySmall.
                                copyWith(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}