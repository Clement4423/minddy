import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_color_input.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/settings/settings_components/settings_page_top_bar.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_project_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectSettingsView extends StatelessWidget {
  final ProjectSettingsViewModel _controller;
  const ProjectSettingsView(this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      children: [
        SettingsPagebar(_controller.projectName),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
            child: ListView(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).settings_project_rename_subtitle,
                    style: theme.bodySmall.copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),                      
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextSelectionTheme(
                    data: TextSelectionThemeData(
                      selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary
                    ),
                    child: TextField(
                      onChanged: (newValue) {
                        _controller.projectNameChanged(newValue);
                      },
                      controller: TextEditingController(text: _controller.projectName),
                      cursorColor: theme.onPrimary,
                      textAlign: TextAlign.start,
                      maxLength: 20,
                      style: theme.bodyMedium.copyWith(color: theme.onSurface),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Visibility(
                      visible: _controller.errorMessage.isNotEmpty,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _controller.errorMessage, 
                          style: theme.bodySmall.
                          copyWith(color: theme.error),
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextButton(
                      S.of(context).settings_project_rename_button, 
                      _controller.modifyProjectName, 
                      true, 
                      false, 
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      S.of(context).node_editor_view_side_panel_variables_variable_type_color,
                      style: theme.bodySmall.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: CustomColorInput(
                        theme: theme,
                        useOpacity: false,
                        color: _controller.color, 
                        onColorChanged: (color) {
                          _controller.color = color;
                          _controller.modifyColor(context);
                        }
                      )
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      S.of(context).settings_project_privacy_subtitle,
                      style: theme.bodySmall.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SwitchTile(
                        key: UniqueKey(),
                        _controller.isPrivate, 
                        S.of(context).settings_project_private_project, 
                        (value) {
                          _controller.modifyIsPrivate(value, context);
                        }, 
                        false
                      )
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      S.of(context).settings_project_delete_subtitle,
                      style: theme.bodySmall.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextButton(
                      S.of(context).settings_project_delete_button, 
                      _controller.deleteProject, 
                      true, 
                      false,
                      isCritic: true
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ],
    );
  }
}