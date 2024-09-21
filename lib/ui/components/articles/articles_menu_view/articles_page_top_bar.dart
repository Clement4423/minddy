import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/articles/article_categories.dart';
import 'package:minddy/system/articles/articles_importer/articles_importer.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesPagebar extends StatelessWidget {
  final String title;
  final Function resetFunction;
  const ArticlesPagebar(this.title, {required this.resetFunction, super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.titleLarge.
                copyWith(color: theme.onPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Tooltip(
                  message: S.of(context).articles_import_articles,
                  child: IconButton(
                    onPressed: () async {
                     bool? isArticleImported =  await ArticlesImporter.import(context);
                     if (context.mounted) {
                      if (isArticleImported != null && isArticleImported) {
                        NotificationHandler.addNotification(
                          NotificationModel(
                            content: S.of(context).articles_imported,
                            action: null, 
                            actionLabel: S.of(context).snacbar_close_button, 
                            duration: NotificationDuration.long
                          )
                        );
                        resetFunction();
                      }
                      else {
                        NotificationHandler.addNotification(
                          NotificationModel(
                            content: S.of(context).articles_not_imported,
                            action: null, 
                            actionLabel: S.of(context).snacbar_close_button, 
                            duration: NotificationDuration.long
                          )
                        );
                      }
                     }
                    }, 
                    icon: Icon(Icons.arrow_downward_rounded, color: theme.onPrimary),
                    style: ButtonThemes.secondaryButtonStyle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Tooltip(
                    message: S.of(context).articles_new_article,
                    child: IconButton(
                      onPressed: () async {
                        ArticleInfo? infos = await AppArticles.createArticle(
                          title: "", 
                          relativeFolderPath: "shared/articles", 
                          isMultiLanguage: false,
                          languageCode: await AppConfig.getConfigValue("language") ?? 'en', 
                          category: ArticleCategory.created,
                        );
                        resetFunction();
                        showArticle(ArticlesViewController(infos!, resetFunction), context.mounted ? context : context);
                      }, 
                      icon: Icon(Icons.add_rounded, color: theme.onSecondary),
                      style: ButtonThemes.primaryButtonStyle(context),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}