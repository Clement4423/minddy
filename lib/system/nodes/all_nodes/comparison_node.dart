import 'dart:convert';

import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

enum ComparisonNodeType {
  lessThan,
  lessThanOrEqual,
  greatherThan,
  greatherThanOrEqual,
  equal
}

class ComparisonNode implements INode {

  ComparisonNodeType comparisonType;

  ComparisonNode({this.comparisonType = ComparisonNodeType.lessThan});

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.number, NodeDataType.number];

  @override
  List<NodeDataType> outputsTypes = [NodeDataType.boolean];

  @override
  List<NodeOutput> outputs = [];

  @override
  List<NodeTarget> targets = [];

  @override
  set execute(Function newExecute) {}

  @override
  Function get execute => main;

  void main() {
    bool result = false;
    dynamic value1 = inputs.isNotEmpty ? inputs[0].value ?? 1.0 : 1.0;
    dynamic value2 = inputs.length > 1 ? inputs[1].value ?? 1.0 : 1.0;
    try {
      switch (comparisonType) {
      case ComparisonNodeType.equal:
        result = value1 == value2;
        break;
      case ComparisonNodeType.greatherThan:
        result = value1 > value2;
        break;
      case ComparisonNodeType.greatherThanOrEqual:
        result = value1 >= value2;
        break;
      case ComparisonNodeType.lessThan:
        result = value1 < value2;
        break;
      case ComparisonNodeType.lessThanOrEqual:
        result = value1 <= value2;
        break;
      }
    } catch (e) {
      _addDataToOutputs(NodeData(type: NodeDataType.boolean, value: false));
    }
    _addDataToOutputs(NodeData(type: NodeDataType.boolean, value: result));
  }

  void _addDataToOutputs(dynamic data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  ComparisonNode copy() {
    return ComparisonNode()
      ..id = id
      ..inputs = List.from(inputs)
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = List.from(targets)
      ..comparisonType = comparisonType;
  }

  @override
  String toJson() {
    Map map =  {
      'type': runtimeType.toString(),
      'inputs': inputs.map((e) => e.toString()).toList(),
      'id': id.toString(),
      'inputsTypes': inputsTypes.map((e) => e.name).toList(),
      'outputsTypes': outputsTypes.map((e) => e.name).toList(),
      'targets': targets.map((e) => e.toString()).toList(),
      'comparisonType': comparisonType.index
    };
    return jsonEncode(map);
  }

  @override
  INode? fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json); 

    INode inode = INode.deserializeBasicDataFromString(json);
    id = inode.id;
    inputs = inode.inputs;
    inputsTypes = inode.inputsTypes;
    outputsTypes = inode.outputsTypes;

    comparisonType = ComparisonNodeType.values[int.tryParse(map['comparisonType'].toString()) ?? 0];

    return this;
  }
}
