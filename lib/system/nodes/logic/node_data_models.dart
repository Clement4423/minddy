// Système de node comme origami
// -> Noeuds de logique
// -> Noeuds d'interface

import 'dart:convert';

import 'package:minddy/system/interfaces/node_interface.dart';

class NodeEvaluation {
  bool isValid;
  List<NodeOutput> incorrectOutputs;

  NodeEvaluation({required this.isValid, required this.incorrectOutputs});
}

class NodeTarget {
  INode node;
  int inputIndex;
  int outputIndex;

  NodeTarget({required this.outputIndex, required this.node, required this.inputIndex});

  @override
  String toString() {
    return jsonEncode(
      {
        'node': node.id,
        'input_index': inputIndex,
        'output_index': outputIndex
      }
    );
  }

  static NodeTarget? fromString(String string, List<INode> nodes) {
    try {
      Map map = jsonDecode(string);

      INode node = nodes.firstWhere((node) => node.id == map['node']);

      int inputIndex = map['input_index'];

      int outputIndex = map['output_index'];

      return NodeTarget(outputIndex: outputIndex, node: node, inputIndex: inputIndex);
    } catch (e) {
      return null;
    }
  }
}

enum NodeDataType {
  number,
  string,
  boolean,
  list,
  color,
  any
}

class NodeData {
  NodeDataType type;
  dynamic value;

  NodeData({required this.type, required this.value});

  @override
  String toString() {
    return jsonEncode({
      'type': type.name,
      'value': value
    });
  }

  static NodeData? fromString(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string);

      NodeDataType? type;
      try {
        type = NodeDataType.values.firstWhere((e) => e.name == map['type']);
      } catch (e) {
        return null;
      }

      dynamic value;
      switch (type) {
        case NodeDataType.number:
          value = num.tryParse(map['value'].toString());
          break;
        case NodeDataType.boolean:
          value = (map['value'].toString().toLowerCase() == 'true');
          break;
        case NodeDataType.string:
          value = map['value'].toString();
          break;
        case NodeDataType.list:
          value = (map['value'] as String).split(',').map((e) => e.trim()).toList();
          break;
        case NodeDataType.color:
          // TODO: Handle color conversion properly
          value = null;
          break;
        case NodeDataType.any:
          value = map['value'];
          break;
      }

      if (value != null) {
        return NodeData(type: type, value: value);
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}

class NodeOutput {
  NodeData data;
  INode target;
  int inputIndex;

  NodeOutput({required this.data, required this.target, required this.inputIndex});

  @override
  String toString() {
    return jsonEncode({
      'data': data.toString(), // Ensure NodeData uses its own toString (which is already a JSON string)
      'target': target.id, // Assuming target has an ID field to uniquely identify it
      'inputIndex': inputIndex
    });
  }

  static NodeOutput? fromString(String string, List<INode> nodes) {
    try {
      // Decode the JSON string into a map
      Map<String, dynamic> map = jsonDecode(string);

      // Retrieve NodeData using the fromString method of NodeData
      NodeData? data = NodeData.fromString(map['data']);
      if (data == null) {
        return null; // Return null if NodeData couldn't be parsed
      }

      // Find the target node by matching the ID in the nodes list
      INode? targetNode;
      try {
        targetNode = nodes.firstWhere((node) => node.id == map['target']);
      } catch (e) {
        return null; // Return null if the target node wasn't found
      }

      // Extract the input index
      int inputIndex = map['inputIndex'];

      // Create and return the NodeOutput instance
      return NodeOutput(data: data, target: targetNode, inputIndex: inputIndex);
    } catch (e) {
      // Return null if there's an error (invalid JSON format or other parsing issues)
      return null;
    }
  }
}