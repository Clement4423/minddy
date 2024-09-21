import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetOutput extends StatefulWidget {
  const NodeWidgetOutput({
    super.key, 
    required this.theme, 
    required this.label,
    required this.portInfo,
    required this.setCursorPosition, 
    required this.setDragStartingPort, 
    required this.getDraggingStartPortOffset, 
    required this.setOffset,
    required this.functions
  });

  final StylesGetters theme;
  final NodeWidgetFunctions functions;
  /// The text that will before the node port to explicit the output action.
  final String label;
  final NodePortInfo portInfo;
  final Function(Offset?) setCursorPosition;
  final Function(int?, NodePortType?, [INodeWidget?, NodePortInfo?]) setDragStartingPort;
  final Offset? Function() getDraggingStartPortOffset;
  final Function(Offset, NodePortInfo) setOffset;

  @override
  State<NodeWidgetOutput> createState() => _NodeWidgetOutputState();
}

class _NodeWidgetOutputState extends State<NodeWidgetOutput> {

  late final NodeDataType type;

  @override
  void initState() {
    type = widget.portInfo.node.node.outputsTypes.elementAt(widget.portInfo.portIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.portInfo.node.width,
      height: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.label, 
            style: widget.theme.titleMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 8,
              color: widget.theme.onPrimary
            ),
            maxLines: 1,
          ),
          Transform.translate(
            offset: const Offset(4, 0),
            child: NodePortWidget(
              portInfo: widget.portInfo, 
              color: getCorrectColorBasedOnNodeDataType(type), 
              onHoveredColor: widget.theme.onSurface, 
              setCursorPosition: widget.setCursorPosition, 
              setDragStartingPort: widget.setDragStartingPort, 
              getDraggingStartPortOffset: widget.getDraggingStartPortOffset, 
              setOffset: widget.setOffset,
              functions: widget.functions
            ),
          )
        ],
      ),
    );
  }
}
