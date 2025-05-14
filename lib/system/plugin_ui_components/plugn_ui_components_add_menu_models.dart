import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/border_alignment.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_icon.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_padding.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_row.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_text.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_ui_editor_new_component_sub_menu.dart';

class PlugnUiComponentsAddMenuModels {

  static  List<PlugnUiComponentsAddMenuModel> asList = [
    container,
    column,
    row,
    text,
    padding,
    icon
  ];

  static PlugnUiComponentsAddMenuModel container = PlugnUiComponentsAddMenuModel(
    name: 'Container', 
    description: 'Contains other components', 
    canCreatePreview: true,
    previewWidth: 200,
    previewHeight: 100,
    canHaveChildren: true,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentContainer(
        properties: PluginUiComponentContainerProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          color: 'pr', 
          borderRadius: 10, 
          borderRadiusAlignment: BorderAlignment(sides: [1, 2, 3, 4]), 
          borderColor: 'onpr',
          borderThickness: 2, 
          borderAlignment: BorderAlignment(sides: [])
        )
      );
    }, 
  );

  static PlugnUiComponentsAddMenuModel column = PlugnUiComponentsAddMenuModel(
    name: 'Column', 
    description: 'Aligns other components vertically', 
    canCreatePreview: false,
    previewWidth: 200,
    previewHeight: 100,
    canHaveChildren: true,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentColumn(
        properties: PluginUiComponentColumnProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          borderRadius: 0, 
          spacing: 5,
          chilrenAligment: AxisAlignment(
            MainAxisAlignment.start, 
            CrossAxisAlignment.start
          )
        )
      );
    }, 
  );

  static PlugnUiComponentsAddMenuModel row = PlugnUiComponentsAddMenuModel(
    name: 'Row', 
    description: 'Aligns other components horizontally', 
    canCreatePreview: false,
    previewWidth: 200,
    previewHeight: 100,
    canHaveChildren: true,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentRow(
        properties: PluginUiComponentColumnProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          borderRadius: 0, 
          spacing: 5,
          chilrenAligment: AxisAlignment(
            MainAxisAlignment.start, 
            CrossAxisAlignment.start
          )
        )
      );
    }, 
  );

  static PlugnUiComponentsAddMenuModel text = PlugnUiComponentsAddMenuModel(
    name: 'Text', 
    description: 'Displays a given text', 
    canCreatePreview: true,
    previewWidth: 200,
    previewHeight: 100,
    canHaveChildren: false,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentText(
        properties: PluginUiComponentTextProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          text: 'Enter your text',
          fontWeight: TextFontWeight.medium,
          fontName: TextFontName.montserrat,
          fontSize: 15,
          maxLines: 10000,
          wordSpacing: 0,
          letterSpacing: 0,
          textAlignment: TextAlignment.start,
          color: 'onsu',
          underline: false
        )
      );
    }, 
  );

  static PlugnUiComponentsAddMenuModel padding = PlugnUiComponentsAddMenuModel(
    name: 'Padding', 
    description: 'Add space arround an element', 
    canCreatePreview: false,
    previewWidth: 200,
    previewHeight: 100,
    canHaveChildren: true,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentPadding(
        properties: PluginUiComponentPaddingProperties(
          padding: const EdgeInsets.all(0)
        )
      );
    }, 
  );

  static PlugnUiComponentsAddMenuModel icon = PlugnUiComponentsAddMenuModel(
    name: 'Icon', 
    description: 'Shows an icon', 
    canCreatePreview: true,
    previewWidth: 100,
    previewHeight: 100,
    canHaveChildren: false,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentIcon(
        properties: PluginUiComponentIconProperties(
          width: 30,
          height: 30,
          size: 18,
          color: 'onsu',
          iconId: 0 // TODO : Changer pour mettre une icone de base
        )
      );
    }, 
  );
}