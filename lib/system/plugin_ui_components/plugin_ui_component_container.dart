import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/border_alignment.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

BorderRadius getBorderRadiusFromProperties(double borderRadius, BorderAlignment aligmnent) {
  if (aligmnent.sides.isEmpty) {
    return BorderRadius.zero;
  }

  if (aligmnent.sides.length == 4) {
    return BorderRadius.circular(borderRadius);
  }

  return BorderRadius.only(
    topLeft: aligmnent.sides.contains(1) 
      ? Radius.circular(borderRadius)
      : Radius.zero,
    topRight: aligmnent.sides.contains(2) 
      ? Radius.circular(borderRadius)
      : Radius.zero,
    bottomRight: aligmnent.sides.contains(3) 
      ? Radius.circular(borderRadius)
      : Radius.zero,
    bottomLeft: aligmnent.sides.contains(4) 
      ? Radius.circular(borderRadius)
      : Radius.zero
  );
}

Border? getBorderFromProperties(double thickness, Color color, BorderAlignment aligmnent) {
  if (aligmnent.sides.isEmpty) {
    return null;
  }

  if (aligmnent.sides.length == 4) {
    return Border.all(width: thickness, color: color);
  }

  return Border(
    top: aligmnent.sides.contains(1) 
      ? BorderSide(color: color, width: thickness)
      : BorderSide.none,
    right: aligmnent.sides.contains(2) 
      ? BorderSide(color: color, width: thickness)
      : BorderSide.none,
    bottom: aligmnent.sides.contains(3) 
      ? BorderSide(color: color, width: thickness)
      : BorderSide.none,
    left: aligmnent.sides.contains(4) 
      ? BorderSide(color: color, width: thickness)
      : BorderSide.none,
  );
}


class PluginUiComponentContainer implements IPluginUiComponent {

  PluginUiComponentContainer({required this.properties});

  @override
  int id = createUniqueId();

  @override
  String name = 'Container'; // TODO : Traduire

  @override
  final PluginUiComponentContainerProperties properties;

  @override
  PluginUiComponentType type = PluginUiComponentType.basicComponent;

  @override
  List<IPluginUiComponent> child = [];

  @override
  Widget preview(List<Widget> childsToShow) {
    return Container(
      key: UniqueKey(),
      width: properties.width,
      height: properties.height,
      decoration: BoxDecoration(
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        borderRadius: getBorderRadiusFromProperties(properties.borderRadius, properties.borderRadiusAlignment),
        border: getBorderFromProperties(properties.borderThickness, IPluginUiComponentProperties.colorFromText(properties.borderColor), properties.borderAlignment)
      ),
      child: childsToShow.firstOrNull
    );
  }

  Widget _buildWidget() {
    return Container(
      width: properties.width,
      height: properties.height,
      decoration: BoxDecoration(
        color: IPluginUiComponentProperties.colorFromText(properties.color),
        borderRadius: getBorderRadiusFromProperties(properties.borderRadius, properties.borderRadiusAlignment),
        border: getBorderFromProperties(properties.borderThickness, IPluginUiComponentProperties.colorFromText(properties.borderColor), properties.borderAlignment)
      ),
      child: child.firstOrNull?.widget,
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

  static PluginUiComponentContainer? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      PluginUiComponentContainerProperties? properties = PluginUiComponentContainerProperties.fromJson(map['properties']);

      if (properties != null) {
        return PluginUiComponentContainer(properties: properties)
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

class PluginUiComponentContainerProperties implements IPluginUiComponentProperties {
  double width;
  double height;
  String color;
  double borderRadius;
  BorderAlignment borderRadiusAlignment;
  String borderColor;
  double borderThickness;
  BorderAlignment borderAlignment;


  PluginUiComponentContainerProperties({
    required this.width, 
    required this.height, 
    required this.color, 
    required this.borderRadius, 
    required this.borderRadiusAlignment,
    required this.borderColor,
    required this.borderThickness,
    required this.borderAlignment
  });

  @override
  String toJson() {
    return jsonEncode({
      'width': width,
      'height': height,
      'color': color,
      'border_radius': borderRadius,
      'border_radius_alignment': borderRadiusAlignment.toJson(),
      'border_color': borderColor,
      'border_thickness': borderThickness,
      'border_alignment': borderAlignment.toJson()
    });
  }

  static PluginUiComponentContainerProperties? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      return PluginUiComponentContainerProperties(
        width: map['width'], 
        height: map['height'], 
        color: map['color'], 
        borderRadius: map['border_radius'], 
        borderRadiusAlignment: BorderAlignment.fromJson(map['border_radius_alignment']) ?? BorderAlignment.base(), 
        borderColor: map['border_color'], 
        borderThickness: map['border_thickness'], 
        borderAlignment: BorderAlignment.fromJson(map['border_alignment']) ?? BorderAlignment.base(), 
      ); 
    } catch (e) {
      return null;
    }
  }
}

