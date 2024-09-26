import 'dart:convert';

import 'package:minddy/system/interface/i_output_node.dart';
import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class MyNewOutputNode implements IOutputNode {
  @override
  Function get execute => main;

  @override
  set execute(Function newExecute) {}

  @override
  int id = createUniqueId();

  @override
  List<NodeData> inputs = [];

  @override
  List<NodeDataType> inputsTypes = []; // TODO : Fill inputs types

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
    // TODO : Fill the main method
    return null;
  }

  @override
  MyNewOutputNode copy() {
    return MyNewOutputNode()
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