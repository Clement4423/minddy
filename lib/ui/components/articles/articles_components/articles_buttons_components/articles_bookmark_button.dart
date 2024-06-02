import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesBookmarkButton extends StatefulWidget {
  final String articlePath;
  final bool isArticleBookmarked;
  const ArticlesBookmarkButton({super.key, required this.articlePath, required this.isArticleBookmarked});

  @override
  State<ArticlesBookmarkButton> createState() => _ArticlesBookmarkButtonState();
}


class _ArticlesBookmarkButtonState extends State<ArticlesBookmarkButton> {

  late bool isBookmarked;
  bool _hasJustBeenSave = false;

  Future<void> _updateBookmarkButton() async {
    bool bookmarkArticleValue = await _getArticleBookmarkValue();
    setState(() {
      isBookmarked = bookmarkArticleValue;
      _hasJustBeenSave = bookmarkArticleValue;
    });
    if (_hasJustBeenSave) {
      await Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {_hasJustBeenSave = false;});
        }
      });
    }
  }

  Future<bool> _getArticleBookmarkValue() async {
     return await AppArticles.getProperty("is_bookmarked", widget.articlePath);
  }

  @override
  void initState() {
    isBookmarked = widget.isArticleBookmarked;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 2),
      child: IconButton(
        onPressed: () async {
          await AppArticles.bookmarkArticle(widget.articlePath);
          _updateBookmarkButton();
        }, 
        tooltip: S.of(context).articles_bookmark_semantic_text,
        icon: Icon(
          _hasJustBeenSave 
          ? Icons.bookmark_added_rounded
          : isBookmarked 
            ? Icons.bookmark_rounded 
            : Icons.bookmark_outline_rounded, 
          color: theme.onPrimary,
          semanticLabel: S.of(context).articles_bookmark_semantic_text,
        ),
        style: ButtonThemes.secondaryButtonStyle(context).copyWith(backgroundColor: MaterialStatePropertyAll(theme.primaryContainer)),
      ),
    );
  }
}