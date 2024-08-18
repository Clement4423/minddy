// Système de node comme origami
// -> Noeuds de logique
// -> Noeuds d'interface

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/nodes/all_nodes/comparison_node.dart';
import 'package:minddy/system/nodes/all_nodes/operation_node.dart';
import 'package:minddy/system/nodes/all_nodes/outputs_nodes/boolean_output_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is ([automaticly created if not provided]) -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it's type to the [nodeTypeConstructors] in the node_tree.dart file at line 223.
// -> Test it.

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

    // Deserialize inputs
    List inputsAsJson = map['inputs'] != null ? map['inputs'] as List : [];
    inode.inputs = inputsAsJson.map((e) => NodeData.fromString(e as String)!).toList();

    // Deserialize input types
    List inputsTypesAsJson = map['inputsTypes'] != null ? map['inputsTypes'] as List : [];
    inode.inputsTypes = inputsTypesAsJson.map((e) => NodeDataType.values.firstWhere((type) => type.name == e)).toList();

    // Deserialize output types
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
          INode? actualNode = nodes.firstWhere((node) => node.id == target.node.id);
          return NodeTarget(node: actualNode, inputIndex: target.inputIndex);
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
  @protected
  static NodeData? evaluateData(NodeData data, NodeDataType attended) {
    if (data.type == attended || attended == NodeDataType.any) {
      return data;
    } else if (data.type == NodeDataType.int && attended == NodeDataType.float) {
      // Convert int to float if expected type is float
      return NodeData(type: NodeDataType.float, value: (data.value as num).toDouble());
    } else if (data.type == NodeDataType.float && attended == NodeDataType.int) {
      // Convert float to int if expected type is int
      return NodeData(type: NodeDataType.int, value: (data.value as num).toInt());
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

  // TODO : Faire les commentaires
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

void main() async {
  MathNode nodeD = MathNode()..inputs = [NodeData(type: NodeDataType.int, value: 20)];
  MathNode nodeA = MathNode();
  ComparisonNode nodeB = ComparisonNode(comparisonType: ComparisonNodeType.greatherThan);
  BooleanOutputNode nodeC = BooleanOutputNode();

  nodeA.targets = [NodeTarget(node: nodeB, inputIndex: 0)];
  nodeB.targets = [NodeTarget(node: nodeC, inputIndex: 0)];
  nodeD.targets = [NodeTarget(node: nodeA, inputIndex: 0), NodeTarget(node: nodeA, inputIndex: 1), NodeTarget(node: nodeB, inputIndex: 1)];

  NodeTree tree = NodeTree(nodes: [nodeA, nodeB, nodeC, nodeD], id: createUniqueId());
  
  String treeAsString = tree.toString();
  NodeTree? treeFromString = NodeTree.fromString(treeAsString);
  NodeData? data = await treeFromString?.run();
  print(data);
}