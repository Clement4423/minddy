import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class MyNewNodeWidget extends StatefulWidget implements INodeWidget {
  MyNewNodeWidget({
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
  final INode node; // TODO : Change the node type

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  MyNewNodeWidget copy(GlobalKey newKey) {
    return MyNewNodeWidget(
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
  static MyNewNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MyNewNodeWidget(
      key: key,
      theme: theme,
      node: INode().fromJson(data['node']) as INode, // TODO : Change the node type
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 100;
  
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
  State<MyNewNodeWidget> createState() => _MyNewNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _MyNewNodeWidgetState extends State<MyNewNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  // The main action of the widget.
  // Only if nescessary -> if you have a dropdown selector, can be used to change the inputs.
  void main() {
    
  }

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
      nodeTitle: 'NODE TITLE', 
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
            label: "TEXT", 
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset,
            setOffset: widgetInformations.setNodePortOffset,
            functions: widget.functions
          )
        ),
        // Options selector
        NodeWidgetDropdown(
          value: 'TEXT',
          items: const ['TEXT', 'OTHER TEXT'],
          onChanged: (t) {},
          width: widget.width,
          height: widget.height,
          theme: widget.theme,
          itemToString: (t) {
            return t.toString();
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
            connectedLabel: "TEXT", 
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
            connectedLabel: "TEXT", 
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