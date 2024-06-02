import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/components/cards/articles_card_controller.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticleCardWrite extends StatefulWidget {
  final Function refreshMethod;
  final ArticleCardWriteController _controller;
  final IconData icon;

  const ArticleCardWrite(this.icon, this._controller, {super.key, required this.refreshMethod});

  @override
  State<ArticleCardWrite> createState() => _ArticleCardWriteState();
}

class _ArticleCardWriteState extends State<ArticleCardWrite> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 12),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        width: 315,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.surface,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 5),
              blurRadius: 10,
              color: theme.shadow.withOpacity(0.05),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: widget._controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child: widget._controller.infos.title.length > 29
                          ? CustomTooltip(
                              message: widget._controller.infos.title,
                              waitDuration: const Duration(milliseconds: 300),
                              child: Text(
                                widget._controller.infos.title,
                                style: theme.titleLarge.copyWith(color: theme.onSurface),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          : Text(
                              widget._controller.infos.title.isNotEmpty
                                  ? widget._controller.infos.title
                                  : S.of(context).articles_card_untitled,
                              style: theme.titleLarge.copyWith(color: theme.onSurface),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                    ),
                    CustomPopupMenuButton(
                      items: [
                        CustomPopupItemModel(
                          text: Text(
                            S.of(context).articles_bookmark_semantic_text,
                            style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                          ),
                          icon: Icon(widget._controller.isBookmarked 
                            ? Icons.bookmark_rounded 
                            : Icons.bookmark_outline_rounded, 
                            color: theme.onPrimary
                          ),
                          action: () {
                            widget._controller.toggleBookmark();
                          },
                        ),
                        CustomPopupItemModel(
                          text: Text(
                            S.of(context).project_card_delete,
                            style: theme.bodyMedium.copyWith(color: theme.error),
                          ),
                          icon: Icon(Icons.delete_outline_rounded, color: theme.error),
                          action: () {
                            showBottomSnackBar(
                              context,
                              S.of(context).snackbar_delete_element_text(S.of(context).articles_card_delete_this_article),
                              S.of(context).snackbar_delete_button,
                              widget._controller.deleteArticle,
                              12,
                              argument: widget.refreshMethod
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: theme.onSurface, size: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "${widget._controller.infos.readingTime} min",
                              style: theme.headlineSmall.copyWith(color: theme.onSurface),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 3,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          Text(widget._controller.infos.author, style: theme.bodySmall.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        width: 100,
                        child: TextButton(
                          onPressed: () {showArticle(ArticlesViewController(widget._controller.infos, widget.refreshMethod), context);},
                          style: ButtonThemes.primaryButtonStyle(context),
                          child: Text(
                            S.of(context).articles_read_button,
                            style: theme.titleSmall
                            .copyWith(color: theme.onSecondary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
