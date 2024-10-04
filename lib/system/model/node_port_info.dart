import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';

class NodePortInfo {
  NodePortType type;
  INodeWidget node;
  int portIndex;

  NodePortInfo({required this.node, required this.type, required this.portIndex});
}
