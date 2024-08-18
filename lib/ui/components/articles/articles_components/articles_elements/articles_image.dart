import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_image_fullview.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menu_articles_image_description.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_element_envelop.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesImageElementController extends ChangeNotifier{
  Widget? imageWidget;
  String description = "";
  String imageUrl = "";
  Image? image;
  double contentWidth = 400;
  ArticlesImageElementController({required String? initialDescription, required String? initialUrl}) {
    description = initialDescription ?? "";
    imageUrl = initialUrl ?? "";
  }

  setImageWidget() async {
    try {
      if (imageUrl == "") {return;}
      final dynamic image = await AppImages.getImage(imageUrl);
        imageWidget = image 
        ?? SizedBox(
          height: 220,
          width: contentWidth,
          child: const Center(
            child: Icon(Icons.error_outline_rounded),
          ),
        );
    } catch (e) {
        imageWidget = const Icon(Icons.error_outline_rounded);
    }
  }

  setDescription(String newDescription) {
    description = newDescription;
    notifyListeners();
  }
}

class ArticlesImageElement extends StatefulWidget {
  final String? initialUrl;
  final Function(Key) removeFunction;
  final String? initialDescription;
  late final ArticlesImageElementController controller;

  final bool readOnly;

  ArticlesImageElement({
    this.initialUrl,
    this.initialDescription,
    super.key,
    required this.removeFunction,
    this.readOnly = false 
  }) {
    controller = ArticlesImageElementController(initialDescription: initialDescription, initialUrl: initialUrl);
  }

  @override
  State<ArticlesImageElement> createState() => _ArticlesImageElementState();
}

class _ArticlesImageElementState extends State<ArticlesImageElement> {

  @override
  void initState() {
    widget.controller.setImageWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25, right: 10, left: 10),
      child: ArticlesElementEnvelop(
        removeFunction: widget.removeFunction,
        keyToRemove: widget.key ?? UniqueKey(),
        sideMenuIconOffsetOnYAxis: 2,
        readOnly: widget.readOnly,
        child: _ArticlesImageElementContent(theme: theme, controller: widget.controller, readOnly: widget.readOnly),
      ),
    );
  }
}


// ignore: must_be_immutable
class _ArticlesImageElementContent extends StatefulWidget implements IArticlesWriteElement {
  const _ArticlesImageElementContent({
    required this.theme,
    required this.controller,
    required this.readOnly
  });

  final bool readOnly;

  final StylesGetters theme;
  final ArticlesImageElementController controller;

  @override
  State<_ArticlesImageElementContent> createState() => _ArticlesImageElementContentState();
  
  @override
  dynamic get data => {"url": controller.imageUrl, "description" : controller.description};
  
  @override
  set data(newData) {
    controller.imageUrl = controller.imageUrl;
  }
}

class _ArticlesImageElementContentState extends State<_ArticlesImageElementContent> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    widget.controller.contentWidth = MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width / 2.6 : MediaQuery.of(context).size.width / 2;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Icon(Icons.abc, size: 0, color: Colors.transparent),
            ),
            FutureBuilder(
              future: widget.controller.setImageWidget(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: widget.controller.contentWidth),
                    height: 220,
                    color: widget.theme.primaryContainer,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    constraints: BoxConstraints(maxWidth: widget.controller.contentWidth),
                    height: 220,
                    color: Colors.red,
                    child: const Center(
                      child: Text('Failed to load image'),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      if (widget.controller.imageWidget is Image) {
                        showFullImage(widget.controller.imageWidget as Image, context);
                      }
                    },
                    onScaleUpdate: (details) {
                      _scale = details.scale;
                    },
                    onScaleEnd: (details) {
                      if (_scale > 1.0 && widget.controller.imageWidget is Image) {
                        showFullImage(widget.controller.imageWidget as Image, context);
                        _scale = 1.0;
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: widget.controller.contentWidth),
                        child: widget.controller.imageWidget
                        ??Center(
                          child: Container(
                            width: widget.controller.contentWidth,
                            height: 220,
                            color: widget.theme.primaryContainer,
                            child: Center(
                              child: CustomTextButton(
                                S.of(context).articles_images_add_button,
                                () async {
                                  String? imageName = await AppImages.pickImage();
                                  widget.controller.imageUrl = imageName ?? "";
                                  await widget.controller.setImageWidget();
                                  setState(() {});
                                },
                                false,
                                false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        SizedBox(
          width: widget.controller.contentWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!widget.readOnly)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          String? imageName = await AppImages.pickImage();
                          widget.controller.imageUrl = imageName ?? widget.controller.imageUrl;
                          await widget.controller.setImageWidget();
                          setState(() {});
                        },
                        child: Tooltip(message: S.of(context).articles_images_change_button,child: const Icon(Icons.photo_outlined)),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, child) {
                    return CustomTooltip(
                      message: widget.controller.description,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            if (widget.readOnly) {
                              return;
                            }
                            widget.controller.description = await showDescriptionEditingMenu(context, widget.controller.description);
                            setState(() {});
                          },
                          child: const Icon(Icons.more_horiz),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

