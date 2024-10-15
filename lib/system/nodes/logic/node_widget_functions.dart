// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_tree_variable_manager.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';

class NodeWidgetFunctions {
  // Original functions passed as arguments
  final bool Function() getIsDragging;
  final Function(bool) setIsDragging;
  final void Function(NodePortInfo, [Offset? cursorOffset]) addConnection;
  final Function(NodePortInfo?) setSelectedPort;
  final NodePortInfo? Function() getSelectedPort;
  final List<NodeConnection> Function() getConnections;
  final List<INodeWidget> Function() getSelectedNodes;
  final Function(List<INodeWidget>) setSelectedNode;
  final Function(INodeWidget) updateNode;
  final Function updateAllNodes;
  final Function updateConnections;
  final Function saveState;
  final NodeTreeVariablesManager variablesManager;

  NodeWidgetFunctions({
    required this.getIsDragging,
    required this.setIsDragging,
    required this.addConnection,
    required this.setSelectedPort,
    required this.getSelectedPort,
    required this.getConnections,
    required this.getSelectedNodes,
    required this.setSelectedNode,
    required this.updateNode,
    required this.updateAllNodes,
    required this.updateConnections,
    required this.saveState,
    required this.variablesManager
  });

  /// This function will ensure the node widget is correctly placed, within the bound of the node board.
  void verifyPosition(INodeWidget w) {
    double maxDx = (w.maxOffset.dx - w.width).clamp(0.0, double.infinity);
    double maxDy = (w.maxOffset.dy - w.height).clamp(0.0, double.infinity);

    double dx = w.position.dx.clamp(0.0, maxDx);
    double dy = w.position.dy.clamp(0.0, maxDy);

    Offset clampedPosition = Offset(dx, dy);
    w.position = clampedPosition;
    updateNode(w);
  }

  /// This function is a generic function that ensure each node widget correctly update when dragged
  void onDragUpdate(DragUpdateDetails details, INodeWidget widget) {
    List<INodeWidget> selectedNodes = getSelectedNodes();
    Offset delta = details.delta;

    for (INodeWidget w in selectedNodes) {
      w.position += delta;
      verifyPosition(w);
    }
  }

  /// This function is a generic function that ensure each node widget correctly update when tapped down
  void handleTapDown(INodeWidget widget) {
    List<INodeWidget> selectedNodes = getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
    if (!selectedNodes.contains(widget) && selectedNodes.length == 1 && !isShiftPressed) {
      selectedNodes.clear();
      selectedNodes.add(widget);
    } else if (!selectedNodes.contains(widget) && isShiftPressed) {
      selectedNodes.add(widget);
    } else if (isShiftPressed) {
      if (selectedNodes.indexOf(widget) == selectedNodes.length - 1) {
        selectedNodes.remove(widget);
      } else {
        selectedNodes.remove(widget);
        selectedNodes.add(widget);
      }
    }
    setSelectedNode(selectedNodes);
  }

  /// This function is a generic function that ensure each node widget correctly update when tapped up
  void handleTapUp(INodeWidget widget) {
    List<INodeWidget> selectedNodes = getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

    if (!selectedNodes.contains(widget) && !isShiftPressed) {
      if (!isShiftPressed) {
        selectedNodes.clear();
      }
      selectedNodes.add(widget);
    } else if (selectedNodes.contains(widget) && selectedNodes.length > 1 && !isShiftPressed) {
      selectedNodes.clear();
      selectedNodes.add(widget);
    }

    setSelectedNode(selectedNodes);
  }

  /// This function will add the tapped widget to the selectedNodes list.
  void setAsSelectedIfNotAlready(INodeWidget widget) {
    List<INodeWidget> selectedNodes = getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
    if (!selectedNodes.contains(widget)) {
      if (!isShiftPressed) {
        selectedNodes.clear();
      }
      selectedNodes.add(widget);
      setSelectedNode(selectedNodes);
    }
  }

  /// This function checks if a node port is already connected with another node port.
  bool isPortAlreadyHaveConnection(int portIndex, NodePortType portType, INodeWidget widget) {
    if (portType == NodePortType.output) {
      return widget.node.targets.map(
        (p) => p.outputIndex == portIndex
      ).contains(true);
    } else {
      return getConnections().map(
        (c) => c.endNode.node.id == widget.node.id && c.endInputIndex == portIndex
      ).contains(true);
    }
  }

  /// This function is a generic function that will ensure that a node input has the correct type of data, 
  /// in accordance with the inputs types list
  void changeValueForPort(dynamic value, NodePortInfo portInfo, INodeWidget widget) {
    NodeDataType? detectedType = _getNodeDataTypeBasedOnRuntimeType(value.runtimeType);

    if (detectedType == null) {
      return;
    }

    NodeData? evaluatedData = _evaluateInputData(value, detectedType, widget, portInfo);

    if (evaluatedData != null) {
      _updateInput(widget, portInfo, evaluatedData);
    } else {
      _resetInput(widget, detectedType, portInfo.portIndex);
    }

    saveState();
  }

  /// This function evaluates the data, and compares if a given value for an input corresponds to the input type.
  NodeData? _evaluateInputData(dynamic value, NodeDataType detectedType, INodeWidget widget, NodePortInfo portInfo) {
    return INode.evaluateData(
      NodeData(type: detectedType, value: value), 
      widget.node.inputsTypes[portInfo.portIndex]
    );
  }

  /// This function updates a widget input with a new `NodeData`
  void _updateInput(INodeWidget widget, NodePortInfo portInfo, NodeData newData) {
    widget.node.inputs[portInfo.portIndex] = newData;
  }

  /// This returns the `NodeDataType` that corresponds to the Dart type
  NodeDataType? _getNodeDataTypeBasedOnRuntimeType(Type type) {
    if (type == Null) {
      return null;
    } else if (type == bool) {
      return NodeDataType.boolean;
    } else if (type == String) {
      return NodeDataType.string;
    } else if (type == num || type == int || type == double) {
      return NodeDataType.number;
    } else if (type == Color) {
      return NodeDataType.color;
    } else if (type == List) {
      return NodeDataType.list;
    } else {
      return null;
    }
  }

  /// This function ensures every input of a node is assigned to a value.
  void verifyInputs(INodeWidget widget) {
    for (int i = 0; i < widget.node.inputsTypes.length; i++) {
      if (widget.node.inputs.elementAtOrNull(i) == null) {
        _resetInput(widget, widget.node.inputsTypes[i]);
      } else if (widget.node.inputs.elementAt(i).type != widget.node.inputsTypes.elementAt(i)) {
        _resetInput(widget, widget.node.inputsTypes.elementAt(i), i);
      }
    }
  }

  /// This function resets the value of an input, based on the input type
  _resetInput(INodeWidget widget, NodeDataType type, [int? index]) {
    NodeData nodeData = NodeData(type: type, value: getDefaultNodeDataTypeValue(type));
    if (index != null) {
      widget.node.inputs[index] = nodeData;
    } else {
      widget.node.inputs.add(nodeData);
    }
  } 

  /// This is usefull when a widget option changes which inputs are needed. 
  /// 
  /// This function will remove targets that are pointing to an unnecessary input, as well as reseting the values of the inputs.
  void resetUnnecessaryInputs(INodeWidget widget, List<int> unnecessaryInputsIndexes, List<NodeConnection> connections) {
    List<int> inputsReset = [];
    for (NodeConnection connection in connections) {
      if (connection.endNode.node.id == widget.node.id && unnecessaryInputsIndexes.contains(connection.endInputIndex)) {
        connection.startNode.node.targets.removeWhere((t) => t.node.id == widget.node.id && t.inputIndex == connection.endInputIndex);
        // Add to inputsReset only if it hasn't already been reset
        if (!inputsReset.contains(connection.endInputIndex)) {
          inputsReset.add(connection.endInputIndex);
        }
      }
    }
    List<int> inputsToReset = unnecessaryInputsIndexes.where((input) => !inputsReset.contains(input)).toList();

    for (int inputIndex in inputsToReset) {
      if (widget.node.inputs.elementAtOrNull(inputIndex) != null) {
        _resetInput(widget, widget.node.inputsTypes[inputIndex], inputIndex);
      }
    }
  }
}
