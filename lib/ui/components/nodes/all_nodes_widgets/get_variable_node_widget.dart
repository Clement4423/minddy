import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/model/node_tree_variable.dart';
import 'package:minddy/system/nodes/all_nodes/variables_nodes/get_variable_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class GetVariableNodeWidget extends StatefulWidget implements INodeWidget {
  GetVariableNodeWidget({
    super.key,
    required this.node,
    required this.position,
    required this.maxOffset,
    required this.theme,
    required this.functions
  });

  @override
  Offset position;

  @override
  final GetVariableNode node;

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  GetVariableNodeWidget copy(GlobalKey newKey) {
    return GetVariableNodeWidget(
      key: newKey,
      node: node.copy(), 
      position: Offset(position.dx, position.dy), 
      maxOffset: maxOffset, 
      theme: theme, 
      functions: functions
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      'node': node.toJson(),
      'widget_type': runtimeType.toString(),
      'positionX': position.dx,
      'positionY': position.dy
    });
  }

  // Static method to deserialize from JSON
  static GetVariableNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return GetVariableNodeWidget(
      key: key,
      theme: theme,
      node: GetVariableNode(variablesManager: functions.variablesManager).fromJson(data['node']) as GetVariableNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 68;
  
  @override
  final double width = 100; // Do not modify the width.
  
  @override
  set maxOffset(Offset newMaxOffset) {}
  
  @override
  set node(INode newNode) {}
    
  @override
  set height(double newHeight) {}
  
  @override
  set width(double newWidth) {}
  
  @override
  set theme(StylesGetters newTheme) {}

  @override
  State<GetVariableNodeWidget> createState() => _GetVariableNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _GetVariableNodeWidgetState extends State<GetVariableNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  NodeDataType lastSelectedVariableType = NodeDataType.any;

  bool variableChanged = false;

  bool _getVariableChanged() {
    if (variableChanged) {
      variableChanged = false;
      return true;
    } else {
      return false;
    }
  }

  void destroyInvalidConnections(NodeDataType? newType) {
    List<NodeTarget> targetsToRemove = [];
    for (NodeTarget target in widget.node.targets) {
      if (newType == null || INode.evaluateData(NodeData(type: newType, value: getDefaultNodeDataTypeValue(newType)), target.node.inputsTypes[target.inputIndex]) == null) {
        targetsToRemove.add(target);
      }
    }

    widget.node.targets.removeWhere((t) => targetsToRemove.contains(t));

    widget.functions.updateConnections();
  }

  void selectedVariableNoLongerExist() {
    widget.node.selectedVariableId = null;
    clearOutputs();
    destroyInvalidConnections(null);
    variableChanged = true;
    setState(() {});
  }

  List<NodeTreeVariable> _getVariables() {
    return widget.functions.variablesManager.variables;
  }

  NodeTreeVariable? _getSelectedVariable() {
    if (widget.node.selectedVariableId == null) {
      return null;
    } else {
      NodeTreeVariable? selectedVariable = widget.functions.variablesManager.getVariable(widget.node.selectedVariableId!);

      if (selectedVariable != null) {
        if (lastSelectedVariableType != selectedVariable.type) {
          lastSelectedVariableType = selectedVariable.type;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            main(selectedVariable);
          });
        }
        return selectedVariable;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          selectedVariableNoLongerExist();
        });
        return null;
      }
    }
  }

  void clearOutputs() {
    widget.node.outputsTypes.clear();
    widget.node.targets.clear();
  }

  // The main action of the widget.
  // Only if nescessary -> if you have a dropdown selector, can be used to change the inputs.
  void main(NodeTreeVariable selectedVariable) {
    widget.node.selectedVariableId = selectedVariable.id;
    widget.node.outputsTypes = [selectedVariable.type];
    destroyInvalidConnections(selectedVariable.type);
    variableChanged = true;
    widget.functions.saveState();
    setState(() {});
  }

  @override
  void initState() {
    if (widget.node.selectedVariableId == null) {
      clearOutputs();
    }
    widgetInformations = NodeWidgetInformations(
      widget: widget, 
      setState: setState, 
      inputsOffsetsMaxLength: widget.node.inputsTypes.length, 
      outputOffsetsMaxLength: widget.node.outputsTypes.length
    );
    widget.functions.verifyPosition(widget);
    widget.functions.verifyInputs(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset draggingStartPortOffset = widgetInformations.draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    List<NodeTreeVariable> variables = _getVariables();
    return NodeWidgetBody(
      nodeTitle: S.of(context).node_widgets_get_variable_node_title,
      nodeDescription: S.of(context).node_widgets_get_variable_node_description,
      theme: widget.theme, 
      nodeWidget: widget, 
      nodeColor: DefaultAppColors.yellow.color,
      needToBeSmaller: widget.node.outputsTypes.isEmpty || widget.node.outputsTypes.first == NodeDataType.any,
      inputsThatAreNoLongerNeeded: const [0], 
      isDraggingStartPortFromAnotherPort: widgetInformations.isDraggingStartPortFromAnotherPort, 
      draggingStartPortOffset: draggingStartPortOffset, 
      currentCursorOffset: widgetInformations.currentCursorOffset,
      inputPortInfo: widgetInformations.inputPortInfo, 
      children: [
        if (widget.node.selectedVariableId != null && widget.node.outputsTypes.isNotEmpty)
          // Output
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: NodeWidgetOutput(
              key: _getVariableChanged() 
                ? UniqueKey() 
                : null,
              portInfo: NodePortInfo(
                node: widget, 
                type: NodePortType.output, 
                portIndex: 0
              ), 
              label: S.of(context).node_widgets_value_text,
              setCursorPosition: widgetInformations.setCursorOffset,
              theme: widget.theme, 
              setDragStartingPort: widgetInformations.setStartDraggingPoint,
              getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
              setOffset: widgetInformations.setNodePortOffset, 
              functions: widget.functions
            )
          ),
        // Variable selector
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: NodeWidgetDropdown(
            key: UniqueKey(),
            value: _getSelectedVariable() ?? NodeTreeVariable(name: S.of(context).node_widgets_select_variable_node_text, type: NodeDataType.any, id: 0),
            items: variables,
            onChanged: (selectedVariable) {
              main(selectedVariable!);
            },
            width: widget.width,
            height: widget.height,
            theme: widget.theme,
            itemToString: (nodeTreeVariable) {
              return nodeTreeVariable.name;
            },
          ),
        ),
      ]
    );
  }
}