import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/articles_exporter/articles_exporter.dart';
import 'package:minddy/system/files/open_file_explorer.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_code.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_image.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_list.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_subtitle.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_text.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesBottomMenuContentView extends StatefulWidget {
  final ArticlesViewController articleController;
  const ArticlesBottomMenuContentView({super.key, required this.articleController});

  @override
  State<ArticlesBottomMenuContentView> createState() => _ArticlesBottomMenuContentViewState();
}

class _ArticlesBottomMenuContentViewState extends State<ArticlesBottomMenuContentView> {
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
              child: widget.articleController.articleContent.isNotEmpty 
              ? ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = widget.articleController.articleContent.removeAt(oldIndex);
                    widget.articleController.articleContent.insert(newIndex, item);
                  });
                  widget.articleController.orderChanged();
                },
                proxyDecorator: (child, index, animation) {
                  return Opacity(
                    opacity: 0.4,
                    child: Material(
                      type: MaterialType.transparency,
                      child: child,
                    ),
                  );
                },
                buildDefaultDragHandles: false,
                children: 
                widget.articleController.articleContent
                  .asMap()
                  .entries
                  .map((entry) {
                    final item = entry.value;
                    final index = entry.key;
                    return ReorderableDragStartListener(
                      key: ValueKey(item),
                      index: index,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 40,
                          margin: widget.articleController.articleContent.length > 5 ? const EdgeInsets.only(right: 12) : const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: theme.surface,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              key: ValueKey(item),
                              children: [
                                Row(
                                  children: [
                                    Icon(_whatIconToUse(item), color: theme.onPrimary),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(_whatTextToUse(item), style: theme.bodyMedium.copyWith(color: theme.onPrimary)),
                                    )
                                  ],
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Icon(Icons.drag_handle_rounded, color: theme.onSurface, size: 22,)
                                )
                              ] 
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  .toList(),
              )
              : ListView(
                children: [
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
                          Icon(Icons.clear_rounded, color: theme.onPrimary, size: 60),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              S.of(context).articles_no_content,
                              style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) 
                ],
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: PopupMenuButton(
              tooltip: S.of(context).articles_export_articles,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)
              ),
              color: theme.primary,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.arrow_upward_rounded, color: theme.onPrimary),
              ),
              onSelected: (value) async {
                await widget.articleController.saveArticle();
                String exportsDirectoryPath = "${await StaticVariables.fileSource.getAppDirectoryPath()}/ressources/exports";
                bool isArticleExported = await ArticlesExporter.export(widget.articleController.articleInfos.path, value, exportsDirectoryPath);
                if (isArticleExported && context.mounted) {
                  showBottomSnackBar(
                    context, 
                    S.of(context).articles_export_confirmed, 
                    S.of(context).articles_export_confirmed_button, 
                    () async {
                      openFileExplorerAt("${await StaticVariables.fileSource.getAppDirectoryPath()}/ressources/exports");
                    }, 
                    10
                  );
                } else if (context.mounted) {
                  showBottomSnackBar(
                    context, 
                    S.of(context).articles_export_canceled, 
                    S.of(context).snacbar_close_button, 
                    () {}, 
                    10
                  );                }
              },
              itemBuilder: (context) {
                return [
                PopupMenuItem(
                    enabled: false,
                    child: Text(
                      S.of(context).articles_export_articles_choose_category,
                      style: theme.titleMedium.copyWith(color: theme.onPrimary)
                    )
                  ),
                  ...ArticleCategory.values
                  .where((element) => element != ArticleCategory.created)
                  .map((category) => 
                  PopupMenuItem(
                    value: category,
                    child: Text(
                      categoriesTranslatedNames[category] ?? "",
                      style: theme.bodyMedium.copyWith(color: theme.onPrimary)
                    )
                  ),
                )
                ];
              }
            ),
          )
        ],
      ),
    );
  }
}

IconData _whatIconToUse(Widget item) {
  if (item is ArticlesTextElement) {
    return Icons.text_fields_rounded;
  } else if (item is ArticlesImageElement) {
    return Icons.photo_outlined;
  } else if (item is ArticlesSubtitleElement) {
    return Icons.title_rounded;
  } else if (item is ArticlesListElement) {
    return Icons.format_list_bulleted_rounded;
  } else if (item is ArticlesCodeElement) {
    return Icons.code_rounded;
  }
  return Icons.error_outline_rounded;
}

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

String _whatTextToUse(Widget item) {
  if (item is ArticlesTextElement) {
    return _truncateText(item.controller.textContent, 16);
  } else if (item is ArticlesImageElement) {
    return _truncateText(item.controller.description, 16);
  } else if (item is ArticlesSubtitleElement) {
    return _truncateText(item.controller.textContent, 16);
  } else if (item is ArticlesListElement) {
    return _truncateText(item.controller.content.first.text, 16);
  } else if (item is ArticlesCodeElement) {
    return _truncateText(item.controller.code, 16);
  }
  return "";
}

Map<ArticleCategory, String> categoriesTranslatedNames = {
  ArticleCategory.created : S.current.articles_my_articles_title,
  ArticleCategory.creativity: S.current.articles_creativity_title,
  ArticleCategory.dailyLife : S.current.articles_daily_life_title,
  ArticleCategory.education: S.current.articles_education_title,
  ArticleCategory.environment: S.current.articles_environment_title,
  ArticleCategory.finance : S.current.articles_finance_title,
  ArticleCategory.food : S.current.articles_food_title,
  ArticleCategory.philosophy: S.current.articles_philosophy_title,
  ArticleCategory.politic: S.current.articles_politics_title,
  ArticleCategory.professional: S.current.articles_professional_title,
  ArticleCategory.science : S.current.articles_science_title,
  ArticleCategory.technology : S.current.articles_technology_title, 
  ArticleCategory.travel : S.current.articles_travel_title,
  ArticleCategory.wellness : S.current.articles_wellness_title 
};