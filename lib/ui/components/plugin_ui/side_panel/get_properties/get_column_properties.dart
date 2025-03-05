import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

import '../plugin_editor_ui_view_side_panel.dart';

List<PluginEditorUiViewSidePanelPropertiesElementList> getColumnProperties(PluginUiComponentColumnProperties properties, StylesGetters theme, BuildContext context, Function onPropertiesChanged, Function updateSidePanel) {
  List<PluginEditorUiViewSidePanelPropertiesElementList> list = [];

  PluginEditorUiViewSidePanelPropertiesElementList size = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_size_subtitle, 
    elements: [
      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_size_width,
        initialValue: properties.width.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Transform.rotate(
          angle: pi / 2,
          child: Icon(
            Icons.height_rounded,
            color: theme.onSurface
          ),
        ),
        onChanged: (value) {
          properties.width = (double.tryParse(value) ?? properties.width).clamp(20, 700);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_size_height,
        maxLength: 3,
        initialValue: properties.height.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.height_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.height = (double.tryParse(value) ?? properties.height).clamp(20, 420);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );

  list.add(size);

  PluginEditorUiViewSidePanelPropertiesElementList aligment = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_style_alignment, 
    elements: [
      CustomDropdownButton(
        width: 280,
        menuTitle: 'Vertical',
        enableSearch: true,
        isMultipleSelectionMenu: true,
        onMenuClosed: updateSidePanel,
        selectedOptionTitle: properties.chilrenAligment.mainAxisAlignment.toString(), 
        items: [
          ...MainAxisAlignment.values.map((aligment) {
            return CustomSelectionMenuItem(
              label: aligment.toString(),
              icon: null,
              onTap: () {
                properties.chilrenAligment.mainAxisAlignment = aligment;
                onPropertiesChanged();
                updateSidePanel();
              }
            );
          })
        ],
        theme: theme
      ),
      CustomDropdownButton(
        width: 280,
        menuTitle: 'Horizontal',
        enableSearch: true,
        isMultipleSelectionMenu: true,
        onMenuClosed: updateSidePanel,
        selectedOptionTitle: properties.chilrenAligment.crossAxisAlignment.toString(), 
        items: [
          ...CrossAxisAlignment.values.map((aligment) {
            return CustomSelectionMenuItem(
              label: aligment.toString(),
              icon: null,
              onTap: () {
                properties.chilrenAligment.crossAxisAlignment = aligment;
                onPropertiesChanged();
                updateSidePanel();
              }
            );
          })
        ],
        theme: theme
      )
    ]
  );
  
  list.add(aligment);

  PluginEditorUiViewSidePanelPropertiesElementList style = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_style_subtitle, 
    elements: [
      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_style_alignment,
        maxLength: 2,
        initialValue: properties.borderRadius.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.rounded_corner_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.borderRadius = (double.tryParse(value) ?? properties.borderRadius).clamp(0, 99);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: 'Spacing',
        maxLength: 3,
        initialValue: properties.borderRadius.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.space_bar_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.spacing = (double.tryParse(value) ?? properties.borderRadius).clamp(0, 999);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );
  
  list.add(style);
  return list;
}
