// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/theme/theme.dart';


/// A [`NodeTreeVariable`] is used for storing values from the tree, and make them accessible for every tree.
/// 
/// 
///  ### Explanation:
/// 
/// When using a plugin, the plugin itself will hold every variable in its memory. 
/// Then, the variables are shared across all [`NodeTree`], and each [`NodeTree`] can modify each variable, 
/// changes that will be available for every [`NodeTree`].
class NodeTreeVariable {
  /// The name of `this` variable
  String name;
  
  /// The type of `this` variable
  NodeDataType type;

  /// The unique id of `this` variable. 
  /// 
  /// Must be unique
  int id;

  /// The value of `this` variable. 
  /// 
  /// Must respect the `type`
  dynamic value;

  /// Returns a json representation of `this`
  String toJson() {
    return jsonEncode(
      {
        'name': name,
        'type': type.index,
        'id': id
      }
    );
  }

  /// Create a new [`NodeTreeVariable`] from a json string
  static NodeTreeVariable? fromJson(String json) {
    try {
      Map? map = jsonDecode(json);

      if (map != null) {
        String? name = map['name'];

        NodeDataType? type = NodeDataType.values[map['type']];

        int? id = map['id'];

        if (name != null && id != null ) {
          return NodeTreeVariable(name: name, type: type, id: id);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  NodeTreeVariable({required this.name, required this.type, required this.id});
}

/// This class is basicly the same as INode, but it extends it to make widgets out of notes
// ignore: must_be_immutable
abstract class INodeWidget extends Widget {
  INodeWidget({super.key});

  /// This represents the position of the node relatively to the board
  late Offset position;
  
  /// This is the node that is represented by the widget
  late INode node;

  /// The width of the widget
  late double width;

  /// The height of the widget
  late double height;

  /// This will contain all the positions of the node inputs port.
  late List<Offset> inputsOffsets;

  /// This will contain all the positions of the node outputs port.
  late List<Offset> outputsOffsets;

  /// This represents the borders that the node can't cross
  late Offset maxOffset;

  /// Theme is used as an argument, so that only one instance of StylesGetters is used by every node.
  late StylesGetters theme;

  late NodeWidgetFunctions functions;
  /// This will return a string representatin of this object  
  String toJson() {
    throw UnimplementedError();
  }

  /// This makes a copy of the current node, by creating a new instance
  INodeWidget copy(GlobalKey newKey) {
    throw UnimplementedError();
  }
  
  /// This will return a INodeWidget Object, recreated from string
  static INodeWidget? fromJson(
    GlobalKey key,
    String json, 
    Offset maxOffset, 
    StylesGetters theme, 
    Function(NodePortInfo? info) setSelectedPort, 
    bool Function() getIsDragging, 
    Function(bool) setIsDragging, 
    Function(NodeConnection) addConnection
  ) {
    throw UnimplementedError();
  }
}

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
  final Function updateConnections;
  final Function saveState;

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
    required this.updateConnections,
    required this.saveState,
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

/// This is a class that each Node must implement, it contains all the variables that a Node will require to work well.
class INode {
  /// The node id, must be unique
  int id = 0;

  /// The list of all the node inputs
  List<NodeData> inputs = [];

  /// A list of the attended inputs types
  List<NodeDataType> inputsTypes = [];

  /// The list of all the node outputs
  List<NodeOutput> outputs = [];

  /// A list of the attended outputs types
  List<NodeDataType> outputsTypes = [];

  /// The list of the nodes this one is pointing to
  List<NodeTarget> targets = [];

  /// The action of the node
  Function execute = () {};

  /// This will return a INode Object, recreated from a string
  INode? fromJson(String string) {
    throw UnimplementedError();
  }

  /// This will deserialize data such as inputs or outputs from a string
  static INode deserializeBasicDataFromString(String string) {
    Map<String, dynamic> map = jsonDecode(string);

    INode inode = INode();

    inode.id = int.tryParse( map['id'].toString()) ?? 0;

    List inputsAsJson = map['inputs'] != null ? map['inputs'] as List : [];
    inode.inputs = inputsAsJson.map((e) => NodeData.fromString(e as String)!).toList();

    List inputsTypesAsJson = map['inputsTypes'] != null ? map['inputsTypes'] as List : [];
    inode.inputsTypes = inputsTypesAsJson.map((e) => NodeDataType.values.firstWhere((type) => type.name == e)).toList();

    List outputsTypesAsJson = map['outputsTypes'] != null ? map['outputsTypes'] as List : [];
    inode.outputsTypes = outputsTypesAsJson.map((e) => NodeDataType.values.firstWhere((type) => type.name == e)).toList();

    return inode;
  }

  /// This serves in the case where the Node is created from Json, 
  /// and targets cannot be declared until the whole nodes list is declared.
  /// (Because it needs to know to which node it is pointing to)
  /// 
  /// This will return the NodeTarget list.
  static List<NodeTarget> initializeTargets(List<INode> nodes, Map<int, List<String>> targetsStringsPerNodesMap, int id) {

    List<NodeTarget> targetsList = [];
    if (targetsStringsPerNodesMap[id] != null) {
      targetsList = targetsStringsPerNodesMap[id]!.map((targetString) {
        NodeTarget? target = NodeTarget.fromString(targetString, nodes);
        if (target != null) {
          INode? targetNode = nodes.firstWhere((node) => node.id == target.node.id);
          return NodeTarget(node: targetNode, inputIndex: target.inputIndex, outputIndex: target.outputIndex);
        }
      }).whereType<NodeTarget>().toList();

      return targetsList;
    }
    return [];
  }

  /// Please use this instead of `[toString()]`
  /// 
  /// Will return a Json reprentation of `this`
  String toJson() {
    throw UnimplementedError();
  }

  /// Thiw will evaluate if the data is corresponding to what is attended.
  /// 
  /// If it is, returns the data.
  /// 
  /// If it is, but needs a conversion, it will do it and return the new data
  /// 
  /// Otherwise returns `null`
  static NodeData? evaluateData(NodeData data, NodeDataType attended) {
    if (data.type == attended || attended == NodeDataType.any) {
      return data;
    } else if (data.type == NodeDataType.number && attended == NodeDataType.number) {
      // Convert number to the appropriate type (int or double)
      return NodeData(type: NodeDataType.number, value: (data.value as num));
    } else if (data.type == NodeDataType.string && attended == NodeDataType.boolean) {
      // Convert string to boolean if possible
      if (data.value.toString().toLowerCase() == 'true') {
        return NodeData(type: NodeDataType.boolean, value: true);
      } else if (data.value.toString().toLowerCase() == 'false') {
        return NodeData(type: NodeDataType.boolean, value: false);
      }
    } else if (data.type == NodeDataType.boolean && attended == NodeDataType.string) {
      // Convert boolean to string
      return NodeData(type: NodeDataType.string, value: data.value.toString());
    }

    return null;
  }

  /// This will evaluate the connections between outputs and target inputs.
  /// 
  /// Returns a NodeEvaluation containing a `isValid` value as well as a list of inccorectInputs
  static NodeEvaluation evaluateConnections(List<NodeOutput> outputsList) {
    List<NodeOutput> incorrectOutputs = [];

    for (int i = 0; i < outputsList.length; i++) {
      NodeOutput output = outputsList[i];

      if (output.inputIndex < output.target.inputsTypes.length) {
        NodeDataType expectedType = output.target.inputsTypes[output.inputIndex];
        NodeData? evaluatedData = evaluateData(output.data, expectedType);

        if (evaluatedData == null) {
          incorrectOutputs.add(output);
        }
      } else {
        incorrectOutputs.add(output);
      }
    }

    return NodeEvaluation(
      isValid: incorrectOutputs.isEmpty, 
      incorrectOutputs: incorrectOutputs
    );
  }

  /// This makes a copy of the current node, by creating a new instance
  INode copy() {
    throw UnimplementedError();
  }
}

/// This is used for the nodes that has no outputs, the last one.
class IOutputNode implements INode {
  /// The node id, must be unique
  @override
  int id = 0;

  /// The list of all the node inputs
  @override
  List<NodeData> inputs = [];

  /// A list of the attended inputs types
  @override
  List<NodeDataType> inputsTypes = [];

  /// The list of all the node outputs
  @override
  List<NodeOutput> outputs = [];

  /// A list of the attended outputs types
  @override
  List<NodeDataType> outputsTypes = [];

  /// The list of the nodes this one is pointing to
  @override
  List<NodeTarget> targets = [];

  /// The action of the node
  @override
  Function execute = () {};

  // This method will return a NodeData from the input
  Future<NodeData?> Function() getResult = () async {return;};

  /// This makes a copy of the current node, by creating a new instance
  @override
  INode copy() {
    throw UnimplementedError();
  }

  /// This will return a INode Object, recreated from a string
  @override
  INode? fromJson(String string) {
    throw UnimplementedError();
  }

  /// Please use this instead of `[toString()]`
  /// 
  /// Will return a Json reprentation of `this`
  @override
  String toJson() {
    throw UnimplementedError();
  }
}

// void main() async {
//   MathNode nodeD = MathNode()..inputs = [NodeData(type: NodeDataType.int, value: 20)];
//   MathNode nodeA = MathNode();
//   ComparisonNode nodeB = ComparisonNode(comparisonType: ComparisonNodeType.greatherThan);
//   BooleanOutputNode nodeC = BooleanOutputNode();

//   nodeA.targets = [NodeTarget(node: nodeB, inputIndex: 0, outputIndex: 0)];
//   nodeB.targets = [NodeTarget(node: nodeC, inputIndex: 0, outputIndex: 0)];
//   nodeD.targets = [NodeTarget(node: nodeA, inputIndex: 0, outputIndex: 0), NodeTarget(node: nodeA, inputIndex: 1, outputIndex: 0), NodeTarget(node: nodeB, inputIndex: 1, outputIndex: 0)];

//   NodeTree tree = NodeTree(nodes: [nodeA, nodeB, nodeC, nodeD], id: createUniqueId(), variables: []);
  
//   String treeAsString = tree.toString();
//   NodeTree? treeFromString = NodeTree.fromString(treeAsString, []);
//   NodeData? data = await treeFromString?.run();
//   print(data);
// }