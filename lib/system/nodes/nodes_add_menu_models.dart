import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/nodes/all_nodes/boolean_node.dart';
import 'package:minddy/system/nodes/all_nodes/comparison_node.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/all_nodes/random_number_node.dart';
import 'package:minddy/system/nodes/all_nodes/variables_nodes/get_variable_node.dart';
import 'package:minddy/system/nodes/all_nodes/variables_nodes/set_variable_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/boolean_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/comparison_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/get_variable_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/math_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/random_number_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/set_variable_node_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodesAddMenuModels {
  StylesGetters theme;
  Offset maxOffset;

  NodeWidgetFunctions functions;

  NodesAddMenuModels({required this.functions, required this.maxOffset, required this.theme});

  List<NodeEditorNewNodeSubMenuNodeModel> filterList(List<NodeEditorNewNodeSubMenuNodeModel> list, NodePortType portType, NodeDataType type) {
    switch (portType) {
      case NodePortType.input:
        return list.where((e) => e.outputsTypes.contains(type)).toList();
      case NodePortType.output:
        return list.where((e) => e.inputsTypes.contains(type)).toList();
    }
  }

  late List<NodeEditorNewNodeSubMenuNodeModel> asList = [
    mathNode,
    comparisonNode,
    booleanNode,
    setVariableNode,
    getVariableNode,
    randomNumberNode
  ];

  late NodeEditorNewNodeSubMenuNodeModel mathNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_math_node_title, 
    description: S.current.node_widgets_math_node_description, 
    inputsTypes: [NodeDataType.number, NodeDataType.number], 
    outputsTypes: [NodeDataType.number], 
    category: NodeCategory.math, 
    typesCanChange: true,
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

  late NodeEditorNewNodeSubMenuNodeModel comparisonNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_comparison_node_title, 
    description: S.current.node_widgets_comparison_node_description, 
    inputsTypes: [NodeDataType.number, NodeDataType.number], 
    outputsTypes: [NodeDataType.boolean], 
    category: NodeCategory.logic, 
    typesCanChange: false,
    create: () {
      return ComparisonNodeWidget(
        key: GlobalKey(),
        node: ComparisonNode(), 
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );
  
  late NodeEditorNewNodeSubMenuNodeModel booleanNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_boolean_node_title, 
    description: S.current.node_widgets_boolean_node_description, 
    inputsTypes: [NodeDataType.boolean, NodeDataType.boolean], 
    outputsTypes: [NodeDataType.boolean], 
    category: NodeCategory.logic, 
    typesCanChange: false,
    create: () {
      return BooleanNodeWidget(
        key: GlobalKey(),
        node: BooleanNode(), 
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );

  late NodeEditorNewNodeSubMenuNodeModel setVariableNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_set_variable_node_title, 
    description: S.current.node_widgets_set_variable_node_description,
    inputsTypes: [NodeDataType.any], 
    outputsTypes: [], 
    category: NodeCategory.variable, 
    typesCanChange: true,
    create: () {
      return SetVariableNodeWidget(
        key: GlobalKey(),
        node: SetVariableNode(variablesManager: functions.variablesManager), 
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );

  late NodeEditorNewNodeSubMenuNodeModel getVariableNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_get_variable_node_title, 
    description: S.current.node_widgets_get_variable_node_description, 
    inputsTypes: [], 
    outputsTypes: [NodeDataType.any], 
    category: NodeCategory.variable, 
    typesCanChange: true,
    create: () {
      return GetVariableNodeWidget(
        key: GlobalKey(),
        node: GetVariableNode(variablesManager: functions.variablesManager), 
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );

  late NodeEditorNewNodeSubMenuNodeModel randomNumberNode = NodeEditorNewNodeSubMenuNodeModel(
    name: S.current.node_widgets_random_number_node_title, 
    description: S.current.node_widgets_random_number_node_description, 
    inputsTypes: [NodeDataType.number, NodeDataType.number], 
    outputsTypes: [NodeDataType.number], 
    category: NodeCategory.math, 
    typesCanChange: false,
    create: () {
      return RandomNumberNodeWidget(
        key: GlobalKey(),
        node: RandomNumberNode(),
        position: const Offset(100, 100), 
        maxOffset: maxOffset, 
        theme: theme, 
        functions: functions,
      );
    }
  );
}