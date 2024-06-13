import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_image.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class ArticlesWriteViewImageDescriptionMenu extends StatelessWidget {
  final ArticlesImageElementController controller;
  late String description;
  ArticlesWriteViewImageDescriptionMenu({super.key, required this.controller}) {
    description = controller.description;
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SizedBox(
      width: 350,
      height: 450,
      child: Container(
        width: 350,
        height: 450,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: Text(
                S.of(context).submenu_artilces_image_description_title, 
                style: theme.titleLarge
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).submenu_artilces_image_description_subtitle, 
                        style: theme.bodySmall.
                        copyWith(color: theme.onBackground),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 120,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextSelectionTheme(
                        data: TextSelectionThemeData(
                          selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary,
                        ),
                        child: TextField (
                          onChanged: (value) => description = value,
                          controller: TextEditingController(text: description),
                          style: theme.bodyMedium.
                          copyWith(color: theme.onSurface),
                          cursorColor: theme.onSurface,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: S.of(context).submenu_artilces_image_description_hint,
                            hintStyle: theme.bodyMedium.copyWith(color: Colors.grey),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 350,
                height: 60,
                child: CustomTextButton(
                  S.of(context).submenu_artilces_image_description_button, 
                  () {
                    controller.setDescription(description);
                    Navigator.pop(context);
                  }, 
                  false, 
                  false
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}


