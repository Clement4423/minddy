import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';

class NodePortInfo {
  NodePortType type;
  INodeWidget node;
  int portIndex;

  NodePortInfo({required this.node, required this.type, required this.portIndex});
}
