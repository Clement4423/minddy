import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesImporterImagesImportSubMenu extends StatefulWidget {
  const ArticlesImporterImagesImportSubMenu({super.key, required this.imagesPathsList});

  final List<String> imagesPathsList;

  @override
  State<ArticlesImporterImagesImportSubMenu> createState() => _ArticlesImporterImagesImportSubMenuState();
}

class _ArticlesImporterImagesImportSubMenuState extends State<ArticlesImporterImagesImportSubMenu> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 350,
      height: 250,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Text(
              S.of(context).articles_importer_import_images_title,
              style: theme.titleLarge
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(_getTextBasedOnImagesCount(widget.imagesPathsList.length), style: theme.bodyMedium.copyWith(color: theme.onPrimary))
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 170,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextButton(
                    S.of(context).articles_importer_dont_import_images_button,
                    () {
                      Navigator.pop(context);
                    },
                    false,
                    false,
                    isSecondary: true,
                  ),
                )
              ),
              SizedBox(
                width: 170,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextButton(
                    S.of(context).articles_importer_import_images_button, 
                    () async {
                      for (String path in widget.imagesPathsList) {
                        await AppImages.saveImage(path, path.split('/').last);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }, 
                    false, 
                    false
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}

String _getTextBasedOnImagesCount(int count) {
  if (count > 1) {
    return S.current.articles_importer_images_found_many(count);
  } else {
    return S.current.articles_importer_image_found_single;
  }
}