// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'dart:convert';
import 'package:minddy/system/nodes/logic/node_data_models.dart';

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
