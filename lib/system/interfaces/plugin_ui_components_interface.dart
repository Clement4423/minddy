import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/model/border_alignment.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_row.dart';

// Process to create a new UiComponent:
// 1) Create a new class that extends IPluginUiComponent, using PluginUiComponentContainer as template
// 2) Create or reuse a IPluginUiComponentProperties class
// 3) If a new IPluginUiComponentProperties has been created, ensure that the properties are findable by the functions in 
//    the functions down this file. Make sure as well that those properties are also findable by the side panel functions in getComponentPropterties 
//    in the plugin_editor_ui_view_side_panel.dart file.
// 4) Add the new runtimetype to the _getUIComponentTypeConstructor function bellow.
// 5) Add the add menu model to the plugn_ui_components_add_menu_models.dart file list
// 6) Test it

enum PluginUiComponentType {
  basicComponent,
  button
}

abstract class IPluginUiComponent {
  late String name;
  late final int id;
  Widget preview(List<Widget> childToShow) {return const SizedBox.shrink();}
  late final Widget widget;
  late final PluginUiComponentType type;
  late List<IPluginUiComponent> child;

  late IPluginUiComponentProperties properties;

  String toJson() {
    throw UnimplementedError();
  }

  static IPluginUiComponent? fromJson(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      String type = map['type'];

      Function(String)? constructorFunction = _getUIComponentTypeConstructor(type);

      if (constructorFunction != null) {
        return constructorFunction(string);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static BorderAlignment getRadiusAlignment(IPluginUiComponent component) {
    BorderAlignment aligment = BorderAlignment.base();
    if (component.properties is PluginUiComponentContainerProperties) {
      aligment = (component.properties as PluginUiComponentContainerProperties).borderRadiusAlignment;
    }

    return aligment;
  }

  static double getRadius(IPluginUiComponent component) {
    double radius = 0;
    if (component.properties is PluginUiComponentContainerProperties) {
      radius = (component.properties as PluginUiComponentContainerProperties).borderRadius;
    } else if (component.properties is PluginUiComponentColumnProperties) {
      radius = (component.properties as PluginUiComponentColumnProperties).borderRadius;
    }

    return radius;
  }

  static Size getSize(IPluginUiComponent component) {
    double width = 0;
    double height = 0;
    switch (component.properties) {
      case PluginUiComponentContainerProperties():
        width = (component.properties as PluginUiComponentContainerProperties).width;
        height = (component.properties as PluginUiComponentContainerProperties).height;
      case PluginUiComponentColumnProperties():
        width = (component.properties as PluginUiComponentColumnProperties).width;
        height = (component.properties as PluginUiComponentColumnProperties).height;
    }

    return Size(width, height);
  }

  static void modifySize(Size newSize, IPluginUiComponent component) {
    if (component.properties is PluginUiComponentContainerProperties) {
      (component.properties as PluginUiComponentContainerProperties).width = newSize.width;
      (component.properties as PluginUiComponentContainerProperties).height = newSize.height;
    } else if (component.properties is PluginUiComponentColumnProperties) {
      (component.properties as PluginUiComponentColumnProperties).width = newSize.width;
      (component.properties as PluginUiComponentColumnProperties).height = newSize.height;
    }
  }

  static final List<Type> _componentsThatCanHaveMultipleChildren = [PluginUiComponentColumn];

  static bool canHaveMultipleChilren(IPluginUiComponent component) {
    return _componentsThatCanHaveMultipleChildren.contains(component.runtimeType);
  }
}

Function(String)? _getUIComponentTypeConstructor(String type) {

    Map<String, Function(String)> nodeTypesConstructors = {
      'PluginUiComponentContainer': (string) {return PluginUiComponentContainer.fromJson(string);},
      'PluginUiComponentColumn': (string) {return PluginUiComponentColumn.fromJson(string);},
      'PluginUiComponentRow': (string) {return PluginUiComponentRow.fromJson(string);},
    };

    return nodeTypesConstructors[type];
}