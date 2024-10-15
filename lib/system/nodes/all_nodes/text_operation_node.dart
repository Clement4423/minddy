import 'dart:convert';

import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

enum TextOperationType {
  join,
  cut,
  trim,
  trimLeft,
  trimRight,
  padLeft,
  padRight,
  contains
}

class TextOperationNode implements INode {

  TextOperationType? textOperationType;

  TextOperationNode({this.textOperationType = TextOperationType.join});

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.string, NodeDataType.any, NodeDataType.any];

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

  void main() { // (Can be async)

    dynamic result = '';
    NodeDataType resultType = NodeDataType.string;

    String input1 = inputs.first.value;
    var input2 = inputs[1].value;
    var input3 = inputs.length > 2 ? inputs[2].value : 0.0;

    switch (textOperationType) {
      case TextOperationType.join:
        result = "$input1$input2";
        resultType = NodeDataType.string;
        break;
      case TextOperationType.cut:
        result = input1.substring(input2, input3);
        resultType = NodeDataType.string;
        break;
      case TextOperationType.trim:
        result = input1.trim();
        resultType = NodeDataType.string;
        break;
      case TextOperationType.trimLeft:
        result = input1.trimLeft();
        resultType = NodeDataType.string;
        break;
      case TextOperationType.trimRight:
        result = input1.trimRight();
        resultType = NodeDataType.string;
        break;
      case TextOperationType.padLeft:
        result = input1.padLeft(input3, input2);
        resultType = NodeDataType.string;
        break;
      case TextOperationType.padRight:
        result = input1.padRight(input3, input2);
        resultType = NodeDataType.string;
        break;
      case TextOperationType.contains:
        result = input1.contains(input2.toString());
        resultType = NodeDataType.boolean;
        break;
      default:
        return;
    }

    _addDataToOutputs(NodeData(type: resultType, value: result));
  }

  void _addDataToOutputs(NodeData data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  TextOperationNode copy() {
    return TextOperationNode()
      ..id = id
      ..inputs = inputs
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = targets
      ..textOperationType = textOperationType;
      
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
      'textOperationType': textOperationType?.index ?? -1
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
    textOperationType = map['textOperationType'] == -1 
      ? TextOperationType.join 
      : TextOperationType.values[map['textOperationType']];

    return this;
  }
}
