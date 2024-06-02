import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';


class _ArticlesBottomMenuSourcesViewController extends ChangeNotifier{
  sourcesChanged() {
    notifyListeners();
  }
}


// ignore: must_be_immutable
class ArticlesBottomMenuSourcesView extends StatefulWidget {
  final ArticlesViewController articleController;
  const ArticlesBottomMenuSourcesView({super.key, required this.articleController});

  @override
  State<ArticlesBottomMenuSourcesView> createState() => _ArticlesBottomMenuSourcesViewState();
}

class _ArticlesBottomMenuSourcesViewState extends State<ArticlesBottomMenuSourcesView> {
  String sourceToAdd = "";

  _ArticlesBottomMenuSourcesViewController controller = _ArticlesBottomMenuSourcesViewController();

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return ListView(
                    children: [
                      if (widget.articleController.articleSources.isEmpty) 
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                            decoration: BoxDecoration(
                              color: theme.surface,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.hide_source_rounded, color: theme.onPrimary, size: 60),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    S.of(context).articles_no_sources,
                                    style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      else 
                        ..._buildSourcesElements(widget.articleController, theme)
                    ],
                  );
                }
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  widget.articleController.articleSources.add(sourceToAdd);
                  controller.sourcesChanged();
                }, 
                icon: Icon(Icons.add_rounded, color: theme.onSecondary),
                tooltip: S.of(context).articles_add_source_button,
                style: ButtonThemes.primaryButtonStyle(context),
              ),
            ),
          )
        ],
      )
    );
  }
}


List<Widget> _buildSourcesElements(ArticlesViewController articleController, StylesGetters theme) {
  final List<Widget> sourcesElements = [];
  for (int i = 0; i < articleController.articleSources.length; i++) {
    sourcesElements.add(
      Container(
        margin: const EdgeInsets.only(right: 12, top: 10),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary,
          ), 
          child: TextField(
            onChanged: (value) {
              if (value.isEmpty) {
                articleController.articleSources.removeAt(i);
                articleController.orderChanged();
              } else {
                articleController.articleSources[i] = value;
              }
            },
            controller: TextEditingController(text: articleController.articleSources[i]),
            style: theme.bodyMedium
            .copyWith(color: theme.onSurface),
            cursorColor: theme.onSurface,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              border: InputBorder.none,
              hintText: S.current.articles_add_source_hint
            ),
          ),
        ),
      )
    );
  }
  return sourcesElements;
}