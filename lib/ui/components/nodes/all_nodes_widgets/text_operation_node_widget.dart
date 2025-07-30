import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/text_operation_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class TextOperationNodeWidget extends StatefulWidget implements INodeWidget {
  TextOperationNodeWidget({
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
  final TextOperationNode node;

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  TextOperationNodeWidget copy(GlobalKey newKey) {
    return TextOperationNodeWidget(
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
  static TextOperationNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return TextOperationNodeWidget(
      key: key,
      theme: theme,
      node: TextOperationNode().fromJson(data['node']) as TextOperationNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 125;
  
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
  State<TextOperationNodeWidget> createState() => _TextOperationNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _TextOperationNodeWidgetState extends State<TextOperationNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  bool typeChanged = false;

  bool _getTypeChanged() {
    if (typeChanged) {
      typeChanged = false;
      return true;
    } else {
      return false;
    }
  }

  void destroyInvalidConnections() {
    List<NodeConnection> connections = widget.functions.getConnections();

    for (NodeConnection connection in connections) {
      if (connection.endNode == widget) {
        try {
          connection.startNode.node.targets.removeWhere((target) => target.node.id == widget.node.id && (target.inputIndex + 1 > widget.node.inputsTypes.length || connection.startNode.node.outputsTypes[connection.startOutputIndex] != widget.node.inputsTypes[target.inputIndex]));  
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
        
      }
    }

    widget.functions.updateConnections();
  }

  void destroyInvalidOutputs() {
    List<NodeTarget> targetsToRemove = [];
    NodeDataType newType = widget.node.outputsTypes.first;
    for (NodeTarget target in widget.node.targets) {
      if (INode.evaluateData(NodeData(type: newType, value: getDefaultNodeDataTypeValue(newType)), target.node.inputsTypes[target.inputIndex]) == null) {
        targetsToRemove.add(target);
      }
    }

    widget.node.targets.removeWhere((t) => targetsToRemove.contains(t));
  }

  void _setNodeInputs(TextOperationType type) {
    switch (type) {
      case TextOperationType.join:
        widget.node.inputsTypes = [NodeDataType.string, NodeDataType.string];
        break;
      case TextOperationType.cut:
        widget.node.inputsTypes = [NodeDataType.string, NodeDataType.number, NodeDataType.number];
        break;
      case TextOperationType.trim:
        widget.node.inputsTypes = [NodeDataType.string];
        break;
      case TextOperationType.trimLeft:
        widget.node.inputsTypes = [NodeDataType.string];
      case TextOperationType.trimRight:
        widget.node.inputsTypes = [NodeDataType.string];
      case TextOperationType.padLeft:
        widget.node.inputsTypes = [NodeDataType.string, NodeDataType.string, NodeDataType.number];
        break;
      case TextOperationType.padRight:
        widget.node.inputsTypes = [NodeDataType.string, NodeDataType.string, NodeDataType.number];
        break;
      case TextOperationType.contains:
        widget.node.inputsTypes = [NodeDataType.string, NodeDataType.string];
        break;
    }
  }

  void _setNodeOutputs(TextOperationType type) {
    switch (type) {
      case TextOperationType.contains:
        widget.node.outputsTypes = [NodeDataType.boolean];
        break;
      default:
        widget.node.outputsTypes = [NodeDataType.string];
        break;
    }
  }

  String _getInputLabel(int index) {
      switch (widget.node.textOperationType) {
        case TextOperationType.join:
          if (index == 1) {
            return S.of(context).node_widgets_text_text;
          }
        case TextOperationType.cut:
          if (index == 1) {
            return S.of(context).node_widgets_start_text;
          } else if (index == 2) {
            return S.of(context).node_widgets_end_text;
          }
        case TextOperationType.trim:
          break;
        case TextOperationType.trimLeft:
          break;
        case TextOperationType.trimRight:
          break;
        case TextOperationType.padLeft:
          if (index == 1) {
            return S.of(context).node_widgets_text_text;
          } else if (index == 2) {
            return S.of(context).node_widgets_length_text;
          }
        case TextOperationType.padRight:
          if (index == 1) {
            return S.of(context).node_widgets_text_text;
          } else if (index == 2) {
            return S.of(context).node_widgets_length_text;
          }
        case TextOperationType.contains:
          if (index == 1) {
            return S.of(context).node_widgets_text_text;
          }
        default:
          return '';
    }

    return '';
  }

  void _setWidgetNeededInputs() {
    widgetInformations.inputsThatAreNoLongerNeeded = List.generate(3 - widget.node.inputsTypes.length, (index) => index + 1);
    widgetInformations.needToBeSmaller = widget.node.inputsTypes.length != 3;
  }

  void main(TextOperationType type) {
    TextOperationType originalType = widget.node.textOperationType!;
    widget.node.textOperationType = type;
    _setNodeInputs(type);
    _setNodeOutputs(type);
    _setWidgetNeededInputs();
    if (originalType == TextOperationType.contains && type != TextOperationType.contains || originalType != TextOperationType.contains && type == TextOperationType.contains) {
      destroyInvalidOutputs();
    }
    if (originalType != type) {
      typeChanged = true;
    }
    destroyInvalidConnections();
    widget.functions.verifyInputs(widget);
    widget.functions.saveState();
    setState(() {});
  }

  @override
  void initState() {
    _setNodeInputs(widget.node.textOperationType!);
    _setNodeOutputs(widget.node.textOperationType!);
    widgetInformations = NodeWidgetInformations(
      widget: widget, 
      setState: setState, 
      inputsOffsetsMaxLength: widget.node.inputsTypes.length, 
      outputOffsetsMaxLength: widget.node.outputsTypes.length
    );
    _setWidgetNeededInputs();
    widget.functions.verifyPosition(widget);
    widget.functions.verifyInputs(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset draggingStartPortOffset = widgetInformations.draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    return NodeWidgetBody(
      key: _getTypeChanged() 
        ? UniqueKey()
        : null,
      nodeTitle: S.of(context).node_widgets_text_operation_node_title, 
      nodeDescription: S.of(context).node_widgets_text_operation_node_decsription,
      theme: widget.theme, 
      nodeWidget: widget, 
      nodeColor: DefaultAppColors.lavender.color,
      needToBeSmaller: widgetInformations.needToBeSmaller, 
      inputsThatAreNoLongerNeeded: widgetInformations.inputsThatAreNoLongerNeeded, 
      isDraggingStartPortFromAnotherPort: widgetInformations.isDraggingStartPortFromAnotherPort, 
      draggingStartPortOffset: draggingStartPortOffset, 
      currentCursorOffset: widgetInformations.currentCursorOffset,
      inputPortInfo: widgetInformations.inputPortInfo, 
      children: [
        // Output.s
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetOutput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.output, 
              portIndex: 0
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            label: S.of(context).node_widgets_result_text, 
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset,
            setOffset: widgetInformations.setNodePortOffset,
            functions: widget.functions
          )
        ),
        // Options selector
        NodeWidgetDropdown(
          value: widget.node.textOperationType,
          items: TextOperationType.values,
          onChanged: (type) {
            if (type != null) {
              main(type);
            }
          },
          width: widget.width,
          height: widget.height,
          theme: widget.theme,
          itemToString: (type) {
            return _getTextOperationTypeTranslation(type!);
          },
        ),
        // Input.s
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetInput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.input, 
              portIndex: 0
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(0, NodePortType.input, widget),
            connectedLabel: S.of(context).node_widgets_text_text, 
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        ),
        if (widget.node.inputsTypes.length > 1)
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetInput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.input, 
              portIndex: 1
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(1, NodePortType.input, widget), 
            connectedLabel: _getInputLabel(1), 
            setDragStartingPort: widgetInformations.setStartDraggingPoint, 
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        ),
        if (widget.node.inputsTypes.length > 2)
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetInput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.input, 
              portIndex: 2
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(2, NodePortType.input, widget), 
            connectedLabel: _getInputLabel(2),
            setDragStartingPort: widgetInformations.setStartDraggingPoint, 
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        )
      ]
    );
  }
}

String _getTextOperationTypeTranslation(TextOperationType type) {
  switch (type) {
    case TextOperationType.join:
      return S.current.node_widgets_text_operation_node_options_join;
    case TextOperationType.cut:
      return S.current.node_widgets_text_operation_node_options_cut;
    case TextOperationType.trim:
      return S.current.node_widgets_text_operation_node_options_trim;
    case TextOperationType.trimLeft:
      return S.current.node_widgets_text_operation_node_options_trim_left;
    case TextOperationType.trimRight:
      return S.current.node_widgets_text_operation_node_options_trim_right;
    case TextOperationType.padLeft:
      return S.current.node_widgets_text_operation_node_options_pad_left;
    case TextOperationType.padRight:
      return S.current.node_widgets_text_operation_node_options_pad_right;
    case TextOperationType.contains:
      return S.current.node_widgets_text_operation_node_options_contains;
  }
}