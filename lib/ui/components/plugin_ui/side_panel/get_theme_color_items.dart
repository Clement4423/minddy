import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

List<CustomSelectionMenuItem> getThemeColorItems(Function(String) changeColor, String color, StylesGetters theme, Function onPropertiesChanged) {
  return [
    CustomSelectionMenuItem(
      label: S.current.plugin_editor_ui_side_panel_properties_theme_colors_primary, 
      icon: null, 
      foregroundColor: color == 'pr' 
        ? theme.secondary
        : theme.onPrimary,
      iconReplacelemntWidth: 25,
      iconReplacement: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      onTap: () {
        changeColor('pr');
        onPropertiesChanged();
      }
    ),
    CustomSelectionMenuItem(
      label: S.current.plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent, 
      icon: null, 
      foregroundColor: color == 'prc' 
        ? theme.secondary
        : theme.onPrimary,
      iconReplacelemntWidth: 25,
      iconReplacement: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      onTap: () {
        changeColor('prc');
        onPropertiesChanged();
      }
    ),
    CustomSelectionMenuItem(
      label: S.current.plugin_editor_ui_side_panel_properties_theme_colors_accent, 
      icon: null, 
      foregroundColor: color == 'se' 
        ? theme.secondary
        : theme.onPrimary,
      iconReplacelemntWidth: 25,
      iconReplacement: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      onTap: () {
        changeColor('se');
        onPropertiesChanged();
      }
    ),
    CustomSelectionMenuItem(
      label: S.current.plugin_editor_ui_side_panel_properties_theme_colors_surface, 
      icon: null, 
      foregroundColor: color == 'su' 
        ? theme.secondary
        : theme.onPrimary,
      iconReplacelemntWidth: 25,
      iconReplacement: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      onTap: () {
        changeColor('su');
        onPropertiesChanged();
      }
    ),
  ];
}