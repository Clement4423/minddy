import 'dart:async';
import 'dart:convert';

import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_side_panel_layer_element.dart';
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
  List<PluginEditorUiViewSidePanelLayerElementData> layersDataList = [];

  void initLayerDataList() {
    if (layersDataList.isEmpty) {
      for (IPluginUiComponent component in components) {
        applyToComponentAndChild(
          component, 
          (e) {
            layersDataList.add(
            PluginEditorUiViewSidePanelLayerElementData(
              showChild: false, 
              componentid: e.id
            )
          );
          }
        );
      }
    }
  }

  void applyToComponentAndChild(IPluginUiComponent component, Function(IPluginUiComponent) function) {

    function(component);

    if (component.child.isNotEmpty) {
      for (IPluginUiComponent child in component.child) {
        applyToComponentAndChild(child, function);
      }
    }
  }

  void applyToComponentAndParent(IPluginUiComponent component, Function(IPluginUiComponent) function) {

    function(component);

    IPluginUiComponent? parent = findParent(component.id);

    if (parent != null) {
      applyToComponentAndParent(parent, function);
    }
  }

  void addComponent(IPluginUiComponent component) {
    if (components.isEmpty) {
      components.add(component);
      setSelectedComponent(component.id);
      componentViewUpdater.update();
      layersDataList.add(
        PluginEditorUiViewSidePanelLayerElementData(
          showChild: true, 
          componentid: component.id
        )
      );
    }
  }

  void addChild(IPluginUiComponent child, int parentId, [bool? update]) {
    IPluginUiComponent? parent = getSelectedComponent(null, parentId);
    if (parent != null) {
      parent.child.add(child);
      setSelectedComponent(child.id);
    }
    layersDataList.add(
      PluginEditorUiViewSidePanelLayerElementData(
        showChild: true, 
        componentid: child.id
      )
    );
  }

  void deleteComponent(IPluginUiComponent componentToRemove, [bool? update]) {
    IPluginUiComponent? parent = findParent(componentToRemove.id);
    if (parent == null) {
      components.removeWhere((component) => component.id == componentToRemove.id);
    } else {
      parent.child.removeWhere((component) => component.id == componentToRemove.id);
    }
    layersDataList.removeWhere((e) => e.componentid == componentToRemove.id);
    if (update == null || update) {
      componentViewUpdater.update();
    } 
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

  void setSelectedComponent(int? id, [bool update = true]) {
    selectedComponentId = id;

    IPluginUiComponent? selected = getSelectedComponent();
    if (selected != null) {
      _updateParentLayerData(selected);
    }

    selectedIdStream.add('event');
    if (update) {
      componentViewUpdater.update();
    }
  }

  void _updateParentLayerData(IPluginUiComponent selected) {
    IPluginUiComponent? parent = findParent(selected.id);
    if (parent != null) {
      applyToComponentAndParent(parent, (component) {
        PluginEditorUiViewSidePanelLayerElementData? data = layersDataList.where((a) => a.componentid == component.id).firstOrNull;
        if (data != null) {
          layersDataList
            ..remove(data)
            ..add(PluginEditorUiViewSidePanelLayerElementData(
              showChild: true,
              componentid: data.componentid,
            ));
        }
      });
    }
  }


  String toJson() {
    return jsonEncode({
      'is_side_panel_closed': isSidePanelClosed,
      'components': components.map((e) => e.toJson()).toList(),
      'layers_data_list': layersDataList.map((e) => e.toJson()).toList()
    });
  }

  static PluginEditorUiViewController? fromJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      
      return PluginEditorUiViewController()
        ..isSidePanelClosed = map['is_side_panel_closed']
        ..components = (map['components'] as List).map((c) => IPluginUiComponent.fromJson(c)!).toList()
        ..layersDataList = (map['layers_data_list'] as List).map((string) => PluginEditorUiViewSidePanelLayerElementData.fromJson(string)).toList();
    } catch (e) {
      return null;
    }
  }
}