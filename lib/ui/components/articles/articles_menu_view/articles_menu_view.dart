import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_menu_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_menu_view/articles_page_top_bar.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/components/cards/articles_card.dart';
import 'package:minddy/ui/components/cards/articles_card_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticleMenuView extends StatelessWidget {
  final String title;
  final ArticleMenuViewController _controller;
  const ArticleMenuView(this.title, this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArticlesPagebar(
          title,
          resetFunction: _controller.initalize
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.articlesCardsList.isEmpty) {
                return EmptyArticleMenuPage(resetFunction: _controller.initalize, pageTitle: title);
              }
              return ListView.builder(
                itemCount: _controller.articlesCardsList.length,
                itemBuilder: (context, index) {
                 final article = _controller.articlesCardsList[index];
                 return ArticleCard(article.icon, context: context, refreshMethod: _controller.initalize, key: UniqueKey(), ArticleCardController(article))
                 ;
                }
              );
            }
          ),
        ),
      ],
    );
  }
}

class EmptyArticleMenuPage extends StatefulWidget {
  const EmptyArticleMenuPage({super.key, required this.resetFunction, required this.pageTitle});

  final Function resetFunction;
  final String pageTitle;

  @override
  State<EmptyArticleMenuPage> createState() => _EmptyArticleMenuPageState();
}

class _EmptyArticleMenuPageState extends State<EmptyArticleMenuPage> {
  bool _isHovering = false;

  bool canTheIconRotate = true;

  @override
  void initState() {
    canTheIconRotate = widget.pageTitle != S.current.articles_saved_title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async{
            ArticleInfo? infos = await AppArticles.createArticle(
              title: "", 
              relativeFolderPath: "shared/articles", 
              isMultiLanguage: false,
              languageCode: AppConfig.data.language ?? "en", 
              category: ArticleCategory.created,
            );
            if (infos != null) {
              showArticle(ArticlesViewController(infos, widget.resetFunction), context.mounted ? context : context);
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              setState(() {
                _isHovering = true;
              });
            },
            onExit: (event) {
              setState(() {
                _isHovering = false;
              });
            },          
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInQuart,
              turns: _isHovering && canTheIconRotate ? 0.125 : 0,
              child: Tooltip(
                message: canTheIconRotate ? S.of(context).articles_new_article : '',
                waitDuration: const Duration(milliseconds: 300),
                child: Icon(canTheIconRotate ? Icons.close_rounded : Icons.bookmark_border_rounded, color: theme.onPrimary, size: 70)
              )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 40, top: 20),
          child: Text(
            widget.pageTitle == S.of(context).articles_saved_title 
              ? S.of(context).articles_empty_menu_saved_page_text
              : S.of(context).articles_empty_menu_page_text,
            textAlign: TextAlign.left,
            style: theme.titleMedium.copyWith(color: theme.onPrimary),
          ),
        )
      ],
    );
  }
}

