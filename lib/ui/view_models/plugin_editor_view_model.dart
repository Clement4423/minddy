/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'dart:io';

import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/math_node_widget.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_state.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/cupertino.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/plugin_info.dart';

class PluginEditorViewModel {

  PluginInfo pluginInfo;

  PluginEditorViewModel({required this.pluginInfo});

  late NodeEditorBottomSheetController bottomSheetController = NodeEditorBottomSheetController(views: [], maxOffset: const Offset(0, 0), save: savePlugin);
  late PluginEditorUiViewController pluginEditorUiViewController = PluginEditorUiViewController();

  Future<void> initialize(Offset maxOffset, StylesGetters theme) async {
    Map<String, dynamic>? pluginData = await getPluginDataFromFiles();

    // If pluginData contains a JSON string, decode it to a map.
    if (pluginData != null && pluginData['nodes_controller'] is String) {
      pluginData['nodes_controller'] = jsonDecode(pluginData['nodes_controller']);
    }

    bottomSheetController = NodeEditorBottomSheetController.fromJson(pluginData?['nodes_controller']??{}, maxOffset, theme, savePlugin) ?? NodeEditorBottomSheetController(views: [NodeEditorBottomSheetView(state: NodeEditorState(), tree: NodeWidgetTree(nodesWidgets: [MathNodeWidget(key: GlobalKey(), theme: theme, node: MathNode(), functions: bottomSheetController.widgetFunctions, position: const Offset(900, 300), maxOffset: maxOffset)], id: 1), viewPositionController: TransformationController())], maxOffset: maxOffset, save: savePlugin);

    String uiControllerJsonString = '';

    if (pluginData != null && pluginData['ui_controller'] is String) {
      uiControllerJsonString = pluginData['ui_controller'];
    }
  
    pluginEditorUiViewController = PluginEditorUiViewController.fromJson(uiControllerJsonString) ?? PluginEditorUiViewController();

    return;
  }

  Future<bool> savePlugin() async {
    try {
      await verifyDataFileExists();

      Map<String, dynamic> dataToSave = {
        'nodes_controller': bottomSheetController.toJson(),
        'ui_controller': pluginEditorUiViewController.toJson(),
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