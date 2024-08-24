import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';

class NodeConnection {
  final INodeWidget startNode;
  final INodeWidget endNode;

  final int startOutputIndex;
  final int endInputIndex;

  NodeConnection(this.startNode, this.startOutputIndex, this.endNode, this.endInputIndex);
}