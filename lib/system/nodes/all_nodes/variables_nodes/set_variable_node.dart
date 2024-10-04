import 'dart:convert';

import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/interfaces/node_variable_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree_variable_manager.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class SetVariableNode implements IVariableNode {

  @override
  NodeTreeVariablesManager variablesManager;

  @override
  int? selectedVariableId;
  
  SetVariableNode({required this.variablesManager, this.selectedVariableId});

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

  void main() { // (Can be async)
    if (inputs.isEmpty || selectedVariableId == null) {
      return;
    } else {
      variablesManager.setVariableValue(NodeData(type: inputs.first.type, value: inputs.first.value), selectedVariableId!);
    }
  }

  @override
  SetVariableNode copy() {
    return SetVariableNode(variablesManager: variablesManager)
      ..id = id
      ..inputs = inputs
      ..inputsTypes = inputsTypes
      ..outputs = outputs
      ..outputsTypes = outputsTypes
      ..targets = targets
      ..selectedVariableId = selectedVariableId;
      
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
      'selectedVariableId': selectedVariableId ?? -1
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
    variablesManager = variablesManager;
    selectedVariableId =  map['selectedVariableId'] == -1 ? null : map['selectedVariableId'];

    return this;
  }
}
