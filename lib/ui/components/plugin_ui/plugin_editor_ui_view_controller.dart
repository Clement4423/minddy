import 'dart:async';
import 'dart:convert';

import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/ui/utils/ui_updater.dart';

class PluginEditorUiViewController {

  final StreamController<String> selectedIdStream = StreamController<String>();

  UiUpdater componentViewUpdater = UiUpdater();
  
  int? selectedComponentId;

  bool isSidePanelClosed = false;

  void setIsSidePanelClosed(bool value) {
    isSidePanelClosed = value;
  }

  List<IPluginUiComponent> components = [];

  void addComponent(IPluginUiComponent component) {
    if (components.isEmpty) {
      components.add(component);
      setSelectedComponent(component.id);
      componentViewUpdater.update();
    }
  }

  void addChild(IPluginUiComponent child, int parentId) {
    IPluginUiComponent? parent = getSelectedComponent(null, parentId);
    if (parent != null) {
      parent.child.add(child);
      componentViewUpdater.update();
      setSelectedComponent(child.id);
    }
  }

  void deleteComponent(IPluginUiComponent componentToRemove) {
    IPluginUiComponent? parent = findParent(componentToRemove.id);
    if (parent == null) {
      components.removeWhere((component) => component.id == componentToRemove.id);
    } else {
      parent.child.removeWhere((component) => component.id == componentToRemove.id);
    }
    setSelectedComponent(null);
    componentViewUpdater.update();
  }

  IPluginUiComponent? findParent(int childId, [IPluginUiComponent? parent]) {
    if (components.isEmpty) {
      return null;
    }

    try {
      if (parent == null) {
        return findParent(childId, components.firstOrNull);
      }
    
      for (var child in parent.child) {
        if (child.id == childId) {
          return parent;
        }
        var found = findParent(childId, child);
        if (found != null) return found;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  IPluginUiComponent? getSelectedComponent([IPluginUiComponent? component, int? id]) {
    int? idToGet = id ?? selectedComponentId;

    if (idToGet == null || components.isEmpty) {
      return null;
    }

    try {
      if (component == null) {
        return getSelectedComponent(components.firstOrNull, idToGet);
      }


      if (component.id == idToGet) {
        return component;
      }
      
      for (IPluginUiComponent child in component.child) {
        IPluginUiComponent? found = getSelectedComponent(child, idToGet);
        if (found != null) return found;
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  void setSelectedComponent(int? id) {
    selectedComponentId = id;
    selectedIdStream.add('event');
    componentViewUpdater.update();
  }

  String toJson() {
    return jsonEncode({
      'is_side_panel_closed': isSidePanelClosed,
      'components': components.map((e) => e.toJson()).toList()
    });
  }

  static PluginEditorUiViewController? fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      
      return PluginEditorUiViewController()
        ..isSidePanelClosed = map['is_side_panel_closed']
        ..components = (map['components'] as List).map((c) => IPluginUiComponent.fromJson(c)!).toList();
    } catch (e) {
      return null;
    }
  }
}