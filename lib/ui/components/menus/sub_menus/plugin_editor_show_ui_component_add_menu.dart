import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_ui_editor_new_component_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

Future<IPluginUiComponent?> showUiComponentAddMenu(BuildContext context, List<PlugnUiComponentsAddMenuModel> componentsToShow, StylesGetters theme, Function(IPluginUiComponent?) onSelected, bool autosearch, double maxWidth, double maxHeight) async {
  Completer<IPluginUiComponent?> completer = Completer<IPluginUiComponent?>();

  showSubMenu(
    context, 
    onMenuDismissed: () {
      completer.complete(null);
    },
    PluginUiEditorNewComponentSubMenu(
      onSelected: (IPluginUiComponent? component) {
        onSelected(component);
        completer.complete(component);
      },
      componentsToShow: componentsToShow,
      onClosed: () {
        Navigator.pop(context);
      },
      autosearch: autosearch,
      theme: theme,
      maxWidth: maxWidth,
      maxHeight: maxHeight
    ),
  );

  return completer.future;
}