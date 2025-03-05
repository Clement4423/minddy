import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/border_alignment.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_row.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_ui_editor_new_component_sub_menu.dart';

class PlugnUiComponentsAddMenuModels {

  static  List<PlugnUiComponentsAddMenuModel> asList = [
    container,
    column,
    row
  ];

  static PlugnUiComponentsAddMenuModel container = PlugnUiComponentsAddMenuModel(
    name: 'Container', 
    description: 'Contains other components', 
    canCreatePreview: true,
    previewWidth: 200,
    previewHeight: 100,
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentContainer(
        properties: PluginUiComponentContainerProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          color: 'prc', 
          borderRadius: 10, 
          borderRadiusAlignment: BorderAlignment(sides: [1, 2, 3, 4]), 
          borderColor: '000000', 
          borderThickness: 2, 
          borderAlignment: BorderAlignment(sides: [1, 2, 3, 4])
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
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentColumn(
        properties: PluginUiComponentColumnProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          borderRadius: 0, 
          spacing: 5,
          chilrenAligment: AxisAligment(
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
    category: PluginUiComponentType.basicComponent,
    create: (maxWidth, maxHeight) {
      return PluginUiComponentRow(
        properties: PluginUiComponentColumnProperties(
          width: 700.clamp(0, maxWidth).toDouble(), 
          height: 420.clamp(0, maxHeight).toDouble(), 
          borderRadius: 0, 
          spacing: 5,
          chilrenAligment: AxisAligment(
            MainAxisAlignment.start, 
            CrossAxisAlignment.start
          )
        )
      );
    }, 
  );
}