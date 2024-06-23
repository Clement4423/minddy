import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_image_fullview.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomImageDisplay extends StatefulWidget implements IArticlesWriteElement {
  CustomImageDisplay({
    super.key,
    required this.initialUrl,
    required this.initialDescription
  });

  final String initialUrl;
  final String initialDescription;

  @override
  State<CustomImageDisplay> createState() => _CustomImageDisplayState();
  
  @override
  var data = {};
}

class _CustomImageDisplayState extends State<CustomImageDisplay> {
  Widget _imageWidget = const Icon(Icons.error_outline_rounded);
  late Future<void> _imageFuture;

  String url = '';
  String description = '';

  Future<void> _setImageWidget() async {
    try {
      if (widget.data['url'] == "") {return;}
      final dynamic image = await AppImages.getImage(widget.data['url']);
      setState(() {
        _imageWidget = image 
        ?? const SizedBox(
          height: 220,
          width: 500,
          child: Center(
            child: Icon(Icons.error_outline_rounded),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _imageWidget = const Icon(Icons.error_outline_rounded);
      });
    }
  }

  @override
  void initState() {
    widget.data = {'url': widget.initialUrl, 'description': widget.initialDescription};

    url = widget.initialUrl;
    description = widget.initialDescription;
    _imageFuture = _setImageWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    height: 220,
                    color: theme.primaryContainer,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    height: 220,
                    color: theme.primaryContainer,
                    child: const Center(
                      child: Text('Failed to load image'),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      if (_imageWidget is Image) {
                        showFullImage(_imageWidget as Image, context);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: _imageWidget is Image
                        ? _imageWidget
                        : Center(
                          child: Container(
                            width: 500,
                            height: 220,
                            color: theme.primaryContainer,
                            child: Center(
                              child: CustomTextButton(
                                S.of(context).articles_images_add_button,
                                () async {
                                  String? imageName = await AppImages.pickImage();
                                  widget.data['url'] = imageName ?? "";
                                  _imageFuture = _setImageWidget();
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
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      String? imageName = await AppImages.pickImage();
                      widget.data['url'] = imageName ?? widget.data['url'];
                      _imageFuture = _setImageWidget();
                      setState(() {});
                    },
                    child: Tooltip(
                      message: S.of(context).articles_images_change_button,
                      child: const Icon(Icons.photo_outlined),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTooltip(
                  message: widget.data['description'] ?? '',
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        // TODO: Revoir l'édition de la description des images dans les notes
                      },
                      child: const Icon(Icons.more_horiz),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}