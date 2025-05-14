import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_padding.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_input.dart';
import 'package:minddy/ui/theme/theme.dart';

import 'package:minddy/ui/components/plugin_ui/side_panel/plugin_editor_ui_view_side_panel.dart';

List<PluginEditorUiViewSidePanelPropertiesElementList> getPaddingProperties(PluginUiComponentPaddingProperties properties, StylesGetters theme, BuildContext context, Function onPropertiesChanged, Function updateSidePanel) {
  List<PluginEditorUiViewSidePanelPropertiesElementList> list = [];

  PluginEditorUiViewSidePanelPropertiesElementList padding = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: 'Padding', 
    elements: [
      CustomIconInput(
        theme: theme,
        hint: "Top",
        initialValue: properties.padding.top.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: const Icon(
          Icons.border_top_rounded
        ),
        onChanged: (value) {
          properties.padding = properties.padding.copyWith(top: (double.tryParse(value) ?? properties.padding.top).clamp(0, 999));
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: "Left",
        initialValue: properties.padding.left.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: const Icon(
          Icons.border_left_rounded
        ),
        onChanged: (value) {
          properties.padding = properties.padding.copyWith(left: (double.tryParse(value) ?? properties.padding.left).clamp(0, 999));
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: "Bottom",
        initialValue: properties.padding.bottom.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: const Icon(
          Icons.border_bottom_rounded
        ),
        onChanged: (value) {
          properties.padding = properties.padding.copyWith(bottom: (double.tryParse(value) ?? properties.padding.bottom).clamp(0, 999));
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: "Right",
        initialValue: properties.padding.right.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: const Icon(
          Icons.border_right_rounded
        ),
        onChanged: (value) {
          properties.padding = properties.padding.copyWith(right: (double.tryParse(value) ?? properties.padding.right).clamp(0, 999));
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );

  list.add(padding);

  return list;
}
