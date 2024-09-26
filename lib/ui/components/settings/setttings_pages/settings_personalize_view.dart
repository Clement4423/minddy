import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/settings/settings_components/settings_page_top_bar.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_personalize_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class PersonalizeView extends StatefulWidget {
  final PersonalizeViewController controller;

  const PersonalizeView(this.controller, {super.key});

  @override
  State<PersonalizeView> createState() => _PersonalizeViewState();
}

class _PersonalizeViewState extends State<PersonalizeView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);

    return Column(
      children: [
        SettingsPagebar(S.of(context).settings_personalize_title),
        Expanded(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
                child: ListView(
                  children: [
                    // Theme
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.of(context).settings_theme_subtitle,
                        style: theme.bodySmall.copyWith(color: Colors.grey),
                      ),
                    ),
                    // Theme value
                    Tooltip(
                      message: StaticVariables.currentProjectInfo == null ? '' : S.of(context).settings_need_to_quit_project_to_change_theme,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDropdownButton(
                          width: 300,
                          menuTitle: S.of(context).settings_theme_subtitle,
                          selectedOptionTitle: widget.controller.menuThemeTitle,
                          theme: theme,
                          items: widget.controller.getThemeItems(context),
                          enabled: StaticVariables.currentProjectInfo != null ? false : true,
                           // Not enabled if in a project, this is done because the change of ui causes the modules to 
                           // duplicate and create problems 
                        ),
                      ),
                    ),
                    // Use black and white
                    Tooltip(
                      message: StaticVariables.currentProjectInfo == null ? '' : S.of(context).settings_need_to_quit_project_to_change_theme,
                      child: SwitchTile(
                        widget.controller.isUsingBWMode, 
                        S.of(context).settings_personalize_black_and_white_title,
                        (value) async {
                          await widget.controller.setBWMode(value);
                        },
                        enabled: StaticVariables.currentProjectInfo != null ? false : true,
                        false
                      ),
                    ),
                    // Date format
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          S.of(context).settings_date_format_subtitle,
                          style: theme.bodySmall.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: S.of(context).settings_date_format_tooltip(
                        DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}", 
                        DateTime.now().day < 10 ? "0${DateTime.now().day}" : "${DateTime.now().day}"
                      ),
                      child: SwitchTile(
                        widget.controller.prefetUsDateFormat, 
                        S.of(context).settings_date_format,
                        (value) async {
                          await widget.controller.setDateFormat(value);
                        }, 
                        false
                      ),
                    ),
                    // Language
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
                    Tooltip(
                      message: StaticVariables.currentProjectInfo == null ? '' : S.of(context).settings_need_to_quit_project_to_change_language,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDropdownButton(
                          enableSearch: true,
                          width: 300,
                          menuTitle: S.of(context).settings_language_subtitle,
                          selectedOptionTitle: widget.controller.menuLanguageTitle,
                          theme: theme,
                          items: widget.controller.getLanguageItems(context),
                          enabled: StaticVariables.currentProjectInfo != null ? false : true,
                           // Not enabled if in a project, this is done because the change of ui causes the modules to 
                           // duplicate and create problems 
                        ),
                      ),
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
