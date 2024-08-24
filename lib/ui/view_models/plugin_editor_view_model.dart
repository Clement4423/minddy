import 'dart:convert';
import 'dart:io';

import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/cupertino.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/plugin_info.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class PluginEditorViewModel {

  PluginInfo pluginInfo;

  PluginEditorViewModel({required this.pluginInfo});

  late NodeEditorBottomSheetController bottomSheetController = NodeEditorBottomSheetController(nodeTrees: [], maxOffset: const Offset(0, 0), save: savePlugin);

  Future<void> initialize(Offset maxOffset, StylesGetters theme) async {
  Map<String, dynamic>? pluginData = await getPluginDataFromFiles();

  // If pluginData contains a JSON string, decode it to a map.
  if (pluginData != null && pluginData['nodes_controller'] is String) {
    pluginData['nodes_controller'] = jsonDecode(pluginData['nodes_controller']);
  }

  bottomSheetController = NodeEditorBottomSheetController.fromJson(pluginData?['nodes_controller']??{}, maxOffset, theme, savePlugin) ?? NodeEditorBottomSheetController(nodeTrees: [NodeWidgetTree(nodesWidgets: [MathNodeWidget(node: MathNode(), updateConnections: bottomSheetController.nodeConnectionUpdater.notify, theme: theme, setIsDragging: bottomSheetController.setIsDragging, getIsDragging: bottomSheetController.getIsDragging, getConnections: bottomSheetController.passNodesConnections, addConnection: bottomSheetController.addConnection, setSelectedPort: bottomSheetController.setSelectedPort, getSelectedPort: bottomSheetController.getSelectedPort, position: const Offset(900, 300), maxOffset: maxOffset)], id: 1)], maxOffset: maxOffset, save: savePlugin);

  return;
}

  Future<bool> savePlugin() async {
    try {
      await verifyDataFileExists();

      Map<String, dynamic> dataToSave = {
        'nodes_controller': bottomSheetController.toJson(),
        'version': pluginInfo.version,
        'name': pluginInfo.name,
        'creator': pluginInfo.creator
      };

      bool isSaved = await StaticVariables.fileSource.writeJsonFile(pluginInfo.relativePath, dataToSave, encrypt: false);

      return isSaved;
    } catch (e) {
      await AppLogs.writeError(e, 'plugin_editor_view_model.dart - savePlugin');
      return false;
    }
  }


  Future<Map<String, dynamic>?> getPluginDataFromFiles() async {
    await verifyDataFileExists();

    Map<String, dynamic>? data = await StaticVariables.fileSource.readJsonFile(pluginInfo.relativePath, decrypt: false);

    return data;
  }

  Future<void> verifyDataFileExists() async {
    File datafile = File("${StaticVariables.fileSource.documentDirectoryPath}/${pluginInfo.relativePath}");

    String path = p.normalize(datafile.path);

    if (await File(path).exists()) {
      return;
    } else {
      await StaticVariables.fileSource.createFile(pluginInfo.relativePath);
    }
  }
}