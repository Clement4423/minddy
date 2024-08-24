import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class NodeConnectionUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class NodePortInfo {
  NodePortType type;
  INodeWidget node;
  int portIndex;

  NodePortInfo({required this.node, required this.type, required this.portIndex});
}

class NodeEditorBottomSheetController extends ChangeNotifier {

  NodeConnectionUpdater nodeConnectionUpdater = NodeConnectionUpdater();

  bool isClosed = false;

  List<NodeWidgetTree> nodeTrees;

  final Function save;

  int? selectedNodeTreeId;

  Offset maxOffset;

  TransformationController viewPositionController = TransformationController();

  List<INodeWidget> nodesWidgets = [];

  bool isDragging = false;

  NodePortInfo? selectedPortInfo;
  
  NodeEditorBottomSheetController({this.isClosed = false, required this.nodeTrees, required this.maxOffset, required this.save}) {
    selectedNodeTreeId = nodeTrees.firstOrNull?.id;
  }

  bool isInitialized = false;

  initialize(StylesGetters theme) {
    nodesWidgets.clear();

    if (selectedNodeTreeId == null) {
      selectedNodeTreeId = nodeTrees.firstOrNull?.id;
      if (selectedNodeTreeId == null) {
        addTree(theme);
      }
    }

    if (selectedNodeTreeId != null) {
      NodeWidgetTree selectedTree = nodeTrees.firstWhere((tree) => tree.id == selectedNodeTreeId);
      nodesWidgets = selectedTree.nodesWidgets;
    }
    isInitialized = true;
  }

  void setIsDragging(bool value) {
    isDragging = value;
  }

  bool getIsDragging() {
    return isDragging;
  }

  void setSelectedPort(NodePortInfo? info) {
    selectedPortInfo = info;
  }

  NodePortInfo? getSelectedPort() {
    return selectedPortInfo;
  }

  Future<void> addConnection(NodePortInfo firstPort) async {
    if (selectedPortInfo == null || firstPort.type == selectedPortInfo?.type) {
      print("Same type: $selectedPortInfo");
      return;
    }

    if (selectedPortInfo!.node == firstPort.node) {
      print("Same node");
      return;
    }

    NodeWidgetTree? selectedTree = getSelectedNodeWidgetTree();
    if (selectedTree == null) {
      print("Selected tree is null");
      notifyListeners();
      return;
    }

    NodeTree? nodeTree = getNodeTreeFromNodeWidgetTree(selectedTree.id);
    if (nodeTree == null) {
      print("Node tree is null");
      notifyListeners();
      return;
    }

    if (firstPort.type == NodePortType.input && selectedPortInfo!.type == NodePortType.output) {
      if (nodeTree.isNodeBefore(firstPort.node.node, selectedPortInfo!.node.node)) {
        print("Node is before");
        notifyListeners();
        return;
      } else {
        NodeTarget targetToAdd = NodeTarget(outputIndex: selectedPortInfo!.portIndex, node: firstPort.node.node, inputIndex: firstPort.portIndex);
        if (_isNodeContainingTarget(selectedPortInfo!.node.node, targetToAdd)) {
          return;
        } else {
          selectedPortInfo!.node.node.targets.add(targetToAdd);
        }
        print("Adding input to output");
        
      }
    } else if (firstPort.type == NodePortType.output && selectedPortInfo!.type == NodePortType.input) {
      if (nodeTree.isNodeBefore(selectedPortInfo!.node.node, firstPort.node.node)) {
        print("Node is before");
        return;
      } else {
        NodeTarget targetToAdd = NodeTarget(outputIndex: firstPort.portIndex, node: selectedPortInfo!.node.node, inputIndex: selectedPortInfo!.portIndex);
        print("Adding output to input");
        if (_isNodeContainingTarget(firstPort.node.node, targetToAdd)) {
          return;
        } else {
          firstPort.node.node.targets.add(targetToAdd);
        }
      }
    }
    notifyListeners();
  }

  bool _isNodeContainingTarget(INode node, NodeTarget target) {
    if (node.targets.map(
      (t) => 
      t.node.id == target.node.id &&
      t.inputIndex == target.inputIndex && 
      t.outputIndex == target.outputIndex
    ).toList().contains(true)) {
      print("Node already contains target");
      return true;
    } else {
      return false;
    }
  }

  eraseNodesWidgets(StylesGetters theme) {
    MathNodeWidget nodeA = MathNodeWidget(node: MathNode(), position: Offset(100, 100), maxOffset: maxOffset, theme: theme, getIsDragging: getIsDragging, getConnections: passNodesConnections, setSelectedPort: setSelectedPort, getSelectedPort: getSelectedPort, setIsDragging: setIsDragging, addConnection: addConnection, updateConnections: nodeConnectionUpdater.notify);
    MathNodeWidget nodeB = MathNodeWidget(node: MathNode(), position: Offset(300, 100), maxOffset: maxOffset, theme: theme, getIsDragging: getIsDragging, getConnections: passNodesConnections, setSelectedPort: setSelectedPort, getSelectedPort: getSelectedPort, setIsDragging: setIsDragging, addConnection: addConnection, updateConnections: nodeConnectionUpdater.notify);

    nodeA.node.targets.add(NodeTarget(outputIndex: 0, node: nodeB.node, inputIndex: 0));

    nodesWidgets = [nodeA, nodeB];
    getSelectedNodeWidgetTree()!.nodesWidgets = nodesWidgets;
  }

  void addTree(StylesGetters theme) {
    nodeTrees.add(NodeWidgetTree(nodesWidgets: [MathNodeWidget(node: MathNode(), theme: theme, setIsDragging: setIsDragging, updateConnections: nodeConnectionUpdater.notify, getConnections: passNodesConnections, getIsDragging: getIsDragging, setSelectedPort: setSelectedPort, addConnection: addConnection, getSelectedPort: getSelectedPort, position: const Offset(100, 100), maxOffset: maxOffset)], id: createUniqueId()));
    selectedNodeTreeId = nodeTrees.last.id;
  }

  List<NodeConnection> nodesConnections = [];

  List<NodeConnection> passNodesConnections() {
    return nodesConnections;
  }

  void getNodesConnections() {
    try {
      NodeWidgetTree? tree = getSelectedNodeWidgetTree();

      if (tree == null) {
        print("Tree is null");
        return;
      }

      List<INodeWidget> sortedNodes = tree.topologicalSort();

      List<NodeConnection> connections = [];

      print("Nodes: ${sortedNodes.length}");

      for (int i = 0; i < sortedNodes.length; i++) {
        print("Targets ${sortedNodes[i].node.targets.length}");
        for (NodeTarget target in sortedNodes[i].node.targets) {
          INodeWidget? targetWidget = _getNodeWidgetFromId(target.node.id);
          if (targetWidget != null) {
            connections.add(
              NodeConnection(
                sortedNodes[i], 
                target.outputIndex, 
                targetWidget, 
                target.inputIndex
              )
            );
          }
        }
      }

      print("Connections found: ${connections.length}");
      nodesConnections = connections;
    } catch (e) {
      return;
    }
  }

  INodeWidget? _getNodeWidgetFromId(int id) {
    try {
      return nodesWidgets.firstWhere((widget) => widget.node.id == id);
    } catch (e) {
      return null;
    }
  }

  NodeWidgetTree? getSelectedNodeWidgetTree() {
    try {
      if (selectedNodeTreeId == null) {
        return null;
      }
      return nodeTrees.firstWhere((tree) => tree.id == selectedNodeTreeId);
    } catch (e) {
      return null;
    }
  }

  NodeTree? getNodeTreeFromNodeWidgetTree(int id) {
    try {
      NodeWidgetTree widgetTree = nodeTrees.firstWhere((tree) => tree.id == id);

      List<INode> nodes = [];

      for (INodeWidget widget in widgetTree.nodesWidgets) {
        nodes.add(widget.node);
      }

      return NodeTree(nodes: nodes, id: createUniqueId());
    } catch (e) {
      return null;
    }
   
  }

  String toJson() {
    List<String> widgetsAsStrings = [];
    for (INodeWidget widget in nodesWidgets) {
      widgetsAsStrings.add(widget.toJson());
    }
    
    Map<String, dynamic> map = {
      'node_trees': nodeTrees.map((tree) => tree.toJson()).toList(),
      'selected_node_tree': selectedNodeTreeId,
      'view_transformations': jsonEncode(viewPositionController.value.storage),
    };

    return jsonEncode(map);
  }

  static NodeEditorBottomSheetController? fromJson(Map<String, dynamic> map, Offset maxOffset, StylesGetters theme, Function save) {
  try {
    print(map.runtimeType);
    List<NodeWidgetTree> trees = [];

    NodeEditorBottomSheetController controller = NodeEditorBottomSheetController(nodeTrees: [], maxOffset: maxOffset, save: save);

    if (map['node_trees'] is List) {
      for (String nodeTreeAsJson in map['node_trees']) {
        print(nodeTreeAsJson.runtimeType);
        NodeWidgetTree? tree = NodeWidgetTree.fromJson(nodeTreeAsJson, controller, theme);
        if (tree != null) {
          trees.add(tree);
        }
      }
    }

    controller.nodeTrees = trees;

    // Deserialize and apply the view transformations
    if (map['view_transformations'] != null) {
      List<dynamic> transformationList = jsonDecode(map['view_transformations']);

      for (var element in transformationList) {
        double.tryParse(element.toString()) ?? 0;
      }

      List<double> transformationListAsDoubles = List.from(transformationList);

      controller.viewPositionController.value = Matrix4.fromList(transformationListAsDoubles);
    }

    return controller;
  } catch (e) {
    return null;
  }
}
}