import 'package:minddy/system/model/node_tree_variable.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';

class NodeTreeVariablesManager {

  NodeTreeVariablesManager({required List<NodeTreeVariable> variablesList}) {
    _variables = variablesList;
  }

  List<NodeTreeVariable> _variables = [];

  List<NodeTreeVariable> get variables => _variables;

  NodeTreeVariable? getVariable(int id) {
    try {
      return _variables.firstWhere((variable) => variable.id == id);
    } catch (e) {
      return null;
    }
  }

  void setVariableValue(NodeData newValue, int id) {
    try {
      NodeTreeVariable variableToModify = _variables.firstWhere((variable) => variable.id == id);
      variableToModify.value = newValue;
    } catch (e) {
      return;
    }
  }
}