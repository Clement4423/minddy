import 'dart:convert';

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
          orElse: () {return topologicalSort()!.last;}
        );
      }
    );
  }

  bool isInputNodeBefore(INode outputNode, INode inputNode, NodeTarget targetToAdd) {

    if (outputNode.targets.isEmpty && inputNode.targets.isEmpty) {
      print("No targets");
      return false;
    }

    List<INode> nodesCopy = nodes.map((e) => e.copy()).toList();

    for (INode node in nodesCopy) {
      node.targets = node.targets.map((target) {
        return NodeTarget(
          outputIndex: target.outputIndex,
          node: nodesCopy.firstWhere((n) => n.id == target.node.id),
          inputIndex: target.inputIndex
        );
      }).toList();
    }

    NodeTarget targetToAddCopy = NodeTarget(
      outputIndex: targetToAdd.outputIndex,
       node: nodesCopy.firstWhere((e) => e.id == targetToAdd.node.id),
      inputIndex: targetToAdd.inputIndex
    );

    nodesCopy.firstWhere((e) => e.id == outputNode.id).targets.add(targetToAddCopy); 

    INode outputCopy = nodesCopy.firstWhere((n) => n.id == outputNode.id);
    INode inputCopy = nodesCopy.firstWhere((n) => n.id == inputNode.id);

    List<INode>? sortedNodes = _buildGraph(nodesCopy);

    if (sortedNodes == null) {
      return true;
    }

    int outputIndex = sortedNodes.indexOf(outputCopy);
    int inputIndex = sortedNodes.indexOf(inputCopy);

    if (outputIndex == -1 || inputIndex == -1) {
      print("null");
      return true;
    }

    print("Indexes: $outputIndex, $inputIndex, Length: ${sortedNodes.length}");

    return outputIndex > inputIndex;
  }

  void _propagateDataToNextNodes(INode currentNode) {
    for (var target in currentNode.targets) {
      INode nextNode = target.node;

      // Ensure the target node's inputs are prepared
      if (nextNode.inputs.length < nextNode.inputsTypes.length) {
        nextNode.inputs = List.generate(nextNode.inputsTypes.length, (i) {
          NodeDataType type = nextNode.inputsTypes[i];
          return NodeData(type: type, value: getDefaultNodeDataTypeValue(type));
        });
      }

      // Propagate data from current node's outputs to the next node's inputs
      try {
        NodeOutput matchingOutput = currentNode.outputs.firstWhere((output) =>
            output.target == nextNode && output.inputIndex == target.inputIndex);

        // Set the data to the correct input index of the next node
        if (target.inputIndex < nextNode.inputsTypes.length) {
          nextNode.inputs[target.inputIndex] = matchingOutput.data;
        }
      } catch (e) {
        print("Error during data propagation: $e");
        return;
      }
    }
  }

  Future<NodeData?> run() async {
    List<INode> sortedNodes = topologicalSort() ?? [];

    // Ensure the output node is executed last
    if (outputNode != null) {
      sortedNodes.remove(outputNode);
      sortedNodes.add(outputNode!);
    }

    for (int i = 0; i < sortedNodes.length; i++) {
      await sortedNodes[i].execute();

      // After executing, propagate data to connected nodes
      if (i < sortedNodes.length - 1) {
        _propagateDataToNextNodes(sortedNodes[i]);
      }
    }

    // Return output node's result
    if (outputNode is IOutputNode) {
      return (outputNode as IOutputNode).getResult();
    }

    return null;
  }

  // Cycle detection and prevention
  List<INode>? _buildGraph([List<INode>? nodesToUse]) {
    for (var node in nodesToUse ?? nodes) {
      for (var target in node.targets) {
        _graph.addEdge(node, target.node);
      }
    }

    // Ensure there are no cycles in the graph
    return topologicalSort(nodesToUse);
  }

List<INode>? topologicalSort([List<INode>? nodesToUse]) {
  Map<INode, bool> visited = {for (var node in nodesToUse ?? nodes) node: false};
  List<INode> result = [];
  Set<INode> currentPath = {};

  bool dfs(INode node) {
    if (currentPath.contains(node)) {
      return false;
    }

    if (visited[node] == true) {
      return true;
    }

    currentPath.add(node);
    visited[node] = true;

    for (var target in node.targets) {
      if (!dfs(target.node)) {
        return false;
      }
    }

    currentPath.remove(node);
    result.add(node);
    return true;
  }

  for (var node in nodesToUse ?? nodes) {
    if (!visited[node]!) {
      if (!dfs(node)) {
        return null;
      }
    }
  }

  return result.reversed.toList();
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