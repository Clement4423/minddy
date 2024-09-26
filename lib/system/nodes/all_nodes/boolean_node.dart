import 'dart:convert';

import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

enum BooleanNodeType {
  and, /// A AND B: True if both A and B are true.
  or, /// A OR B: True if either A or B is true.
  not, /// NOT A: Inverts the value of A.
  notAnd, /// A NAND B: True if A and B are both false.
  notOr, /// A NOR B: True if neither A nor B is false.
  equal, /// A == B: True if A and B are equal.
  notEqual, /// A != B: True if A and B are not equal.
  imply,  /// A -> B: False when A is true and B is false.
  subtract, /// A - B: True when A is true and B is false.
}

class BooleanNode implements INode {

  BooleanNodeType booleanType;

  BooleanNode({this.booleanType = BooleanNodeType.and});

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.boolean, NodeDataType.boolean];

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
    bool value1 = inputs.isNotEmpty ? inputs[0].value ?? false : false;
    bool value2 = inputs.length > 1 ? inputs[1].value ?? false : false;

    switch (booleanType) {
      case BooleanNodeType.and:
        result = value1 && value2;
        break;
      case BooleanNodeType.or:
        result = value1 || value2;
        break;
      case BooleanNodeType.not:
        result = !value1;
        break;
      case BooleanNodeType.notAnd:
        result = !(value1 && value2);
        break;
      case BooleanNodeType.notOr:
        result = !(value1 || value2);
        break;
      case BooleanNodeType.equal:
        result = value1 == value2;
        break;
      case BooleanNodeType.notEqual:
        result = value1 != value2;
        break;
      case BooleanNodeType.imply:
        result = !value1 || value2;
        break;
      case BooleanNodeType.subtract:
        result = value1 && !value2;
        break;
    }

    _addDataToOutputs(result);
  }

  void _addDataToOutputs(dynamic data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  BooleanNode copy() {
    return BooleanNode()
      ..id = id
      ..inputs = List.from(inputs)
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = List.from(targets)
      ..booleanType = booleanType;
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
      'booleanType': booleanType.index
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

    booleanType = BooleanNodeType.values[int.tryParse(map['booleanType'].toString()) ?? 0];

    return this;
  }
}
