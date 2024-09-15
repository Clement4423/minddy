import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/custom_components/custom_checkbox.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_text_input.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetInput extends StatefulWidget {
  const NodeWidgetInput({
    super.key, 
    required this.theme, 
    required this.isConnected, 
    required this.connectedLabel,
    required this.type, 
    required this.portInfo,
    required this.setCursorPosition, 
    required this.setDragStartingPort, 
    required this.getDraggingStartPortOffset, 
    required this.setOffset,
    required this.onValueChanged,
    required this.functions
  });

  final StylesGetters theme;
  final NodeWidgetFunctions functions;
  /// The text that will appear next to the port when connected and as hint.
  final String connectedLabel;
  final bool isConnected;
  final NodeDataType type;
  final Function(dynamic, NodePortInfo, INodeWidget) onValueChanged;
  final NodePortInfo portInfo;
  final Function(Offset?) setCursorPosition;
  final Function(int?, NodePortType?, [INodeWidget?, NodePortInfo?]) setDragStartingPort;
  final Offset? Function() getDraggingStartPortOffset;
  final Function(Offset, NodePortInfo) setOffset;

  @override
  State<NodeWidgetInput> createState() => _NodeWidgetInputState();
}

class _NodeWidgetInputState extends State<NodeWidgetInput> {

  String? _getDefaultValueAsString() {
    return widget.portInfo.node.node.inputs.elementAtOrNull(widget.portInfo.portIndex)?.value.toString();
  }

  bool? _getDefaultValueAsBoolean() {
    dynamic value = widget.portInfo.node.node.inputs.elementAtOrNull(widget.portInfo.portIndex)?.value;
    if (value is bool) {
      return value;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.portInfo.node.width,
      height: 15,
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(-4, 0),
            child: NodePortWidget(
              portInfo: widget.portInfo, 
              color: getCorrectColorBasedOnNodeDataType(widget.type), 
              onHoveredColor: widget.theme.onSurface, 
              setCursorPosition: widget.setCursorPosition, 
              setDragStartingPort: widget.setDragStartingPort, 
              getDraggingStartPortOffset: widget.getDraggingStartPortOffset, 
              setOffset: widget.setOffset,
              functions: widget.functions
            ),
          ),
          if (widget.isConnected)
            Text(
              widget.connectedLabel, 
              style: widget.theme.titleMedium.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 8,
                color: widget.theme.onPrimary
              ),
              maxLines: 1,
            )
          else if (widget.type == NodeDataType.boolean)
            CustomCheckbox(
              value: _getDefaultValueAsBoolean() ?? false, 
              onChanged: (bool newValue) {
                widget.onValueChanged(
                  newValue, 
                  widget.portInfo, 
                  widget.portInfo.node
                );
              }, 
              theme: widget.theme
            )
          else 
            NodeWidgetTextInput(
              onChange: widget.onValueChanged, 
              theme: widget.theme, 
              type: widget.type, 
              portInfo: widget.portInfo,
              hint: widget.connectedLabel, 
              defaultText: _getDefaultValueAsString()
            )
        ],
      ),
    );
  }
}
