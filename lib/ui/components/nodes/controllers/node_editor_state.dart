import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/model/node_tree_variable.dart';
import 'package:minddy/system/nodes/all_nodes/comparison_node.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/all_nodes/random_number_node.dart';
import 'package:minddy/system/nodes/all_nodes/variables_nodes/get_variable_node.dart';
import 'package:minddy/system/nodes/all_nodes/variables_nodes/set_variable_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_tree_variable_manager.dart';

class NodeEditorState {

  List<INodeWidget> _copiedNodes = [];

  List<NodeEditorHistoryElement> _history = [];
  int _currentIndex = -1;

  List<INodeWidget> get copiedNodes => _copiedNodes;
  List<NodeEditorHistoryElement> get history => _history;
  int get historyMaxLength => 32;

  void addCopiedNodes(List<INodeWidget> newNodes) {
    _copiedNodes = newNodes;
  }

  List<INodeWidget> getCopiedNodes() {
    return _copiedNodes;
  }

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




// TODO : Retirer cette partie

void main() async {

  NodeTreeVariable variable1 = NodeTreeVariable(name: 'Variable 1', type: NodeDataType.number, id: 0);
  variable1.value = NodeData(type: NodeDataType.number, value: 2.0);
  NodeTreeVariable variable2 = NodeTreeVariable(name: 'Variable 2', type: NodeDataType.boolean, id: 1);

  RandomNumberNode randomNumberNode = RandomNumberNode();
  randomNumberNode.inputs = [NodeData(type: NodeDataType.number, value: 10.50), NodeData(type: NodeDataType.number, value: 11.23)];
  MathNode mathNode = MathNode();

  randomNumberNode.targets.add(NodeTarget(outputIndex: 0, node: mathNode, inputIndex: 0));

  NodeTreeVariablesManager variablesManager = NodeTreeVariablesManager(variablesList: [variable1, variable2]);

  GetVariableNode getVariableNode = GetVariableNode(variablesManager: variablesManager, selectedVariableId: variable1.id);
  ComparisonNode comparisonNode = ComparisonNode(comparisonType: ComparisonNodeType.greatherThanOrEqual);
  comparisonNode.inputs = [NodeData(type: NodeDataType.number, value: 0.0), NodeData(type: NodeDataType.number, value: 1.0)];
  SetVariableNode setVariableNode = SetVariableNode(variablesManager: variablesManager, selectedVariableId: variable2.id);

  getVariableNode.targets.add(NodeTarget(outputIndex: 0, node: comparisonNode, inputIndex: 0));
  comparisonNode.targets.add(NodeTarget(outputIndex: 0, node: setVariableNode, inputIndex: 0));

  NodeTree nodeTree = NodeTree(
    nodes: [getVariableNode, comparisonNode, setVariableNode, randomNumberNode], 
    variablesManager: variablesManager, 
    id: 2
  );

  await nodeTree.run();

  print("Result: ${variable2.value}");
  print(randomNumberNode.outputs.first.data.value);
}