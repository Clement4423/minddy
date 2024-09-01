import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class NodeEditorState {
  List<NodeEditorHistoryElement> _history = [];
  int _currentIndex = -1;

  List<NodeEditorHistoryElement> get history => _history;
  int get historyMaxLength => 32;

  void clearHistory() {
    _history.clear();
  }

  NodeEditorHistoryElement? getCurrentState() {
    return _currentIndex >= 0 && _currentIndex < _history.length
        ? _history[_currentIndex]
        : null;
  }

  void addHistoryElement(NodeEditorHistoryElement element) {  
      // If we're not at the end of the history (meaning we've undone), truncate the history
      if (_currentIndex < _history.length - 1) {
          _history = _history.sublist(0, _currentIndex + 1);
      }

      // Add new element to history
      _history.add(element);
      _currentIndex = _history.length - 1;

      // Limit history size
      if (_history.length > historyMaxLength) {
          _history.removeAt(0);
          _currentIndex = _history.length - 1;  // Ensure index is correct after removal
      }
  }

  bool canUndo() {
    return _currentIndex > 0;
  }

  bool canRedo() {
    return _currentIndex < _history.length - 1;
  }

  NodeEditorHistoryElement? undo() {
    if (canUndo()) {
      _currentIndex--;
      return _history[_currentIndex];
    }
    return null;
  }

  NodeEditorHistoryElement? redo() {
    if (canRedo()) {
      _currentIndex++;
      return _history[_currentIndex];
    }
    return null;
  }
}

class NodeEditorHistoryElement {
  final int id;
  final List<INodeWidget> nodes;
  final List<INodeWidget> selectedNodes;

  NodeEditorHistoryElement({required this.nodes, required this.selectedNodes, required this.id});
}

class NodeConnectionUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class NodeEditorBottomSheetController extends ChangeNotifier {

  bool nodeTreeChanged = false;

  NodeConnectionUpdater nodeConnectionUpdater = NodeConnectionUpdater();

  Map<INodeWidget, GlobalKey> globalKeys = {};

  bool isClosed = false;
  bool isSidePanelClosed = false;

  List<NodeEditorBottomSheetView> views;

  final Function save;

  int? selectedNodeTreeId;

  Offset maxOffset;

  TransformationController viewPositionController = TransformationController();

  List<INodeWidget> nodesWidgets = [];

  bool isDragging = false;

  NodePortInfo? selectedPortInfo;
  
  NodeEditorBottomSheetController({this.isClosed = false, required this.views, required this.maxOffset, required this.save}) {
    selectedNodeTreeId = views.firstOrNull?.tree.id;
  }

  bool isInitialized = false;

  initialize(StylesGetters theme) {
    nodesWidgets.clear();

    if (selectedNodeTreeId == null) {
      selectedNodeTreeId = views.firstOrNull?.tree.id;
      if (selectedNodeTreeId == null) {
        addNodeTree();
      }
    }

    if (selectedNodeTreeId != null) {
      NodeEditorBottomSheetView selectedView = views.firstWhere((v) => v.tree.id == selectedNodeTreeId);
      nodesWidgets = selectedView.tree.nodesWidgets;
      viewPositionController = selectedView.viewPositionController;
      globalKeys.clear();

      for (INodeWidget widget in nodesWidgets) {
        globalKeys[widget] = widget.key as GlobalKey;
      }
    }
    isInitialized = true;
  }

  NodeEditorState state = NodeEditorState();

  void saveState() {
    List<INodeWidget> savedNodes = nodesWidgets.map((n) {return n.copy(GlobalKey());}).toList();

    // Here we need to copy the targets, as they are no longer pointing to the correct nodes.
    for (INodeWidget widget in savedNodes) {
      widget.node.targets = widget.node.targets.map((target) {
        return NodeTarget(
          outputIndex: target.outputIndex, 
          node: savedNodes.firstWhere((n) => n.node.id == target.node.id).node, 
          inputIndex: target.inputIndex
        );
      }).toList();
    }

    List<INodeWidget> savedSelectedNodes = [];

    for (INodeWidget node in selectedNodes) {
      var matchingNode = savedNodes.firstWhere((n) => n.node.id == node.node.id);
      savedSelectedNodes.add(matchingNode);
    }

    state.addHistoryElement(
      NodeEditorHistoryElement(
        id: createUniqueId(),
        selectedNodes: savedSelectedNodes,
        nodes: savedNodes,
      )
    );
  }

    void undo(StylesGetters theme) {
      NodeEditorHistoryElement? previousState = state.undo();
      if (previousState != null) {
        _applyState(previousState, theme);
      }
    }

    void redo(StylesGetters theme) {
      NodeEditorHistoryElement? nextState = state.redo();
      if (nextState != null) {
        _applyState(nextState, theme);
      }
    }

  void _applyState(NodeEditorHistoryElement historyElement, StylesGetters theme) {
    globalKeys.clear();
    selectedNodesConnections.clear();
    nodesConnections.clear();

    // Here, we need to create another copy of the nodes, because otherwise, it will modify the nodes in the history
    List<INodeWidget> newNodes = historyElement.nodes.map((n) => n.copy(GlobalKey())).toList();

    for (INodeWidget widget in newNodes) {
      globalKeys[widget] = widget.key as GlobalKey? ?? GlobalKey();
      widget.node.targets = widget.node.targets.map((target) {
        return NodeTarget(
          outputIndex: target.outputIndex, 
          node: newNodes.firstWhere((n) => n.node.id == target.node.id).node, 
          inputIndex: target.inputIndex
        );
      }).toList();
    }

    selectedNodes = historyElement.selectedNodes.map((n) {
      return newNodes.firstWhere((widget) => widget.node.id == n.node.id);
    }).toList();

    nodesWidgets = newNodes;

    for (NodeWidgetTree widgetTree in views.map((v) => v.tree).toList()) {
      if (widgetTree.id == selectedNodeTreeId) {
        widgetTree.nodesWidgets = nodesWidgets;
      }
    } 

    getNodesConnections();
    getSelectedNodesConnections();
    notifyListeners();
  }

  List<INodeWidget> selectedNodes = [];

  List<NodeConnection> selectedNodesConnections = [];

  List<NodeConnection> nodesConnections = [];

  List<INodeWidget> getSelectedNodes() {
    return selectedNodes;
  }

  void setSelectedNode(List<INodeWidget> nodes) {
    List<INodeWidget> nodesToUpdate = List.from(selectedNodes);
    selectedNodes = nodes;
    nodesToUpdate.addAll(selectedNodes);

    getSelectedNodesConnections();
      
    for (INodeWidget widget in nodesWidgets) {
      updateNode(widget);
    }

    saveState();
    nodeConnectionUpdater.notify();
  }

  void updateNode(INodeWidget widget) {
    // ignore: invalid_use_of_protected_member
    globalKeys[widget]?.currentState?.setState(() {});
  }

  void setIsDragging(bool value) {
    isDragging = value;
  }

  bool getIsDragging() {
    return isDragging;
  }

  void setSelectedPort(NodePortInfo? info) {
    selectedPortInfo = info;
    notifyListeners();
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
      return;
    }

    NodeTree? nodeTree = getNodeTreeFromNodeWidgetTree(selectedTree.id);
    if (nodeTree == null) {
      print("Node tree is null");
      return;
    }

    if (firstPort.type == NodePortType.input && selectedPortInfo!.type == NodePortType.output) {
      if (nodeTree.isNodeBefore(firstPort.node.node, selectedPortInfo!.node.node)) {
        print("Node is before");
        return;
      } else {
        NodeTarget targetToAdd = NodeTarget(outputIndex: selectedPortInfo!.portIndex, node: firstPort.node.node, inputIndex: firstPort.portIndex);
        if (_isNodeContainingTarget(selectedPortInfo!.node.node, targetToAdd)) {
          return;
        } else {
          print("Adding input to output");
          selectedPortInfo!.node.node.targets.add(targetToAdd);
        }        
      }
    } else if (firstPort.type == NodePortType.output && selectedPortInfo!.type == NodePortType.input) {
      if (nodeTree.isNodeBefore(selectedPortInfo!.node.node, firstPort.node.node)) {
        print("Node is before");
        return;
      } else {
        NodeTarget targetToAdd = NodeTarget(outputIndex: firstPort.portIndex, node: selectedPortInfo!.node.node, inputIndex: selectedPortInfo!.portIndex);
        if (_isNodeContainingTarget(firstPort.node.node, targetToAdd)) {
          return;
        } else {
          print("Adding output to input");
          firstPort.node.node.targets.add(targetToAdd);
        }
      }
    }
    selectedPortInfo = null;
    getNodesConnections();
    getSelectedNodesConnections();
    nodeConnectionUpdater.notify();
    saveState();
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
    MathNodeWidget nodeA = MathNodeWidget(key: GlobalKey(), node: MathNode(), position: const Offset(100, 100), maxOffset: maxOffset, theme: theme, saveState: saveState, setSelectedNode: setSelectedNode, getSelectedNodes: getSelectedNodes, getIsDragging: getIsDragging, getConnections: passNodesConnections, setSelectedPort: setSelectedPort, getSelectedPort: getSelectedPort, setIsDragging: setIsDragging, addConnection: addConnection, updateConnections: nodeConnectionUpdater.notify, updateNode: updateNode);
    MathNodeWidget nodeB = MathNodeWidget(key: GlobalKey(), node: MathNode(), position: const Offset(300, 100), maxOffset: maxOffset, theme: theme, saveState: saveState, setSelectedNode: setSelectedNode, getSelectedNodes: getSelectedNodes, getIsDragging: getIsDragging, getConnections: passNodesConnections, setSelectedPort: setSelectedPort, getSelectedPort: getSelectedPort, setIsDragging: setIsDragging, addConnection: addConnection, updateConnections: nodeConnectionUpdater.notify, updateNode: updateNode);

    nodeA.node.targets.add(NodeTarget(outputIndex: 0, node: nodeB.node, inputIndex: 0));

    nodesWidgets = [nodeA, nodeB];

    globalKeys.clear();

    for (INodeWidget widget in nodesWidgets) {
      globalKeys[widget] = widget.key as GlobalKey;
    }

    getSelectedNodeWidgetTree()!.nodesWidgets = nodesWidgets;
  }

  void setSelectedNodeTree(int id, [bool refresh = true]) {
    if (id != selectedNodeTreeId) {
      nodeTreeChanged = true;
    }

    views.firstWhere((v) => v.tree.id == selectedNodeTreeId).tree.nodesWidgets = nodesWidgets.map((n) => n.copy(GlobalKey())).toList();

    selectedNodeTreeId = id;

    viewPositionController = views.firstWhere((v) => v.tree.id == id).viewPositionController;

    if (refresh) {
      notifyListeners();
    }
  }

  void addNodeTree() {
    views.add(
      NodeEditorBottomSheetView(
        tree: NodeWidgetTree(nodesWidgets: [], id: createUniqueId()), 
        viewPositionController: TransformationController()
      )
    );
    setSelectedNodeTree(views.last.tree.id, false);
    notifyListeners();
  }

  void deleteNodeTree(int id) {
    try {
      if (views.length == 1) {
        return;
      }

      NodeEditorBottomSheetView treeToRemove = views.firstWhere((v) => v.tree.id == id);
      
      views.remove(treeToRemove);

      if (selectedNodeTreeId == id) {
        setSelectedNodeTree(views.last.tree.id, false);
      }

      notifyListeners();
    } catch (e) {
      return;
    }
  }

  List<NodeConnection> passNodesConnections() {
    return nodesConnections;
  }

  void getSelectedNodesConnections() {
    selectedNodesConnections = nodesConnections.where(
      (connection) {
        return selectedNodes.contains(connection.startNode) || selectedNodes.contains(connection.endNode);
      }).toList();
  }

  void getNodesConnections() {
    try {
      List<NodeConnection> connections = [];

      for (int i = 0; i < nodesWidgets.length; i++) {
        for (NodeTarget target in nodesWidgets[i].node.targets) {
          INodeWidget? targetWidget = _getNodeWidgetFromId(target.node.id);
          if (targetWidget != null) {
            connections.add(
              NodeConnection(
                nodesWidgets[i], 
                target.outputIndex, 
                targetWidget, 
                target.inputIndex
              )
            );
          }
        }
      }

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
      return views.firstWhere((v) => v.tree.id == selectedNodeTreeId).tree;
    } catch (e) {
      return null;
    }
  }

  NodeTree? getNodeTreeFromNodeWidgetTree(int id) {
    try {
      NodeWidgetTree widgetTree = views.firstWhere((v) => v.tree.id == id).tree;

      List<INode> nodes = [];

      for (INodeWidget widget in widgetTree.nodesWidgets) {
        nodes.add(widget.node);
      }

      return NodeTree(nodes: nodes, id: createUniqueId());
    } catch (e) {
      return null;
    }
   
  }

  void setIsSidePanelClosed(bool value) {
    isSidePanelClosed = value;
  }

  String toJson() {
    List<String> widgetsAsStrings = [];
    for (INodeWidget widget in nodesWidgets) {
      widgetsAsStrings.add(widget.toJson());
    }
    
    Map<String, dynamic> map = {
      'views': views.map((v) => v.toJson()).toList(),
      'selected_node_tree_id': selectedNodeTreeId,
      'isSidePanelClosed': isSidePanelClosed
    };

    return jsonEncode(map);
  }

  static NodeEditorBottomSheetController? fromJson(Map<String, dynamic> map, Offset maxOffset, StylesGetters theme, Function save) {
    try {
      List<NodeEditorBottomSheetView> views = [];

      NodeEditorBottomSheetController controller = NodeEditorBottomSheetController(views: [], maxOffset: maxOffset, save: save);

      if (map['views'] is List) {
        for (String viewAsJson in map['views']) {
          NodeEditorBottomSheetView? view = NodeEditorBottomSheetView.fromJson(viewAsJson, controller, theme);
          if (view != null) {
            views.add(view);
          }
        }
      }

      controller.views = views;

      if (map['isSidePanelClosed'] != null && map['isSidePanelClosed'] is bool) {
        controller.isSidePanelClosed = map['isSidePanelClosed'];
      }

      if (map['selected_node_tree_id'] != null) {
        controller.selectedNodeTreeId = int.tryParse(map['selected_node_tree_id'].toString());
      } 

      return controller;
    } catch (e, s) {
      print("ERROR $e, \n stack trace: $s");
      return null;
    }
  }
}

class NodeEditorBottomSheetView {
  NodeWidgetTree tree;
  TransformationController viewPositionController;

  NodeEditorBottomSheetView({required this.tree, required this.viewPositionController});

  String toJson() {
    return jsonEncode({
      'tree': tree.toJson(),
      'view_transformations': jsonEncode(viewPositionController.value.storage)
    });
  }

  static NodeEditorBottomSheetView? fromJson(String json, NodeEditorBottomSheetController controller, StylesGetters theme) {
    Map map = jsonDecode(json);

    if (map['tree'] != null) {
      NodeWidgetTree? tree = NodeWidgetTree.fromJson(map['tree'], controller, theme);

      if (map['view_transformations'] != null) {
        List<dynamic> transformationList = jsonDecode(map['view_transformations']);

        for (var element in transformationList) {
          double.tryParse(element.toString()) ?? 0;
        }

        List<double> transformationListAsDoubles = List.from(transformationList);

        TransformationController transformationController = TransformationController();

        transformationController.value = Matrix4.fromList(transformationListAsDoubles);

        if (tree != null) {
          return NodeEditorBottomSheetView(tree: tree, viewPositionController: transformationController);
        }
      }
    }
    return null;
  }
}