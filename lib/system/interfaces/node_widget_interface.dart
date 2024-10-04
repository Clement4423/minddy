// Process to create a new node: 
// -> Create a new class that extends INode, provide inputs types, outputs types, targets and ids, which is automaticly created if not provided -> REALLY IMPORTANT
// -> Create a [main] method that is going to be set as a getter for the execute method, this main method will modify the outputs.
// -> Add it [nodeTypeConstructors] in the node_tree.dart file at line 261.
// -> Create the node widget, that extends INodeWidget.
// -> Add it to [_getCorrectNodeWidgetType] at line 147 in the node_widget_tree.dart file.
// -> Create the [NodeEditorNewNodeSubMenuNodeModel] in the nodes_add_menu_models.dart file, and add it to the asList list.
// -> Test it.

import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/theme/theme.dart';

/// This class is basicly the same as INode, but it extends it to make widgets out of notes
// ignore: must_be_immutable
abstract class INodeWidget extends Widget {
  INodeWidget({super.key});

  /// This represents the position of the node relatively to the board
  late Offset position;
  
  /// This is the node that is represented by the widget
  late INode node;

  /// The width of the widget
  late double width;

  /// The height of the widget
  late double height;

  /// This will contain all the positions of the node inputs port.
  late List<Offset> inputsOffsets;

  /// This will contain all the positions of the node outputs port.
  late List<Offset> outputsOffsets;

  /// This represents the borders that the node can't cross
  late Offset maxOffset;

  /// Theme is used as an argument, so that only one instance of StylesGetters is used by every node.
  late StylesGetters theme;

  late NodeWidgetFunctions functions;
  /// This will return a string representatin of this object  
  String toJson() {
    throw UnimplementedError();
  }

  /// This makes a copy of the current node, by creating a new instance
  INodeWidget copy(GlobalKey newKey) {
    throw UnimplementedError();
  }
  
  /// This will return a INodeWidget Object, recreated from string
  static INodeWidget? fromJson(
    GlobalKey key,
    String json, 
    Offset maxOffset, 
    StylesGetters theme, 
    Function(NodePortInfo? info) setSelectedPort, 
    bool Function() getIsDragging, 
    Function(bool) setIsDragging, 
    Function(NodeConnection) addConnection
  ) {
    throw UnimplementedError();
  }
}


