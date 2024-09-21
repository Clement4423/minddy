import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/boolean_node.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class BooleanNodeWidget extends StatefulWidget implements INodeWidget {
  BooleanNodeWidget({
    super.key,
    required this.node,
    required this.position,
    required this.maxOffset,
    required this.theme,
    required this.functions
  });

  @override
  Offset position;

  @override
  final BooleanNode node;

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  BooleanNodeWidget copy(GlobalKey newKey) {
    return BooleanNodeWidget(
      key: newKey,
      node: node.copy(), 
      position: Offset(position.dx, position.dy), 
      maxOffset: maxOffset, 
      theme: theme, 
      functions: functions
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      'node': node.toJson(),
      'widget_type': runtimeType.toString(),
      'positionX': position.dx,
      'positionY': position.dy
    });
  }

  // Static method to deserialize from JSON
  static BooleanNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return BooleanNodeWidget(
      key: key,
      theme: theme,
      node: BooleanNode().fromJson(data['node']) as BooleanNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 105;
  
  @override
  final double width = 100; // Do not modify the width.
  
  @override
  set maxOffset(Offset newMaxOffset) {}
  
  @override
  set node(INode newNode) {}
    
  @override
  set height(double newHeight) {}
  
  @override
  set width(double newWidth) {}
  
  @override
  set theme(StylesGetters newTheme) {}

  @override
  State<BooleanNodeWidget> createState() => _BooleanNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _BooleanNodeWidgetState extends State<BooleanNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  @override
  void initState() {
    widgetInformations = NodeWidgetInformations(
      widget: widget, 
      setState: setState, 
      inputsOffsetsMaxLength: widget.node.inputsTypes.length, 
      outputOffsetsMaxLength: widget.node.outputsTypes.length
    );
    widget.functions.verifyPosition(widget);
    widget.functions.verifyInputs(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset draggingStartPortOffset = widgetInformations.draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    return NodeWidgetBody(
      nodeTitle: S.of(context).node_widgets_boolean_node_title, 
      theme: widget.theme, 
      nodeWidget: widget, 
      needToBeSmaller: widgetInformations.needToBeSmaller, 
      inputsThatAreNoLongerNeeded: widgetInformations.inputsThatAreNoLongerNeeded, 
      isDraggingStartPortFromAnotherPort: widgetInformations.isDraggingStartPortFromAnotherPort, 
      draggingStartPortOffset: draggingStartPortOffset, 
      currentCursorOffset: widgetInformations.currentCursorOffset,
      inputPortInfo: widgetInformations.inputPortInfo, 
      children: [
        // Output.s
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetOutput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.output, 
              portIndex: 0
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            label: S.of(context).node_editor_view_side_panel_variables_variable_type_boolean, 
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset,
            setOffset: widgetInformations.setNodePortOffset,
            functions: widget.functions
          )
        ),
        // Options selector
        NodeWidgetDropdown(
          value: widget.node.booleanType,
          items: BooleanNodeType.values,
          onChanged: (type) {
            setState(() {
              widget.node.booleanType = type!;
              widget.functions.saveState();
            });
          },
          width: widget.width,
          height: widget.height,
          theme: widget.theme,
          itemToString: (type) {
            return _getBooleanNodeTranslation(type);
          },
        ),
        // Input.s
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetInput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.input, 
              portIndex: 0
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(0, NodePortType.input, widget),
            connectedLabel: S.of(context).node_editor_view_side_panel_variables_variable_type_boolean,
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: NodeWidgetInput(
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.input, 
              portIndex: 1
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(1, NodePortType.input, widget), 
            connectedLabel: S.of(context).node_editor_view_side_panel_variables_variable_type_boolean,
            setDragStartingPort: widgetInformations.setStartDraggingPoint, 
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        )
      ]
    );
  }
}


String _getBooleanNodeTranslation(BooleanNodeType booleanType) {
  switch (booleanType) {
    case BooleanNodeType.and:
      return S.current.node_widgets_boolean_node_options_and;
    case BooleanNodeType.or:
      return S.current.node_widgets_boolean_node_options_or;
    case BooleanNodeType.not:
      return S.current.node_widgets_boolean_node_options_not;
    case BooleanNodeType.notAnd:
      return S.current.node_widgets_boolean_node_options_notAnd;
    case BooleanNodeType.notOr:
      return S.current.node_widgets_boolean_node_options_notOr;
    case BooleanNodeType.equal:
      return S.current.node_widgets_boolean_node_options_equal;
    case BooleanNodeType.notEqual:
      return S.current.node_widgets_boolean_node_options_notEqual;
    case BooleanNodeType.imply:
      return S.current.node_widgets_boolean_node_options_imply;
    case BooleanNodeType.subtract:
      return S.current.node_widgets_boolean_node_options_subtract;
  }
}