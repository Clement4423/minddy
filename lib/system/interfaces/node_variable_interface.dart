import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree_variable_manager.dart';

/// This is used for nodes that requires variables
class IVariableNode implements INode {

  /// This will make the node able to access variables.
  late NodeTreeVariablesManager variablesManager;

  late int? selectedVariableId;

  /// The node id, must be unique
  @override
  int id = 0;

  /// The list of all the node inputs
  @override
  List<NodeData> inputs = [];

  /// A list of the attended inputs types
  @override
  List<NodeDataType> inputsTypes = [];

  /// The list of all the node outputs
  @override
  List<NodeOutput> outputs = [];

  /// A list of the attended outputs types
  @override
  List<NodeDataType> outputsTypes = [];

  /// The list of the nodes this one is pointing to
  @override
  List<NodeTarget> targets = [];

  /// The action of the node
  @override
  Function execute = () {};

  /// This makes a copy of the current node, by creating a new instance
  @override
  INode copy() {
    throw UnimplementedError();
  }

  /// This will return a INode Object, recreated from a string
  @override
  INode? fromJson(String string) {
    throw UnimplementedError();
  }

  /// Please use this instead of `[toString()]`
  /// 
  /// Will return a Json reprentation of `this`
  @override
  String toJson() {
    throw UnimplementedError();
  }
}