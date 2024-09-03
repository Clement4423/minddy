import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';

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
