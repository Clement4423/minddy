import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class PluginUiComponentColumn implements IPluginUiComponent {

  PluginUiComponentColumn({required this.properties});

  @override
  int id = createUniqueId();

  @override
  String name = 'Column'; // TODO : Traduire

  @override
  final PluginUiComponentColumnProperties properties;

  @override
  PluginUiComponentType type = PluginUiComponentType.basicComponent;

  @override
  List<IPluginUiComponent> child = [];

  @override
  Widget preview(List<Widget> childsToShow) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(properties.borderRadius),
      child: SizedBox(
        width: properties.width,
        height: properties.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: properties.chilrenAligment.mainAxisAlignment,
            crossAxisAlignment: properties.chilrenAligment.crossAxisAlignment,
            spacing: properties.spacing,
            children: childsToShow,
          ),
        ),
      ),
    );
  }

  Widget _buildWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(properties.borderRadius),
      child: SizedBox(
        width: properties.width,
        height: properties.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: properties.chilrenAligment.mainAxisAlignment,
            crossAxisAlignment: properties.chilrenAligment.crossAxisAlignment,
            spacing: properties.spacing,
            children: child.map((c) => c.widget).toList(),
          ),
        ),
      ),
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

  static PluginUiComponentColumn? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      PluginUiComponentColumnProperties? properties = PluginUiComponentColumnProperties.fromJson(map['properties']);

      if (properties != null) {
        return PluginUiComponentColumn(properties: properties)
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

class AxisAlignment {
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  AxisAlignment(this.mainAxisAlignment, this.crossAxisAlignment);
}

class PluginUiComponentColumnProperties implements IPluginUiComponentProperties {
  double width;
  double height;
  double borderRadius;
  double spacing;
  AxisAlignment chilrenAligment;


  PluginUiComponentColumnProperties({
    required this.width, 
    required this.height, 
    required this.spacing,
    required this.borderRadius, 
    required this.chilrenAligment
  });

  @override
  String toJson() {
    return jsonEncode({
      'width': width,
      'height': height,
      'spacing': spacing,
      'border_radius': borderRadius,
      'chilren_aligment': {
        'main_axis': chilrenAligment.mainAxisAlignment.index,
        'cross_axis': chilrenAligment.crossAxisAlignment.index
      }
    });
  }

  static PluginUiComponentColumnProperties? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      return PluginUiComponentColumnProperties(
        width: map['width'], 
        height: map['height'], 
        spacing: map['spacing'],
        borderRadius: map['border_radius'], 
        chilrenAligment: AxisAlignment(
          MainAxisAlignment.values[map['chilren_aligment']['main_axis']], 
          CrossAxisAlignment.values[map['chilren_aligment']['cross_axis']]
        )
      ); 
    } catch (e) {
      return null;
    }
  }
}

