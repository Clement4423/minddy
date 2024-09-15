import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/nodes/all_nodes/boolean_node.dart';
import 'package:minddy/system/nodes/all_nodes/comparison_node.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/all_nodes/outputs_nodes/boolean_output_node.dart';
import 'package:minddy/system/nodes/all_nodes/outputs_nodes/number_output_node.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';

class NodeGraph {
  Map<INode, List<INode>> adjacencyList = {};

  void addNode(INode node) {
    adjacencyList[node] = [];
  }

  void addEdge(INode from, INode to) {
    adjacencyList[from]?.add(to);
  }

  List<INode> getNodes() {
    return adjacencyList.keys.toList();
  }

  List<INode>? getDependencies(INode node) {
    return adjacencyList[node];
  }
}

class NodeTree {
  List<INode> nodes;
  final int id;
  List<INode> originalNodes = [];
  final NodeGraph _graph = NodeGraph();
  INode? outputNode;

  List<NodeTreeVariable> variables;

  NodeTree({required this.nodes, required this.variables, required this.id}) {
    originalNodes = nodes.map((node) => node.copy()).toList();
    for (var node in nodes) {
      _graph.addNode(node);
    }
    _buildGraph();

    // Identify the single output node (one with no outgoing edges)
    outputNode = nodes.firstWhere(
      (node) => node is IOutputNode,
      orElse: () {
        return nodes.firstWhere(
          (node) => _graph.getDependencies(node)?.isEmpty ?? true,
          orElse: () {return topologicalSort().last;}
        );
      }
    );
  }


  Future<NodeData?> run() async {
    List<INode> sortedNodes = topologicalSort();

    print(sortedNodes.length);

    // Ensure the output node is executed last
    if (outputNode != null) {
      sortedNodes.remove(outputNode);
      sortedNodes.add(outputNode!);
    }

    for (int i = 0; i < sortedNodes.length; i++) {

      await sortedNodes[i].execute();

      if (i < sortedNodes.length - 1) {
        _addDataToNextNode(sortedNodes, i);
      } else if (i == sortedNodes.length - 1) {
        if (outputNode != null) {
          if (outputNode is IOutputNode) {
            IOutputNode lastNode = outputNode as IOutputNode;
            print(lastNode.toJson());
            return await lastNode.getResult();
          }
        }
      }
    }

    return null;
  }

  bool isNodeBefore(INode first, INode second) {
    if (first.targets.isEmpty && second.targets.isEmpty || first.targets.isEmpty) {
      return false;
    }

    List<INode> sortedNodes = topologicalSort();

    int firstIndex = sortedNodes.indexOf(first);
    int secondIndex = sortedNodes.indexOf(second);

    if (firstIndex == -1 || secondIndex == -1) {
      return true;
    }

    return firstIndex < secondIndex;
  }

  void _addDataToNextNode(List<INode> sortedNodes, int index) {
    INode currentNode = sortedNodes[index];

    for (var target in currentNode.targets) {
      INode nextNode = target.node;

      // Ensure the target node's inputs list is large enough to accommodate all incoming connections
      if (nextNode.inputs.length < nextNode.inputsTypes.length) {
        nextNode.inputs = List.generate(nextNode.inputsTypes.length, (i) {
          NodeDataType type = nextNode.inputsTypes[i];
          return NodeData(type: type, value: getDefaultNodeDataTypeValue(type));
        });
      }


      // Find the matching output in the current node for the target node and input index
      try {
        NodeOutput matchingOutput = currentNode.outputs.firstWhere((output) =>
            output.target == nextNode && output.inputIndex == target.inputIndex);

        print(matchingOutput);

        // Set the data to the correct input index of the next node
        if (target.inputIndex < nextNode.inputsTypes.length) {
          nextNode.inputs[target.inputIndex] = matchingOutput.data;
        }
      } catch (e) {
        return;
      }
    }
  }

  @protected
  void _buildGraph() {
    for (var node in nodes) {
      for (var target in node.targets) {
        _graph.addEdge(node, target.node);
      }
    }
  }

  List<INode> topologicalSort() {
    Map<INode, bool> visited = {for (var node in nodes) node: false};
    List<INode> result = [];
    Set<INode> currentPath = {};

    void dfs(INode node) {
      if (currentPath.contains(node)) {
        throw Exception("Cycle detected in the graph, topological sort not possible");
      }

      bool isVisited = visited[node] ?? false;

      if (isVisited) return;

      currentPath.add(node);
      visited[node] = true;

      for (var target in node.targets) {
        bool isVisited = visited[target.node] ?? false;
        if (!isVisited) {
          dfs(target.node);
        }
      }

      currentPath.remove(node);
      result.insert(0, node);
    }

    for (var node in nodes) {
      if (!visited[node]!) {
        dfs(node);
      }
    }

    return result;
  }

  NodeTreeEvaluation evaluateNodeTree() {
    List<INode> incorrectNodes = [];

    for (INode node in nodes) {
      NodeEvaluation evaluation = INode.evaluateConnections(node.outputs);

      if (!evaluation.isValid) {
        incorrectNodes.add(node);
      }
    }

    return NodeTreeEvaluation(
      isValid: incorrectNodes.isEmpty, 
      incorrectNodes: incorrectNodes
    );
  }

  @override
  String toString() {
    Map map = {
      'id': id,
      'nodes': List.generate(originalNodes.length, (index) => originalNodes[index].toJson())
    };
    return jsonEncode(map);
  }

  static NodeTree? fromString(String string, List<NodeTreeVariable> variables) {
    Map map = jsonDecode(string);
    Map<int, List<String>> targetsMap = {};
    List<INode> allNodes = [];

    var nodesAsString = map['nodes'];
    if (nodesAsString is List) {
      for (var nodeJson in nodesAsString) {
        Map nodeMap = jsonDecode(nodeJson);
        INode? node = _getCorrectNodeType(nodeMap['type'])?.fromJson(nodeJson);
        
        if (node != null) {
          targetsMap[node.id] = convertListToListString(nodeMap['targets'] ?? []);
          allNodes.add(node);
        }
      }

      if (allNodes.isNotEmpty) {
        for (var node in allNodes) {
          node.targets = INode.initializeTargets(allNodes, targetsMap, node.id);
        }
        return NodeTree(nodes: allNodes, id: map['id'] ?? createUniqueId(), variables: variables);
      }
    }
    return null;
  }
}

Map<String, Function> _nodeTypeConstructors = {
    MathNode().runtimeType.toString(): () => MathNode(),
    NumberOutputNode().runtimeType.toString(): () => NumberOutputNode(),
    ComparisonNode().runtimeType.toString(): () => ComparisonNode(),
    BooleanNode().runtimeType.toString(): () => BooleanNode(),
    BooleanOutputNode().runtimeType.toString(): () => BooleanOutputNode()
    
};

INode? _getCorrectNodeType(String type) {
  if (_nodeTypeConstructors[type] != null) {
    return _nodeTypeConstructors[type]?.call();
  }
  return null;
}

class NodeTreeEvaluation {
  bool isValid;
  List<INode> incorrectNodes;

  NodeTreeEvaluation({required this.isValid, required this.incorrectNodes});
}

List<String> convertListToListString(List list) {
  List<String> stringList = [];
  for (var element in list) {
    if (element is String) {
      stringList.add(element);
    }
  }

  return stringList;
}

dynamic getDefaultNodeDataTypeValue(NodeDataType type) {
    switch (type) {
      case NodeDataType.boolean:
        return false;      
      case NodeDataType.number:
        return 1.00;
      case NodeDataType.string:
        return '';
      case NodeDataType.list:
        return [];
      case NodeDataType.color:
        return null;
      case NodeDataType.any: 
        return true;
    }
  }