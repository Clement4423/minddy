import 'package:minddy/system/interface/i_node_widget.dart';

class NodeConnection {
  final INodeWidget startNode;
  final INodeWidget endNode;

  final int startOutputIndex;
  final int endInputIndex;

  NodeConnection(this.startNode, this.startOutputIndex, this.endNode, this.endInputIndex);

  @override
  String toString() {
    return "Start node: $startNode - End node $endNode - Start output index $startOutputIndex - End input index: $endInputIndex";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NodeConnection &&
        other.startNode == startNode &&
        other.startOutputIndex == startOutputIndex &&
        other.endNode == endNode &&
        other.endInputIndex == endInputIndex;
  }

  @override
  int get hashCode {
    return startNode.hashCode ^
        startOutputIndex.hashCode ^
        endNode.hashCode ^
        endInputIndex.hashCode;
  }
}