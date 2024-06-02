import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_elements/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_elements/switch_tile.dart';
import 'package:minddy/ui/components/settings/settings_components/settings_page_top_bar.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_personalize_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class PersonalizeView extends StatelessWidget {
  final PersonalizeViewController controller;

  const PersonalizeView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);

    return Column(
      children: [
        SettingsPagebar(S.of(context).settings_personalize_title),
        Expanded(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
                child: ListView(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.of(context).settings_theme_subtitle,
                        style: theme.bodySmall.copyWith(color: Colors.grey),
                      ),
                    ),
                    CustomDropdownButton(
                      menuTitle: controller.menuThemeTitle,
                      action: controller.treatThemeValue,
                      controller: controller,
                      items: controller.getThemeItems(context),
                      needToRestart: true,
                    ),
                    SwitchTile(
                      controller.isUsingBWMode, 
                      S.of(context).settings_personalize_black_and_white_title,
                      (value) {
                        controller.setBWMode(value);
                      },
                      true
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          S.of(context).settings_language_subtitle,
                          style: theme.bodySmall.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    CustomDropdownButton(
                      menuTitle: controller.menuLanguageTitle,
                      action: controller.treatLanguageValue,
                      controller: controller,
                      items: controller.getLanguageItems(context),
                      needToRestart: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
