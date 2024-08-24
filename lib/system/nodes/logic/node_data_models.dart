// Système de node comme origami
// -> Noeuds de logique
// -> Noeuds d'interface

import 'dart:convert';

import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';

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

// TODO : Revoir les façons de sauvegarder les Objets et de les retrouver

enum NodeDataType {
  int,
  float,
  string,
  boolean,
  list,
  color,
  widget,
  any
}

class NodeData {
  NodeDataType type;
  dynamic value;

  NodeData({required this.type, required this.value});

  @override
  String toString() => 'NodeData(type: ${type.name}, value: $value)';

  static NodeData? fromString(String string) {
    if (string.startsWith('NodeData')) {
      string = string.substring('NodeData'.length).trim();

      final RegExp regex = RegExp(r'\(type: (\w+), value: (.+)\)');
      final Match? match = regex.firstMatch(string);

      if (match != null) {
        String typeName = match.group(1)!;
        String valueString = match.group(2)!;

        NodeDataType? type;
        try {
          type = NodeDataType.values.firstWhere((e) => e.name == typeName);
        } catch (e) {
          return null;
        }

        dynamic value;
        switch (type) {
          case NodeDataType.int:
            value = int.tryParse(valueString);
            break;
          case NodeDataType.float:
            value = double.tryParse(valueString);
            break;
          case NodeDataType.boolean:
            value = (valueString.toLowerCase() == 'true');
            break;
          case NodeDataType.string:
            value = valueString;
            break;
          case NodeDataType.list:
            value = valueString.split(',').map((e) => e.trim()).toList();
            break;
          case NodeDataType.color:
            value = null;
            break;
          case NodeDataType.widget:
            value = null;
            break;
          default:
            return null;
        }

        if (value != null) {
          return NodeData(type: type, value: value);
        }
      }
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
  String toString() => 'NodeOutput(data: $data, target: ${target.id}, inputIndex: $inputIndex)';

  static NodeOutput? fromString(String string, List<INode> nodes) {
    if (string.startsWith('NodeOutput')) {
      string = string.substring('NodeOutput'.length).trim();

      final RegExp regex = RegExp(r'\(data: (.+), target: (\d+), inputIndex: (\d+)\)');
      final Match? match = regex.firstMatch(string);

      if (match != null) {
        String dataString = match.group(1)!;
        int targetId = int.parse(match.group(2)!);
        int index = int.parse(match.group(3)!);

        NodeData? data = NodeData.fromString(dataString);

        INode? targetNode;
        try {
          targetNode = nodes.firstWhere((node) => node.id == targetId);
        } catch (e) {
          return null;
        }

        if (data != null) {
          return NodeOutput(data: data, target: targetNode, inputIndex: index);
        }
      }
    }

    return null;
  }
}