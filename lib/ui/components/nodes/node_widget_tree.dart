import 'dart:convert';
import 'dart:ui';

import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

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

  final NodeWidgetGraph _graph = NodeWidgetGraph();
  INodeWidget? outputNode;

  NodeWidgetTree({required this.nodesWidgets, required this.id}) {
    for (var widget in nodesWidgets) {
      _graph.addNode(widget);
    }
    _buildGraph();
    
    // Identify the single output node (one with no outgoing edges)
    outputNode = nodesWidgets.firstWhere(
      (widget) => widget.node is IOutputNode,
      orElse: () {
        return nodesWidgets.firstWhere(
          (widget) => _graph.getDependencies(widget)?.isEmpty ?? true,
          orElse: () {return topologicalSort().last;}
        );
      }
    );
    print(outputNode.runtimeType);
  }


  String toJson() {
    List<String> nodesWidgetsAsStrings = nodesWidgets.map((widget) => widget.toJson()).toList();
    Map map =  {
      'nodes': nodesWidgetsAsStrings,
      'id': id
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
        widget.node.targets = INode.initializeTargets(
            allNodeWidgets.map((w) => w.node).toList(), targetsMap, widget.node.id);
      }
      return NodeWidgetTree(nodesWidgets: allNodeWidgets, id: map['id'] ?? createUniqueId());
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
  switch (type) {
    case 'MathNodeWidget':
      return MathNodeWidget.fromJson(json, maxOffset, theme, controller.setSelectedPort, controller.getIsDragging, controller.setIsDragging, controller.addConnection, controller.getSelectedPort, controller.passNodesConnections, controller.nodeConnectionUpdater.notify);
    default:
  }
  return null;
}