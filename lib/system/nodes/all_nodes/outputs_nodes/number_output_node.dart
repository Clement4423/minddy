import 'dart:convert';

import 'package:minddy/system/interfaces/output_node_interface.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class NumberOutputNode implements IOutputNode {
  @override
  Function get execute => main;

  @override
  set execute(Function newExecute) {}

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = [NodeDataType.number];

  @override
  List<NodeDataType> outputsTypes = []; 
  // Outputs fields are not needed, as the node as no outputs, but it still has to be overriden, because 
  // The node tree has to count this node as a normal node.

  @override
  List<NodeOutput> outputs = [];

  @override
  List<NodeTarget> targets = [];

  @override
  set getResult(Future<NodeData?> Function() newGetResult) {}

  @override
  Future<NodeData?> Function() get getResult => main;

  Future<NodeData?> main() async {
    return NodeData(
      type: NodeDataType.number, 
      value: inputs.firstOrNull
    );
  }

  @override
  NumberOutputNode copy() {
    return NumberOutputNode()
      ..id = id
      ..inputs = List.from(inputs)
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = List.from(targets);
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