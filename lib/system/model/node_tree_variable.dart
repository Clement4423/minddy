// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'dart:convert';
import 'package:minddy/system/nodes/logic/node_data_models.dart';

/// A [`NodeTreeVariable`] is used for storing values from the tree, and make them accessible for every tree.
/// 
/// 
///  ### Explanation:
/// 
/// When using a plugin, the plugin itself will hold every variable in its memory. 
/// Then, the variables are shared across all [`NodeTree`], and each [`NodeTree`] can modify each variable, 
/// changes that will be available for every [`NodeTree`].
class NodeTreeVariable {
  /// The name of `this` variable
  String name;
  
  /// The type of `this` variable
  NodeDataType type;

  /// The unique id of `this` variable. 
  /// 
  /// Must be unique
  int id;

  /// The value of `this` variable. 
  /// 
  /// Must respect the `type`
  NodeData? value;

  /// Returns a json representation of `this`
  String toJson() {
    return jsonEncode(
      {
        'name': name,
        'type': type.index,
        'id': id
      }
    );
  }

  /// Create a new [`NodeTreeVariable`] from a json string
  static NodeTreeVariable? fromJson(String json) {
    try {
      Map? map = jsonDecode(json);

      if (map != null) {
        String? name = map['name'];

        NodeDataType? type = NodeDataType.values[map['type']];

        int? id = map['id'];

        if (name != null && id != null ) {
          return NodeTreeVariable(name: name, type: type, id: id);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  NodeTreeVariable({required this.name, required this.type, required this.id});
}

