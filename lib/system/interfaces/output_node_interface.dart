// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';

/// This is used for the nodes that has no outputs, the last one.
class IOutputNode implements INode {
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

  // This method will return a NodeData from the input
  Future<NodeData?> Function() getResult = () async {return;};

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