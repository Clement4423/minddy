import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/plugin_ui_component_icon_icons.dart';
import 'package:minddy/system/utils/create_unique_id.dart';


IconData getIconFromIconId(int iconId) {
  final defaultIcon = PluginUiComponentIconIcons.icons.first.icon;
  return PluginUiComponentIconIcons.getIcon(iconId)?.icon ?? defaultIcon;
}

class PluginUiComponentIcon implements IPluginUiComponent {

  PluginUiComponentIcon({required this.properties});

  @override
  int id = createUniqueId();

  @override
  String name = 'Icon'; // TODO : Traduire

  @override
  final PluginUiComponentIconProperties properties;

  @override
  PluginUiComponentType type = PluginUiComponentType.basicComponent;

  @override
  List<IPluginUiComponent> child = [];

  @override
  Widget preview(List<Widget> childsToShow) {
    return SizedBox(
      width: properties.width,
      height: properties.height,
      child: Icon(
        getIconFromIconId(properties.iconId),
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        size: properties.size
      )
    );
  }

  Widget _buildWidget() {
    return SizedBox(
      width: properties.width,
      height: properties.height,
      child: Icon(
        getIconFromIconId(properties.iconId),
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        size: properties.size
      )
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

  static PluginUiComponentIcon? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      PluginUiComponentIconProperties? properties = PluginUiComponentIconProperties.fromJson(map['properties']);

      if (properties != null) {
        return PluginUiComponentIcon(properties: properties)
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

class AxisAligment {
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  AxisAligment(this.mainAxisAlignment, this.crossAxisAlignment);
}

class PluginUiComponentIconProperties implements IPluginUiComponentProperties {
  double width;
  double height;
  double size;
  String color;
  int iconId;


  PluginUiComponentIconProperties({
    required this.width, 
    required this.height, 
    required this.size,
    required this.color,
    required this.iconId
  });

  @override
  String toJson() {
    return jsonEncode({
      'width': width,
      'height': height,
      'size': size,
      'color': color,
      'icon_id': iconId
    });
  }

  static PluginUiComponentIconProperties? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      return PluginUiComponentIconProperties(
        width: map['width'], 
        height: map['height'], 
        size: map['size'],
        color: map['color'],
        iconId: map['icon_id']
      ); 
    } catch (e) {
      return null;
    }
  }
}

