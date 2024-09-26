import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/interface/i_output_node.dart';
import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/boolean_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/comparison_node_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/math_node_widget.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetGraph {
  Map<INodeWidget, List<INodeWidget>> adjacencyList = {};

  void addNode(INodeWidget widget) {
    adjacencyList[widget] = [];
  }

  void addEdge(INodeWidget from, INodeWidget to) {
    adjacencyList[from]?.add(to);
  }

  List<INodeWidget> getNodes() {
    return adjacencyList.keys.toList();
  }

  List<INodeWidget>? getDependencies(INodeWidget widget) {
    return adjacencyList[widget];
  }
}

class NodeWidgetTree {
  List<INodeWidget> nodesWidgets;
  int id;
  String name;

  final NodeWidgetGraph _graph = NodeWidgetGraph();
  INodeWidget? outputNode;

  NodeWidgetTree({required this.nodesWidgets, required this.id, this.name = ''}) {
    for (var widget in nodesWidgets) {
      _graph.addNode(widget);
    }
    _buildGraph();
    
    // Identify the single output node (one with no outgoing edges)
    try {
      outputNode = nodesWidgets.firstWhere(
        (widget) => widget.node is IOutputNode,
        orElse: () {
          return nodesWidgets.firstWhere(
            (widget) => _graph.getDependencies(widget)?.isEmpty ?? true
          );
        }
      );
    } catch (e) {
      outputNode = null;
    }
  }


  String toJson() {
    List<String> nodesWidgetsAsStrings = nodesWidgets.map((widget) => widget.toJson()).toList();
    Map map =  {
      'nodes': nodesWidgetsAsStrings,
      'id': id,
      'name': name
    };
    return jsonEncode(map);
  }

static NodeWidgetTree? fromJson(String string, NodeEditorBottomSheetController controller, StylesGetters theme) {
  Map map = jsonDecode(string);
  Map<int, List<String>> targetsMap = {};
  List<INodeWidget> allNodeWidgets = [];

  var nodesWidgetsAsString = map['nodes'];
  if (nodesWidgetsAsString is List) {
    for (String nodeJson in nodesWidgetsAsString) {
      Map nodeWidgetMap = jsonDecode(nodeJson);
      Map nodeMap = jsonDecode( nodeWidgetMap['node']);
      INodeWidget? nodeWidget = _getCorrectNodeWidgetType(nodeWidgetMap['widget_type'], nodeJson, controller.maxOffset, theme, controller);
      nodeWidget?.position = Offset(nodeWidgetMap['positionX'], nodeWidgetMap['positionY']);
      
      if (nodeWidget != null) {
        targetsMap[nodeWidget.node.id] = convertListToListString(nodeMap['targets'] ?? []);
        allNodeWidgets.add(nodeWidget);
      }
    }

    if (allNodeWidgets.isNotEmpty) {
      for (var widget in allNodeWidgets) {
        controller.globalKeys[widget] = widget.key as GlobalKey? ?? GlobalKey();
        widget.node.targets = INode.initializeTargets(
            allNodeWidgets.map((w) => w.node).toList(), targetsMap, widget.node.id);
      }
      return NodeWidgetTree(nodesWidgets: allNodeWidgets, id: map['id'] ?? createUniqueId(), name: map['name'] ?? '');
    }
  }
  return null;
}

    void _buildGraph() {
    for (var widget in nodesWidgets) {
      for (var target in widget.node.targets) {
        var targetWidget = nodesWidgets.firstWhere((w) => w.node == target.node);
        _graph.addEdge(widget, targetWidget);
      }
    }
  }

  List<INodeWidget> topologicalSort() {
    Map<INodeWidget, bool> visited = {for (var widget in nodesWidgets) widget: false};
    List<INodeWidget> result = [];
    Set<INodeWidget> currentPath = {};

    void dfs(INodeWidget widget) {
      if (currentPath.contains(widget)) {
        throw Exception("Cycle detected in the graph, topological sort not possible");
      }

      if (visited[widget]!) return;

      currentPath.add(widget);
      visited[widget] = true;

      for (var target in widget.node.targets) {
        var targetWidget = nodesWidgets.firstWhere((w) => w.node == target.node);
        if (!visited[targetWidget]!) {
          dfs(targetWidget);
        }
      }

      currentPath.remove(widget);
      result.insert(0, widget);
    }

    for (var widget in nodesWidgets) {
      if (!visited[widget]!) {
        dfs(widget);
      }
    }

    return result;
  }
}

INodeWidget? _getCorrectNodeWidgetType(String type, String json, Offset maxOffset, StylesGetters theme, NodeEditorBottomSheetController controller) {
  GlobalKey key = GlobalKey();
  switch (type) {
    case 'MathNodeWidget':
      return MathNodeWidget.fromJson(key, json, maxOffset, theme, controller.widgetFunctions);
    case 'ComparisonNodeWidget':
      return ComparisonNodeWidget.fromJson(key, json, maxOffset, theme, controller.widgetFunctions);
    case 'BooleanNodeWidget':
      return BooleanNodeWidget.fromJson(key, json, maxOffset, theme, controller.widgetFunctions);
    default:
      return null;
  }
}