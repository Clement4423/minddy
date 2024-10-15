import 'dart:convert';

import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class ConversionNode implements INode {

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.any];

  @override
  List<NodeDataType> outputsTypes = [NodeDataType.any];

  @override
  List<NodeOutput> outputs = [];

  @override
  List<NodeTarget> targets = [];

  @override
  set execute(Function newExecute) {}

  @override
  Function get execute => main;

  void main() {
    late NodeData finalValue;
    if (inputs.isEmpty) {
      finalValue = NodeData(type: outputsTypes.first, value: getDefaultNodeDataTypeValue(outputsTypes.first));
    } else if (inputs.isNotEmpty) {
      convertNodeData(inputs.first, outputsTypes.first);
    }
    _addDataToOutputs(finalValue);
  }

  void _addDataToOutputs(NodeData data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  NodeData convertNodeData(NodeData baseValue, NodeDataType targetType) {
    dynamic convertedValue;

    switch (targetType) {
      case NodeDataType.number:
        convertedValue = _toNumber(baseValue.value);
        break;
      case NodeDataType.string:
        convertedValue = _toString(baseValue.value);
        break;
      case NodeDataType.boolean:
        convertedValue = _toBoolean(baseValue.value);
        break;
      case NodeDataType.list:
        convertedValue = _toList(baseValue.value);
        break;
      case NodeDataType.color:
        convertedValue = _toColor(baseValue.value);
        break;
      case NodeDataType.any:
        convertedValue = baseValue.value;
    }

    return NodeData(type: targetType, value: convertedValue);
  }

  num _toNumber(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value) ?? 0;
    } else if (value is bool) {
      return value ? 1 : 0;
    } else {
      return 0;
    }
  }

  String _toString(dynamic value) {
    return value.toString();
  }

  bool _toBoolean(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is num) {
      return value.round().clamp(0, 1) != 0;
    } else if (value is String) {
      return value.toLowerCase().trim() == 'true';
    }
    return false;
  }

  List _toList(dynamic value) {
    if (value is List) {
      return value;
    } else {
      return [value];
    }
  }

  dynamic _toColor(dynamic value) {
    return value;  // TODO : Faire la conversion vers une couleur
  }

  @override
  ConversionNode copy() {
    return ConversionNode()
      ..id = id
      ..inputs = inputs
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = targets;
  }

  @override
  String toJson() {
    Map map =  {
      'type': runtimeType.toString(),
      'inputs': inputs.map((e) => e.toString()).toList(),
      'id': id.toString(),
      'inputsTypes': inputsTypes.map((e) => e.name).toList(),
      'outputsTypes': outputsTypes.map((e) => e.name).toList(),
      'targets': targets.map((e) => e.toString()).toList()
    };
    return jsonEncode(map);
  }

  @override
  INode? fromJson(String json) {
    INode inode = INode.deserializeBasicDataFromString(json);
    id = inode.id;
    inputs = inode.inputs;
    inputsTypes = inode.inputsTypes;
    outputsTypes = inode.outputsTypes;
    
    return this;
  }
}
