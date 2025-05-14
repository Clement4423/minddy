import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/utils/create_unique_id.dart';


class PluginUiComponentPadding implements IPluginUiComponent {

  PluginUiComponentPadding({required this.properties});

  @override
  int id = createUniqueId();

  @override
  String name = 'Padding'; // Updated name

  @override
  final PluginUiComponentPaddingProperties properties; // Updated properties type

  @override
  PluginUiComponentType type = PluginUiComponentType.basicComponent;

  @override
  List<IPluginUiComponent> child = [];

  @override
  Widget preview(List<Widget> childsToShow) {
    return Padding(
      padding: properties.padding,
      child: childsToShow.firstOrNull
    );
  }

  Widget _buildWidget() {
    return Padding(
      padding: properties.padding,
      child: child.firstOrNull?.widget
    );
  }

  @override
  Widget get widget => _buildWidget();

  @override
  String toJson() {
    return jsonEncode({
      'type': runtimeType.toString(),
      'id': id,
      'name': name,
      'properties': properties.toJson(),
      'child': child.map((c) => c.toJson()).toList()
    });
  }

  static PluginUiComponentPadding? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      PluginUiComponentPaddingProperties? properties = PluginUiComponentPaddingProperties.fromJson(map['properties']);

      if (properties != null) {
        return PluginUiComponentPadding(properties: properties)
          ..id = map['id']
          ..name = map['name']
          ..child = (map['child'] as List).map((c) {
            return IPluginUiComponent.fromJson(c)!;
          }).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  
  @override
  set properties(IPluginUiComponentProperties newProperty) {}
  
  @override
  set widget(Widget newWidget) {}
}


class PluginUiComponentPaddingProperties implements IPluginUiComponentProperties {
  EdgeInsets padding;

  PluginUiComponentPaddingProperties({
    required this.padding
  });

  @override
  String toJson() {
    return jsonEncode({
      'padding': {
        'left': padding.left,
        'top': padding.top,
        'right': padding.right,
        'bottom': padding.bottom
      },
    });
  }

  static PluginUiComponentPaddingProperties? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      return PluginUiComponentPaddingProperties(
        padding: EdgeInsets.only(
          left: map['padding']['left'],
          top: map['padding']['top'],
          right: map['padding']['right'],
          bottom: map['padding']['bottom'],
        )
      ); 
    } catch (e) {
      return null;
    }
  }
}