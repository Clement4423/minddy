import 'dart:convert';
import 'dart:math';

import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

enum MathNodeType {
  addition,
  substraction,
  division,
  multiplication,
  squareRoot,
  power,
  min,
  max,
  sign,
  round,
  floor,
  ceil,
  truncate,
  sin,
  cos,
  tan,
  asin,
  acos,
  atan,
  sinh,
  cosh,
  tanh,
  asinh,
  acosh,
  atanh,
  ln,
  log10,
  abs
}

class MathNode implements INode {

  MathNodeType operationType;

  MathNode({this.operationType = MathNodeType.addition});

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.number, NodeDataType.number];

  @override
  List<NodeDataType> outputsTypes = [NodeDataType.number];

  @override
  List<NodeOutput> outputs = [];

  @override
  List<NodeTarget> targets = [];

  @override
  set execute(Function newExecute) {}

  @override
  Function get execute => main;

  void main() {
    num result = 0;
    num value1 = inputs.isNotEmpty ? inputs[0].value ?? 1.0 : 1.0;
    num value2 = inputs.length > 1 ? inputs[1].value ?? 1.0 : 1.0;
    switch (operationType) {
      case MathNodeType.addition:
        result = value1 + value2;
        break;
      case MathNodeType.substraction:
        result = value1 - value2;
        break;
      case MathNodeType.division:
        result = getDivision(value1, value2);
        break;
      case MathNodeType.multiplication:
        result = value1 * value2;
        break;
      case MathNodeType.squareRoot:
        result = sqrt(value1.isNegative ? 0 : value1).toDouble();
        break;
      case MathNodeType.power:
        result = pow(value1, value2);
        break;
      case MathNodeType.min:
        result = min(value1, value2).toDouble();
        break;
      case MathNodeType.max:
        result = max(value1, value2).toDouble();
        break;
      case MathNodeType.sign:
        result = value1 > 0 ? 1.0 : (value1 < 0 ? -1.0 : 0.0);
        break;
      case MathNodeType.round:
        result = value1.roundToDouble();
        break;
      case MathNodeType.floor:
        result = value1.floorToDouble();
        break;
      case MathNodeType.ceil:
        result = value1.ceilToDouble();
        break;
      case MathNodeType.truncate:
        result = value1.truncateToDouble();
        break;
      case MathNodeType.sin:
        result = sin(value1);
        break;
      case MathNodeType.cos:
        result = cos(value1);
        break;
      case MathNodeType.tan:
        result = tan(value1);
        break;
      case MathNodeType.asin:
        result = asin(value1);
        break;
      case MathNodeType.acos:
        result = acos(value1);
        break;
      case MathNodeType.atan:
        result = atan(value1);
        break;
      case MathNodeType.sinh:
        result = sinh(value1);
        break;
      case MathNodeType.cosh:
        result = cosh(value1);
        break;
      case MathNodeType.tanh:
        result = tanh(value1);
        break;
      case MathNodeType.asinh:
        result = asinh(value1);
        break;
      case MathNodeType.acosh:
        result = acosh(value1);
        break;
      case MathNodeType.atanh:
        result = atanh(value1);
        break;
      case MathNodeType.ln:
        result = log(value1);
        break;
      case MathNodeType.log10:
        result = log(value1) / ln10;
        break;
      case MathNodeType.abs:
        result = value1.abs();
        break;
    }

    _addDataToOutputs(NodeData(type: NodeDataType.number, value: result));
  }

  num getDivision(num num1, num num2) {
    if (num2 == 0) {
      return 0;
    } else {
      return num1 / num2;
    }
  }

  void _addDataToOutputs(dynamic data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  MathNode copy() {
    return MathNode()
      ..id = id
      ..inputs = inputs
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = targets
      ..operationType = operationType;
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
      'operationType': operationType.index
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

    operationType = MathNodeType.values[int.tryParse(map['operationType'].toString()) ?? 0];

    return this;
  }
}