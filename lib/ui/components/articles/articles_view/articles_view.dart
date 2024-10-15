import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/shortcuts/shortcuts_activators.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_back_button.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_bookmark_button.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_action_button.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_bottom_menu_controller.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_saving_controller.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_bottom_menu.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

ShortcutActivator _closeArticleActivator = const SingleActivator(LogicalKeyboardKey.escape);

// Width limit before the article content is shifted on the left
double _widthTreshold = 1000;

Future<dynamic> showArticle(ArticlesViewController controller, BuildContext context) async {

  bool isContentInitalized = await controller.initialize(context);
  if (!isContentInitalized) {
    return;
  }

  if (context.mounted) {
    SavingController savingController = SavingController();
    controller.savingController = savingController;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dismissible(
          key: UniqueKey(),
          movementDuration: const Duration(milliseconds: 700),
          direction: DismissDirection.startToEnd,
          dismissThresholds: const {
            DismissDirection.startToEnd: 0.60
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              controller.saveArticle(isClosingArticle: true);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                controller.sizeChanged(context);
                StylesGetters theme = StylesGetters(context);
                double screenWidth = MediaQuery.of(context).size.width;
                return ArticleView(theme: theme, screenWidth: screenWidth, savingController: savingController, controller: controller);
              }
            ),
          ),
        );
      },
    );
  }
}

class ArticleView extends StatefulWidget {
  const ArticleView({
    super.key,
    required this.theme,
    required this.screenWidth,
    required this.savingController,
    required this.controller
  });

  final StylesGetters theme;
  final double screenWidth;
  final SavingController savingController;
  final ArticlesViewController controller;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  bool _isClosing = false;

  void _closeArticle(BuildContext context) {
    if (context.mounted) {
      setState(() {
        _isClosing = true;
      });
      Future.delayed(Duration(milliseconds: _isClosing ? 150 : 250), () {
        if (context.mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: _isClosing ? 150 : 250),
      curve: Curves.easeInOut,
      tween: Tween(
        begin: _isClosing ? 1.0 : 0.0,
        end: _isClosing ? 0.0 : 1.0
      ),
      builder: (context, opacity, child) {
        return AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return Opacity(
              opacity: opacity,
              child: Material(
                type: MaterialType.transparency,
                elevation: 12,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          color: widget.theme.secondaryContainer.withOpacity(0.70),
                          child: Container(),
                        ),
                      ),
                    ),
                    // Top bar with actions and title;
                    CallbackShortcuts(
                      bindings: <ShortcutActivator, VoidCallback>{
                        saveActivator: () async {
                          await widget.controller.saveArticle();
                        },
                        _closeArticleActivator:() async {
                          await widget.controller.saveArticle();
                          if (context.mounted) {
                            _closeArticle(context);
                          }
                        }
                      },
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 170,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Back button
                                    ArticlesBackButton(
                                      action: () {
                                        widget.controller.saveArticle(isClosingArticle: true);
                                         _closeArticle(context);
                                         widget.controller.resetFunction(); 
                                        },
                                    ),
                                    // Actions Row
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AnimatedBuilder(
                                          animation: widget.savingController,
                                          builder: (context, child) {
                                            if (widget.savingController.isSaving) {
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: CircularProgressIndicator(
                                                    color: widget.theme.onPrimary,
                                                    strokeWidth: 3,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          }
                                        ),
                                        ..._getActionRow(!widget.controller.readOnly, widget.controller)
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: widget.screenWidth > _widthTreshold ? MainAxisAlignment.center : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title and info box
                                    Padding(
                                      padding: EdgeInsets.only(left: widget.screenWidth > _widthTreshold ? 0 : widget.screenWidth / 7),
                                      child: SizedBox(
                                        width: widget.controller.contentWidth,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomTooltip(
                                              message: widget.controller.articleTitle,
                                              child: TextField(
                                                onChanged: (value) => widget.controller.articleTitleChanged(value),
                                                readOnly: widget.controller.readOnly,
                                                controller: TextEditingController(text: widget.controller.articleTitle == "" ? null : widget.controller.articleTitle),
                                                style: widget.theme.titleLarge.copyWith(color: widget.theme.onPrimary, fontSize: 30, overflow: TextOverflow.ellipsis),
                                                mouseCursor: widget.controller.readOnly ? SystemMouseCursors.basic : SystemMouseCursors.text,
                                                cursorColor: widget.theme.onPrimary,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: S.of(context).articles_title_hint
                                                ),
                                                maxLines: 2,
                                                minLines: 1,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                MouseRegion(
                                                  cursor: widget.controller.readOnly 
                                                    ? SystemMouseCursors.basic
                                                    : SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (widget.controller.readOnly) {
                                                        return;
                                                      }
                                                      widget.controller.calculateArticleReadingTime(); 
                                                      widget.controller.orderChanged();
                                                    },
                                                    child: Tooltip(
                                                      message: widget.controller.readOnly 
                                                        ? ''
                                                        : S.of(context).articles_calculate_reading_time,
                                                      child: Text(
                                                        "${widget.controller.articleReadingTime} min",
                                                        style: widget.theme.headlineSmall.copyWith(color: widget.theme.onPrimary),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 3,
                                                    height: 3,
                                                    decoration: BoxDecoration(
                                                      color: widget.theme.onPrimary,
                                                      borderRadius: BorderRadius.circular(2),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  widget.controller.articleInfos.author,
                                                  style: widget.theme.bodySmall.copyWith(color: widget.theme.onPrimary),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Article content
                          _ArticleContentList(controller: widget.controller),
                        ],
                      ),
                    ),
                    // Bottom menu
                    Positioned(
                      bottom: 0,
                      right: 0, 
                      child: widget.controller.readOnly 
                      ? const SizedBox()
                      : ArticlesBottomMenu(controller: ArticlesBottomMenuController(articleController: widget.controller)),
                    ), 
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}

class _ArticleContentList extends StatefulWidget {
  final ArticlesViewController controller;
  const _ArticleContentList({required this.controller});

  @override
  State<_ArticleContentList> createState() => _ArticleContentListState();
}

class _ArticleContentListState extends State<_ArticleContentList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.only(
          left: screenWidth > _widthTreshold 
            ? ((screenWidth / 2) - (widget.controller.contentWidth / 2) - 40)
            : (screenWidth / 7) - 40,
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                ...widget.controller.articleContent,
                SizedBox(height: MediaQuery.of(context).size.height / 1.5),
              ],
            )
          ]
        ),
      ),
    );
  }
}

List<Widget> _getActionRow(bool needToShow, ArticlesViewController controller) {
  if (needToShow) {
    return [ 
      ArticlesActionButton(
        icon: Icons.code_rounded, 
        semanticLabel: S.current.articles_add_code_semantic_text,
        action: controller.addCodeElement
      ),
      ArticlesActionButton(
        icon: Icons.format_list_bulleted_rounded, 
        semanticLabel: S.current.articles_add_list_semantic_text,
        action: controller.addListElement
      ),
      ArticlesActionButton(
        icon: Icons.photo_outlined, 
        semanticLabel: S.current.articles_add_image_semantic_text,
        action: controller.addImageElement
      ),
      ArticlesActionButton(
        icon: Icons.title_rounded,
        semanticLabel: S.current.articles_add_subtitle_semantic_text,
        action: controller.addSubtitleElement
      ),
      ArticlesActionButton(
        icon: Icons.text_fields_rounded, 
        semanticLabel: S.current.articles_add_text_semantic_text,
        action: controller.addTextElement
      ),
      ArticlesBookmarkButton(
        articlePath: controller.articleInfos.path,
        isArticleBookmarked: controller.articleInfos.isBookmarked,
      ),
    ];
  } else {
    return [];
  }
}