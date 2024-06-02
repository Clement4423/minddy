import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_menu_search_view_controller.dart';
import 'package:minddy/ui/components/cards/articles_card.dart';
import 'package:minddy/ui/components/cards/articles_card_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class _SearchTextFieldOptionController extends ChangeNotifier {
  String input = "";
  inputChanged(String newInput) {
    input = newInput;
    notifyListeners();
  }
}

class ArticleMenuSearchView extends StatefulWidget {
  final String title;
  final ArticleMenuSearchViewController _controller;
  const ArticleMenuSearchView(this.title, this._controller, {super.key});

  @override
  State<ArticleMenuSearchView> createState() => _ArticleMenuSearchViewState();
}

class _ArticleMenuSearchViewState extends State<ArticleMenuSearchView> {

  final _SearchTextFieldOptionController _searchTextFieldOptionController = _SearchTextFieldOptionController();

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: theme.onPrimary)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextSelectionTheme(
                      data: TextSelectionThemeData(
                        selectionColor: Colors.blue.withAlpha(120)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          widget._controller.lastInput = value;
                          _searchTextFieldOptionController.inputChanged(value);
                          if (value.isEmpty) {
                            widget._controller.isSearchEmpty = false;
                            widget._controller.clearArticlesCards();
                            return;
                          }
                          widget._controller.searchArticles(value);
                        },
                        controller: TextEditingController(text: widget._controller.lastInput),
                        cursorColor: theme.onPrimary,
                        autofocus: true,
                        style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          border: InputBorder.none,
                          hintText: "${S.of(context).articles_search}..."
                        ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _searchTextFieldOptionController,
                    builder: (context, child) {
                      return MouseRegion(
                        cursor: _searchTextFieldOptionController.input.isNotEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
                        child: GestureDetector(
                          onTap: () {
                            if (_searchTextFieldOptionController.input.isNotEmpty) {
                              setState(() {
                                widget._controller.lastInput = "";
                                _searchTextFieldOptionController.inputChanged("");
                                widget._controller.isSearchEmpty = false;
                                widget._controller.clearArticlesCards();
                              });
                            }
                            
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              child: Icon(_searchTextFieldOptionController.input.isNotEmpty ? Icons.close_rounded : Icons.search_rounded, color: theme.onPrimary),
                            ),
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AnimatedBuilder(
              animation: widget._controller,
              builder: (context, child) {
                if (widget._controller.articlesCardsList.isEmpty) {
                  return EmptyArticleSearchMenuPage(isSearchEmpty: widget._controller.isSearchEmpty);
                }
                return ListView.builder(
                  itemCount: widget._controller.articlesCardsList.length,
                  itemBuilder: (context, index) {
                   final article = widget._controller.articlesCardsList[index];
                   return ArticleCardWrite(article.icon, refreshMethod: widget._controller.initalize, key: UniqueKey(), ArticleCardWriteController(article))
                   ;
                  }
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyArticleSearchMenuPage extends StatefulWidget {
  const EmptyArticleSearchMenuPage({super.key, required this.isSearchEmpty});

  final bool isSearchEmpty;

  @override
  State<EmptyArticleSearchMenuPage> createState() => _EmptyArticleMenuPageState();
}

class _EmptyArticleMenuPageState extends State<EmptyArticleSearchMenuPage> {

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            widget.isSearchEmpty 
              ? S.of(context).articles_search_empty
              : S.of(context).articles_search_explain,
            textAlign: TextAlign.center,
            style: theme.titleMedium.copyWith(color: theme.onPrimary),
          ),
        )
      ],
    );
  }
}

