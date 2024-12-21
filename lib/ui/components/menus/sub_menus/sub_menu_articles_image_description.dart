import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

Future<String> showDescriptionEditingMenu(BuildContext context, String initialDescription) async {
  Completer<String> completer = Completer();

  String description = initialDescription;
  showSubMenu(
    context, 
    ArticlesWriteViewImageDescriptionMenu(
      initialDescription: initialDescription,
      onChanged: (String value) {
        description = value;
      },
      completer: completer,
    ),
    onMenuDismissed: () {
      completer.complete(description);
    }
  );

  return completer.future;
}

// ignore: must_be_immutable
class ArticlesWriteViewImageDescriptionMenu extends StatelessWidget {
  late String description;
  final String initialDescription;
  final Completer<String> completer;
  final Function(String)? onChanged;
  ArticlesWriteViewImageDescriptionMenu({super.key, required this.initialDescription, required this.completer, this.onChanged}) {
    description = initialDescription;
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
          border: Border.all(
            color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
            width: 0.5
          )
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
                        copyWith(color: theme.onPrimary),
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
                      child: TextField (
                        onChanged: (value) {
                          description = value;
                          if (onChanged != null) {
                            onChanged!(value);
                          }
                        },
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 350,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextButton(
                    S.of(context).submenu_artilces_image_description_button, 
                    () {
                      completer.complete(description);
                      Navigator.pop(context);
                    }, 
                    false, 
                    false
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}


