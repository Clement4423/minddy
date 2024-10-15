import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/interfaces/node_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/conversion_node.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/nodes/logic/node_tree.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel_variable_container.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class ConversionNodeWidget extends StatefulWidget implements INodeWidget {
  ConversionNodeWidget({
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
  final ConversionNode node;

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  ConversionNodeWidget copy(GlobalKey newKey) {
    return ConversionNodeWidget(
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
  static ConversionNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return ConversionNodeWidget(
      key: key,
      theme: theme,
      node: ConversionNode().fromJson(data['node']) as ConversionNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 85;
  
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
  State<ConversionNodeWidget> createState() => _ConversionNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _ConversionNodeWidgetState extends State<ConversionNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  bool outputTypeChanged = false;

  void destroyInvalidConnections(NodeDataType? newType) {
    List<NodeTarget> targetsToRemove = [];
    for (NodeTarget target in widget.node.targets) {
      if (newType == null || INode.evaluateData(NodeData(type: newType, value: getDefaultNodeDataTypeValue(newType)), target.node.inputsTypes[target.inputIndex]) == null) {
        targetsToRemove.add(target);
      }
    }

    widget.node.targets.removeWhere((t) => targetsToRemove.contains(t));

    widget.functions.updateConnections();
  }

  bool _getOutputTypeChanged() {
    if (outputTypeChanged) {
      outputTypeChanged = false;
      return true;
    } else {
      return false;
    }
  }

  NodeDataType _getCurrentOutputType() {
    return widget.node.outputsTypes.first;
  }

  // The main action of the widget.
  // Only if nescessary -> if you have a dropdown selector, can be used to change the inputs.
  void main(NodeDataType newType) {
    widget.node.outputsTypes = [newType];
    outputTypeChanged = true;
    destroyInvalidConnections(newType);
    widget.functions.saveState();
    setState(() {});
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
      nodeTitle: S.of(context).node_widgets_conversion_node_title, 
      nodeDescription: S.of(context).node_widgets_conversion_node_decsription, 
      nodeColor: DefaultAppColors.grey.color,
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
            key: _getOutputTypeChanged() 
              ? UniqueKey() 
              : null,
            portInfo: NodePortInfo(
              node: widget, 
              type: NodePortType.output, 
              portIndex: 0
            ), 
            setCursorPosition: widgetInformations.setCursorOffset,
            theme: widget.theme, 
            label: S.of(context).node_widgets_value_text, 
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset,
            setOffset: widgetInformations.setNodePortOffset,
            functions: widget.functions
          )
        ),
        // Options selector
        NodeWidgetDropdown(
          value: _getCurrentOutputType(),
          items: NodeDataType.values.sublist(0, NodeDataType.values.length - 1),
          onChanged: (type) {
            main(type!);
          },
          width: widget.width,
          height: widget.height,
          theme: widget.theme,
          itemToString: (type) {
            return getCorrectNameBasedOnNodeDataType(type);
          },
        ),
        // Input
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
            connectedLabel: S.of(context).node_widgets_value_text,
            setDragStartingPort: widgetInformations.setStartDraggingPoint,
            getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
            setOffset: widgetInformations.setNodePortOffset, 
            onValueChanged: widget.functions.changeValueForPort, 
            functions: widget.functions
          )
        ),
      ]
    );
  }
}