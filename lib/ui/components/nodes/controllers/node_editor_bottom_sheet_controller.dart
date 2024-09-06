import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/nodes/nodes_add_menu_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_state.dart';
import 'package:minddy/ui/components/nodes/node_editor_show_node_add_menu.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class NodeConnectionUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class BottomToolbarUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class NodeEditorBottomSheetController extends ChangeNotifier {

  late NodesAddMenuModels nodes = NodesAddMenuModels(functions: widgetFunctions, maxOffset: maxOffset, theme: StylesGetters(context));
  late NodeWidgetFunctions widgetFunctions;
  late BuildContext context;

  bool nodeTreeChanged = false;

  NodeConnectionUpdater nodeConnectionUpdater = NodeConnectionUpdater();
  BottomToolbarUpdater bottomToolbarUpdater = BottomToolbarUpdater();

  Map<INodeWidget, GlobalKey> globalKeys = {};

  bool isClosed = false;
  bool isSidePanelClosed = false;

  List<NodeEditorBottomSheetView> views;

  final Function save;

  int? selectedNodeTreeId;

  Offset maxOffset;

  TransformationController viewPositionController = TransformationController();

  List<INodeWidget> nodesWidgets = [];

  List<NodeTreeVariable> variables = [];

  bool isDragging = false;

  NodePortInfo? selectedPortInfo;
  
  NodeEditorBottomSheetController({this.isClosed = false, required this.views, required this.maxOffset, required this.save}) {
    selectedNodeTreeId = views.firstOrNull?.tree.id;
    widgetFunctions = NodeWidgetFunctions(
      getIsDragging: getIsDragging, 
      setIsDragging: setIsDragging, 
      addConnection: addConnection, 
      setSelectedPort: setSelectedPort, 
      getSelectedPort: getSelectedPort, 
      getConnections: passNodesConnections, 
      getSelectedNodes: getSelectedNodes, 
      setSelectedNode: setSelectedNode, 
      updateNode: updateNode, 
      updateConnections: nodeConnectionUpdater.notify,
      saveState: saveState
    );
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
      if (views.isEmpty) {
        views.add(
          NodeEditorBottomSheetView(
            tree: NodeWidgetTree(nodesWidgets: [], id: createUniqueId()), 
            viewPositionController: TransformationController(), 
            state: NodeEditorState()
          )
        );
      }
      NodeEditorBottomSheetView selectedView = views.firstWhere((v) => v.tree.id == selectedNodeTreeId);
      nodesWidgets = selectedView.tree.nodesWidgets;
      viewPositionController = selectedView.viewPositionController;
      selectedNodes = selectedView.selectedNodes;
      globalKeys.clear();

      for (INodeWidget widget in nodesWidgets) {
        globalKeys[widget] = widget.key as GlobalKey;
      }
    }
    isInitialized = true;
  }

  NodeEditorState state = NodeEditorState();

  List<INodeWidget> copiedNodes = [];

  void copySelectedNodes() {
    List<INodeWidget> nodesToCopy = [];
    for (INodeWidget widget in selectedNodes) {
      nodesToCopy.add(widget.copy(GlobalKey()));
      nodesToCopy.last.node.targets = [];
    }
    copiedNodes.clear();
    copiedNodes.addAll(nodesToCopy);
    bottomToolbarUpdater.notify();
  }

  void pasteCopiedNodes() {
    List<INodeWidget> nodesToPaste = List.from(copiedNodes);

    for (INodeWidget widget in nodesToPaste) {
      globalKeys[widget] = widget.key as GlobalKey;
      widget.node.id = createUniqueId(); // Redefine a new id otherwise deleting the original node will delete the copy
      Offset offsetToAdd = const Offset(25, 25);
      if (widget.position + Offset(widget.width, widget.height) >= widget.maxOffset) {
        widget.position -= offsetToAdd;
      } else {
        widget.position += offsetToAdd;
      }
      
    }

    List<INodeWidget> nodesToUpdate = List.from(selectedNodes);

    nodesToUpdate.addAll(nodesToPaste);

    selectedNodes.clear();
    selectedNodesConnections.clear();

    selectedNodes.addAll(nodesToPaste);

    for (INodeWidget widget in nodesToUpdate) {
      updateNode(widget);
    }

    nodesWidgets.addAll(nodesToPaste);
    saveState();
    nodeConnectionUpdater.notify();
    notifyListeners();
  }

  void deleteSelectedNodes() {
    try {
      for (INodeWidget widget in selectedNodes) {
        nodesWidgets.removeWhere((w) => w.node.id == widget.node.id);
        globalKeys.removeWhere((w, k) => w.node.id == widget.node.id);
      }

      selectedNodes.clear();
      selectedNodesConnections.clear();

      for (NodeWidgetTree widgetTree in views.map((v) => v.tree).toList()) {
        if (widgetTree.id == selectedNodeTreeId) {
          widgetTree.nodesWidgets = nodesWidgets;
        }
      }

      nodeConnectionUpdater.notify();
      bottomToolbarUpdater.notify();
      saveState();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  INodeWidget? addNode(INodeWidget? nodeToAdd, [bool changePosition = false]) {
    if (nodeToAdd == null) {
      return null;
    }

    if (changePosition) {
      nodeToAdd.position = calculateCenterOffset() - Offset(nodeToAdd.width / 2, nodeToAdd.height / 2);
    }


    nodesWidgets.add(nodeToAdd);

    List<INodeWidget> nodesToUpdate = List.from(selectedNodes);

    selectedNodes.clear();

    selectedNodes.add(nodeToAdd);

    for (NodeWidgetTree widgetTree in views.map((v) => v.tree).toList()) {
      if (widgetTree.id == selectedNodeTreeId) {
        widgetTree.nodesWidgets = nodesWidgets;
      }
    }

    globalKeys[nodeToAdd] = nodeToAdd.key as GlobalKey;

    for (INodeWidget widget in nodesToUpdate) {
      updateNode(widget);
    }

    nodeConnectionUpdater.notify();
    bottomToolbarUpdater.notify();
    saveState();
    notifyListeners();
    return nodeToAdd;
  }

  void saveState() {
    List<INodeWidget> savedNodes = nodesWidgets.map((n) {return n.copy(GlobalKey());}).toList();

    // Here we need to copy the targets, as they are no longer pointing to the correct nodes.
    for (INodeWidget widget in savedNodes) {
      try {
        widget.node.targets = widget.node.targets.map((target) {
        return NodeTarget(
          outputIndex: target.outputIndex, 
          node: savedNodes.firstWhere((n) => n.node.id == target.node.id).node, 
          inputIndex: target.inputIndex
        );
      }).toList();
      } catch (e) {
        return;
      }
    }

    List<INodeWidget> savedSelectedNodes = [];

    for (INodeWidget node in selectedNodes) {
      try {
        var matchingNode = savedNodes.firstWhere((n) => n.node.id == node.node.id);
        savedSelectedNodes.add(matchingNode);
      } catch (e) {
        break;
      }
    }

    state.addHistoryElement(
      NodeEditorHistoryElement(
        id: createUniqueId(),
        selectedNodes: savedSelectedNodes,
        nodes: savedNodes,
      )
    );
  }

    void undo() {
      NodeEditorHistoryElement? previousState = state.undo();
      if (previousState != null) {
        _applyState(previousState);
      }
      bottomToolbarUpdater.notify();
    }

    void redo() {
      NodeEditorHistoryElement? nextState = state.redo();
      if (nextState != null) {
        _applyState(nextState);
      }
      bottomToolbarUpdater.notify();
    }

  void _applyState(NodeEditorHistoryElement historyElement) {
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

  void addNodeTreeVariable(NodeTreeVariable variable) {
    variables.add(variable);
    notifyListeners();
  }

  void deleteNodeTreeVariable(int id) {
    try {
      variables.removeWhere((v) => v.id == id);
      notifyListeners();
    } catch (e) {
      return;
    }
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
    bottomToolbarUpdater.notify();
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

  Offset calculateCenterOffset() {
    final Matrix4 matrix = viewPositionController.value;
    final Offset translation = Offset(matrix.getTranslation().x, matrix.getTranslation().y);
    final double scale = matrix.getMaxScaleOnAxis();

    // Calculate the center of the viewport in the coordinate system of the child
    final Size viewportSize = MediaQuery.of(context).size;
    final Offset viewportCenter = Offset(viewportSize.width / 2, (viewportSize.height / 1.8) / 2);
    
    // Transform the viewport center to the child's coordinate system
    final Offset centerInChildCoords = (viewportCenter - translation) / scale;

    return centerInChildCoords;
  }

  Future<void> addConnection(NodePortInfo firstPort, [Offset? cursorPosition]) async {
    print("Received pointer position: $cursorPosition");
    if (selectedPortInfo == null) {
      if (firstPort.type == NodePortType.input) {
        INodeWidget? nodeToAdd = await showNodeEditorAddMenu(context, nodes.asList, StylesGetters(context), (n) {}, true);
        if (nodeToAdd != null) {
          if (cursorPosition != null) {
            nodeToAdd.position = cursorPosition - Offset(nodeToAdd.width / 2, nodeToAdd.height / 2);
          } 
          nodeToAdd.node.targets.add(
            NodeTarget(
              outputIndex: nodeToAdd.node.outputsTypes.indexOf(firstPort.node.node.inputsTypes.elementAt(firstPort.portIndex)), 
              node: firstPort.node.node, 
              inputIndex: firstPort.portIndex
            )
          );
          addNode(nodeToAdd);
        }
      } else {
        INodeWidget? nodeToAdd = await showNodeEditorAddMenu(context, [nodes.mathNode], StylesGetters(context), (n) {}, true);
        if (nodeToAdd != null) {
          if (cursorPosition != null) {
            nodeToAdd.position = cursorPosition - Offset(nodeToAdd.width / 2, nodeToAdd.height / 2);
          } 
          firstPort.node.node.targets.add(
            NodeTarget(
              outputIndex: firstPort.portIndex, 
              node: nodeToAdd.node, 
              inputIndex: nodeToAdd.node.outputsTypes.indexOf(firstPort.node.node.inputsTypes.elementAt(firstPort.portIndex))
            )
          );
          addNode(nodeToAdd);
        }
      }
      return;
    }

    if (firstPort.type == selectedPortInfo?.type) {
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
        INodeWidget? nodeThatAlreadyContainsThisTarget = _isNodesContainingTarget(targetToAdd);
        if (nodeThatAlreadyContainsThisTarget != null) {
          nodeThatAlreadyContainsThisTarget.node.targets.removeWhere((t) => 
            t.node.id == targetToAdd.node.id && 
            t.inputIndex == targetToAdd.inputIndex && 
            t.outputIndex == targetToAdd.outputIndex
          );
        }
        print("Adding input to output");
        selectedPortInfo!.node.node.targets.add(targetToAdd);
      }
    } else if (firstPort.type == NodePortType.output && selectedPortInfo!.type == NodePortType.input) {
      if (nodeTree.isNodeBefore(selectedPortInfo!.node.node, firstPort.node.node)) {
        print("Node is before");
        return;
      } else {
        NodeTarget targetToAdd = NodeTarget(outputIndex: firstPort.portIndex, node: selectedPortInfo!.node.node, inputIndex: selectedPortInfo!.portIndex);
        INodeWidget? nodeThatAlreadyContainsThisTarget = _isNodesContainingTarget(targetToAdd);
        if (nodeThatAlreadyContainsThisTarget != null) {
          nodeThatAlreadyContainsThisTarget.node.targets.removeWhere((t) => 
            t.node.id == targetToAdd.node.id && 
            t.inputIndex == targetToAdd.inputIndex && 
            t.outputIndex == targetToAdd.outputIndex
          );
        }
        print("Adding output to input");
        firstPort.node.node.targets.add(targetToAdd);
      }
    }

    selectedPortInfo = null;
    getNodesConnections();
    getSelectedNodesConnections();
    nodeConnectionUpdater.notify();
    saveState();
  }

  INodeWidget? _isNodesContainingTarget(NodeTarget target) {
    for (INodeWidget widget in nodesWidgets) {
      if (widget.node.targets.map(
        (t) => 
        t.node.id == target.node.id &&
        t.inputIndex == target.inputIndex && 
        t.outputIndex == target.outputIndex
      ).toList().contains(true)) {
        print("Nodes already contains target");
        return widget;
      }
    }
    return null;
  }

  eraseNodesWidgets(StylesGetters theme) {
    MathNodeWidget nodeA = MathNodeWidget(key: GlobalKey(), node: MathNode(), position: const Offset(100, 100), maxOffset: maxOffset, theme: theme, functions: widgetFunctions);
    MathNodeWidget nodeB = MathNodeWidget(key: GlobalKey(), node: MathNode(), position: const Offset(300, 100), maxOffset: maxOffset, theme: theme, functions: widgetFunctions);

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

    if (views.isNotEmpty) {
      try {
        NodeEditorBottomSheetView previousView = views.firstWhere((v) => v.tree.id == selectedNodeTreeId);
        previousView.tree.nodesWidgets = nodesWidgets.map((n) => n.copy(GlobalKey())).toList();
        previousView.selectedNodes = previousView.tree.nodesWidgets.where(
          (w) => selectedNodes.map(
            (e) => e.node.id
          ).toList().contains(w.node.id)
        ).toList();

        NodeEditorBottomSheetView selectedView = views.firstWhere((v) => v.tree.id == id);
        viewPositionController = selectedView.viewPositionController;
        state = selectedView.state;
      } catch (e) {
        null; 
      }
    }
    
    selectedNodeTreeId = id;

    if (refresh) {
      notifyListeners();
    }
  }

  void addNodeTree() {
    views.add(
      NodeEditorBottomSheetView(
        tree: NodeWidgetTree(nodesWidgets: [], id: createUniqueId()), 
        viewPositionController: TransformationController(),
        state: NodeEditorState()
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

      return NodeTree(nodes: nodes, id: createUniqueId(), variables: variables);
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
      'variables': variables.map((v) => v.toJson()).toList(),
      'selected_node_tree_id': selectedNodeTreeId,
      'isSidePanelClosed': isSidePanelClosed
    };

    return jsonEncode(map);
  }

  static NodeEditorBottomSheetController? fromJson(Map<String, dynamic> map, Offset maxOffset, StylesGetters theme, Function save) {
    try {
      NodeEditorBottomSheetController controller = NodeEditorBottomSheetController(views: [], maxOffset: maxOffset, save: save);
      
      List<NodeEditorBottomSheetView> views = [];

      if (map['views'] is List) {
        for (String viewAsJson in map['views']) {
          NodeEditorBottomSheetView? view = NodeEditorBottomSheetView.fromJson(viewAsJson, controller, theme);
          if (view != null) {
            views.add(view);
          }
        }
      }

      controller.views = views;

      List<NodeTreeVariable> variables = [];

      if (map['variables'] is List) {
        for (String variableAsJson in map['variables']) {
          NodeTreeVariable? variable = NodeTreeVariable.fromJson(variableAsJson);
          if (variable != null) {
            variables.add(variable);
          }
        }
      }

      controller.variables = variables;

      if (map['isSidePanelClosed'] != null && map['isSidePanelClosed'] is bool) {
        controller.isSidePanelClosed = map['isSidePanelClosed'];
      }

      if (map['selected_node_tree_id'] != null) {
        controller.selectedNodeTreeId = int.tryParse(map['selected_node_tree_id'].toString());
      } 

      return controller;
    } catch (e) {
      return null;
    }
  }
}

class NodeEditorBottomSheetView {
  NodeWidgetTree tree;
  List<INodeWidget> selectedNodes = [];
  NodeEditorState state;
  TransformationController viewPositionController;

  NodeEditorBottomSheetView({required this.tree, required this.viewPositionController, required this.state});

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
          return NodeEditorBottomSheetView(tree: tree, viewPositionController: transformationController, state: NodeEditorState());
        }
      }
    }
    return null;
  }
}