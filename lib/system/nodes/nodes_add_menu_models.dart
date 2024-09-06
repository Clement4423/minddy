import 'package:flutter/material.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class NodesAddMenuModels {

  StylesGetters theme;
  Offset maxOffset;

  NodeWidgetFunctions functions;

  NodesAddMenuModels({required this.functions, required this.maxOffset, required this.theme});

  late List<NodeEditorNewNodeSubMenuNodeModel> asList = [
    mathNode
  ];

  late NodeEditorNewNodeSubMenuNodeModel mathNode = NodeEditorNewNodeSubMenuNodeModel(
    name: "Math", 
    description: "Performs mathematical operations on numbers", 
    inputsTypes: [NodeDataType.number, NodeDataType.number], 
    outputsTypes: [NodeDataType.number], 
    category: NodeCategory.math, 
    create: () {
      return MathNodeWidget(
        key: GlobalKey(),
        node: MathNode(), 
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );
}

