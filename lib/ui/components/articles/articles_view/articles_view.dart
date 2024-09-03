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

ShortcutActivator _closeArticle = const SingleActivator(LogicalKeyboardKey.escape);

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
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Material(
                      type: MaterialType.transparency,
                      elevation: 12,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                color: theme.secondaryContainer.withOpacity(0.70),
                                child: Container(),
                              ),
                            ),
                          ),
                          // Top bar with actions and title;
                          CallbackShortcuts(
                            bindings: <ShortcutActivator, VoidCallback>{
                              saveActivator: () async {
                                await controller.saveArticle();
                              },
                              _closeArticle:() async {
                                await controller.saveArticle();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: Column(
                              crossAxisAlignment: screenWidth > _widthTreshold ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
                                              controller.saveArticle(isClosingArticle: true);
                                               controller.resetFunction();
                                              },
                                          ),
                                          // Actions Row
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AnimatedBuilder(
                                                animation: savingController,
                                                builder: (context, child) {
                                                  if (savingController.isSaving) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: CircularProgressIndicator(
                                                          color: theme.onPrimary,
                                                          strokeWidth: 3,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                }
                                              ),
                                              ..._getActionRow(!controller.readOnly, controller)
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: screenWidth > _widthTreshold ? MainAxisAlignment.center : MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Title and info box
                                          Padding(
                                            padding: EdgeInsets.only(left: screenWidth > _widthTreshold ? 0 : screenWidth / 7),
                                            child: SizedBox(
                                              width: controller.contentWidth,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CustomTooltip(
                                                    message: controller.articleTitle,
                                                    child: TextField(
                                                        onChanged: (value) => controller.articleTitleChanged(value),
                                                        readOnly: controller.readOnly,
                                                        controller: TextEditingController(text: controller.articleTitle == "" ? null : controller.articleTitle),
                                                        style: theme.titleLarge.copyWith(color: theme.onPrimary, fontSize: 30, overflow: TextOverflow.ellipsis),
                                                        cursorColor: theme.onPrimary,
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
                                                        cursor: controller.readOnly 
                                                          ? SystemMouseCursors.basic
                                                          : SystemMouseCursors.click,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (controller.readOnly) {
                                                              return;
                                                            }
                                                            controller.calculateArticleReadingTime(); 
                                                            controller.orderChanged();
                                                          },
                                                          child: Tooltip(
                                                            message: controller.readOnly 
                                                              ? ''
                                                              : S.of(context).articles_calculate_reading_time,
                                                            child: Text(
                                                              "${controller.articleReadingTime} min",
                                                              style: theme.headlineSmall.copyWith(color: theme.onPrimary),
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
                                                            color: theme.onPrimary,
                                                            borderRadius: BorderRadius.circular(2),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        controller.articleInfos.author,
                                                        style: theme.bodySmall.copyWith(color: theme.onPrimary),
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
                                _ArticleContentList(controller: controller),
                              ],
                            ),
                          ),
                          // Bottom menu
                          Positioned(
                            bottom: 0,
                            right: 0, 
                            child: controller.readOnly 
                            ? const SizedBox()
                            : ArticlesBottomMenu(controller: ArticlesBottomMenuController(articleController: controller)),
                          ), 
                        ],
                      ),
                    );
                  }
                );
              }
            ),
          ),
        );
      },
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
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth > _widthTreshold ? 0 : screenWidth / 7 - 24),
        child: SizedBox(
          width: screenWidth > _widthTreshold ?  
            widget.controller.contentWidth + 53
            : screenWidth / 1.5,

          child: ListView.builder(
            padding: const EdgeInsets.only(right: 20),
            controller: _scrollController,
            itemCount: widget.controller.articleContent.length + 2,
            semanticChildCount: widget.controller.articleContent.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: 50);
              }
              else if (index < widget.controller.articleContent.length + 1) {
                return widget.controller.articleContent[index - 1];
              } else {
                return SizedBox(height: MediaQuery.of(context).size.height / 1.5);
              }
            },
          ),
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