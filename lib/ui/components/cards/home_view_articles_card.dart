import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/model/articles_elements.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class HomeViewArticleCard extends StatefulWidget {
  const HomeViewArticleCard({super.key, required this.title, required this.description, required this.background, required this.articleInfo, required this.articleContent});

  final String title;
  final String description;
  final Widget background;
  final ArticleInfo articleInfo;
  final List<ArticleElement> articleContent;

  @override
  State<HomeViewArticleCard> createState() => _HomeViewArticleCardState();
}

class _HomeViewArticleCardState extends State<HomeViewArticleCard> {

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return MouseRegion(
      onEnter: (details) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await showArticle(ArticlesViewController(widget.articleInfo, () {}, readOnly: true, initialContent: widget.articleContent), context);
        },
        child: Container(
          width: 185,
          height: 185,
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurStyle: BlurStyle.normal,
                blurRadius: 10,
                color: theme.shadow.withOpacity(0.15)                        
              )
            ]
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Background element
              Positioned(
                top: 30,
                child: widget.background
              ),
              // Infos box
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: TweenAnimationBuilder(
                      key: UniqueKey(),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      tween: Tween<double>(
                        begin: 0.0,
                        end: 1.0
                      ),
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: Container(
                            width: 165,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: isHovering 
                                ? theme.secondary
                                : theme.primaryContainer,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Opacity(
                                opacity: opacity,
                                child: Text(
                                  isHovering 
                                    ? S.of(context).articles_read_button
                                    : widget.title, 
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.titleMedium.
                                  copyWith(color: isHovering 
                                    ? theme.onSecondary
                                    : theme.onPrimary
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}