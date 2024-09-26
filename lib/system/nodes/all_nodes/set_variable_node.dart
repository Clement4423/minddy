import 'dart:convert';

import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class SetVariableNode implements INode {
  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.any];

  @override
  List<NodeDataType> outputsTypes = [];

  @override
  List<NodeOutput> outputs = [];

  @override
  List<NodeTarget> targets = [];

  @override
  set execute(Function newExecute) {}

  @override
  Function get execute => main;

  void main() { // (Can be async)
    // TODO : Fill the main method
    _addDataToOutputs(null); // TODO Fill the correct value
  }

  void _addDataToOutputs(dynamic data) {
    for (NodeTarget target in targets) {
      outputs.add(NodeOutput(data: data, target: target.node, inputIndex: target.inputIndex));
    }
  }

  @override
  SetVariableNode copy() {
    return SetVariableNode()
      ..id = id
      ..inputs = inputs
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = targets;
      // TODO : Add the rest of the class
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
      // TODO : Add the rest of the class.
    };
    return jsonEncode(map);
  }

  @override
  INode? fromJson(String json) {
    // Map<String, dynamic> map = jsonDecode(json); 
    // You can uncomment to access the map. Be aware to respect coherance between toJson and fromJson.

    INode inode = INode.deserializeBasicDataFromString(json);
    id = inode.id;
    inputs = inode.inputs;
    inputsTypes = inode.inputsTypes;
    outputsTypes = inode.outputsTypes;

    // TODO : Add the rest of the class

    return this;
  }
}
