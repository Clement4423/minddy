import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/model/plugin_ui_component_icon_icons.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_icon.dart';
import 'package:minddy/ui/components/custom_components/custom_color_input.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_input.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_selector_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_theme_color_items.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/plugin_editor_ui_view_side_panel.dart';
import 'package:minddy/ui/theme/theme.dart';

List<PluginEditorUiViewSidePanelPropertiesElementList> getIconPropeties(PluginUiComponentIconProperties properties, StylesGetters theme, BuildContext context, Function onPropertiesChanged, Function updateSidePanel) {
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

  PluginEditorUiViewSidePanelPropertiesElementList style = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_style_subtitle, 
    elements: [

      CustomIconSelectorInput(
        theme: theme, 
        onSelected: (newIcon) {
          properties.iconId = newIcon.iconId;
          onPropertiesChanged();
        }, 
        icon: PluginUiComponentIconIcons.getIcon(properties.iconId)
      ),

      SizedBox(
        width: 280,
        height: 50,
        child: Row(
          spacing: 5,
          children: [
            SizedBox(
              width: 224,
              height: 50,
              child: CustomColorInput(
                theme: theme,
                color: IPluginUiComponentProperties.colorFromText(properties.color), 
                onColorChanged: (newColor) {
                  properties.color = IPluginUiComponentProperties.colorToText(newColor);
                  onPropertiesChanged();
                  updateSidePanel();
                }
              ),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: CustomSelectionMenu(
                theme: theme, 
                type: CustomSelectionMenuButttonType.icon, 
                enableSearch: true,
                menuMaxHeight: 300,
                onMenuClosed: updateSidePanel,
                buttonStyle: properties.color.length >= 6 
                  ? ButtonThemes.secondaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))))
                  : ButtonThemes.primaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                items: getThemeColorItems((text) {properties.color = text;}, properties.color, theme, onPropertiesChanged),
                child: Icon(
                  Icons.palette_outlined, 
                  color: properties.color.length >= 6 
                    ? theme.onPrimary
                    : theme.onSecondary
                  )
              ),
            )
          ],
        ),
      ),

      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_size_subtitle,
        maxLength: 3,
        initialValue: properties.size.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.rounded_corner_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.size = (double.tryParse(value) ?? properties.size).clamp(0, 999);
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
