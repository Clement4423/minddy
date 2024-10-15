import 'dart:convert';
import 'dart:math';

import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class RandomNumberNode implements INode {
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

  void main() { // (Can be async)
    num min = num.tryParse(inputs.firstOrNull?.value.toString() ?? '0.0') ?? 0.0;
    num max = (inputs.length > 1 ? num.tryParse(inputs.last.value.toString()) ?? 1.0 : 1.0).clamp(min, double.infinity);

    num randomNumber = _generateRandomNumber(min, max);

    _addDataToOutputs(NodeData(type: NodeDataType.number, value: randomNumber));
  }

  num _generateRandomNumber(num min, num max) {
    final random = Random();
    return min + (random.nextDouble() * (max - min));
  }

  void _addDataToOutputs(dynamic data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  RandomNumberNode copy() {
    return RandomNumberNode()
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
  RandomNumberNode? fromJson(String json) {
    // Map<String, dynamic> map = jsonDecode(json); 
    // You can uncomment to access the map. Be aware to respect coherance between toJson and fromJson.

    INode inode = INode.deserializeBasicDataFromString(json);
    id = inode.id;
    inputs = inode.inputs;
    inputsTypes = inode.inputsTypes;
    outputsTypes = inode.outputsTypes;

    return this;
  }
}
