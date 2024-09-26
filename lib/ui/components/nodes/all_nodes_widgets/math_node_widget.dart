import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/interface/node_interface.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class MathNodeWidget extends StatefulWidget implements INodeWidget {
  MathNodeWidget({
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
  final MathNode node;

  @override
  final Offset maxOffset;

  @override
  final StylesGetters theme;

  @override
  List<Offset> inputsOffsets = [];

  @override
  List<Offset> outputsOffsets = [];

  @override
  MathNodeWidget copy(GlobalKey newKey) {
    return MathNodeWidget(
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
  static MathNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, NodeWidgetFunctions functions) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MathNodeWidget(
      key: key,
      theme: theme,
      node: MathNode().fromJson(data['node']) as MathNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      functions: functions
    );
  }
  
  @override
  final double height = 105;
  
  @override
  final double width = 100;
  
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
  State<MathNodeWidget> createState() => _MathNodeWidgetState();

  @override
  NodeWidgetFunctions functions;
}

class _MathNodeWidgetState extends State<MathNodeWidget> {

  late NodeWidgetInformations widgetInformations;

  final List<MathNodeType> typesThatOnlyNeedOneInput = [
    MathNodeType.squareRoot,
    MathNodeType.sign,
    MathNodeType.round,
    MathNodeType.floor,
    MathNodeType.ceil,
    MathNodeType.truncate,
    MathNodeType.sin,
    MathNodeType.cos,
    MathNodeType.tan,
    MathNodeType.asin,
    MathNodeType.acos,
    MathNodeType.atan,
    MathNodeType.sinh,
    MathNodeType.cosh,
    MathNodeType.tanh,
    MathNodeType.asinh,
    MathNodeType.acosh,
    MathNodeType.atanh,
    MathNodeType.ln,
    MathNodeType.log10,
    MathNodeType.abs,
  ];

  final List<int> inputsThatAreNoLongerNeeded = [1];

  void onSelectionChanged(MathNodeType? newType) {
    setState(() {
      widget.node.operationType = newType ?? MathNodeType.addition;

      // Ensure to remove unnecessary inputs from the node targets
      if (typesThatOnlyNeedOneInput.contains(newType)) {
        final List<NodeConnection> connections = widget.functions.getConnections();
        widget.functions.resetUnnecessaryInputs(widget, inputsThatAreNoLongerNeeded, connections);

        widget.functions.updateConnections();
      }

      widgetInformations.needToBeSmaller = typesThatOnlyNeedOneInput.contains(newType);

      widget.functions.saveState();
    });
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
    widgetInformations.needToBeSmaller = typesThatOnlyNeedOneInput.contains(widget.node.operationType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset draggingStartPortOffset = widgetInformations.draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    return NodeWidgetBody(
      nodeTitle: S.of(context).node_widgets_math_node_title, 
      theme: widget.theme, 
      nodeWidget: widget, 
      needToBeSmaller: widgetInformations.needToBeSmaller, 
      inputsThatAreNoLongerNeeded: inputsThatAreNoLongerNeeded, 
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
          label: S.of(context).node_widgets_value_text, 
          setDragStartingPort: widgetInformations.setStartDraggingPoint, 
          getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
          setOffset: widgetInformations.setNodePortOffset, 
          functions: widget.functions
        )
      ),
      // Math operation selector
      NodeWidgetDropdown<MathNodeType>(
        value: widget.node.operationType,
        items: MathNodeType.values,
        onChanged: onSelectionChanged,
        width: widget.width,
        height: widget.height,
        theme: widget.theme,
        itemToString: (type) {
          return _getMathNodeTypeTranslation(type);
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
          connectedLabel: S.of(context).node_widgets_value_text, 
          setDragStartingPort: widgetInformations.setStartDraggingPoint, 
          getDraggingStartPortOffset: widgetInformations.getDraggingStartPortOffset, 
          setOffset: widgetInformations.setNodePortOffset, 
          onValueChanged: widget.functions.changeValueForPort, 
          functions: widget.functions
        )
      ),
      if (!typesThatOnlyNeedOneInput.contains(widget.node.operationType))
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
            connectedLabel: S.of(context).node_widgets_value_text, 
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

String _getMathNodeTypeTranslation(MathNodeType type) {
  switch (type) {
    case MathNodeType.addition:
      return S.current.node_widgets_math_node_options_addition;
    case MathNodeType.substraction:
      return S.current.node_widgets_math_node_options_substraction;
    case MathNodeType.division:
      return S.current.node_widgets_math_node_options_division;
    case MathNodeType.multiplication:
      return S.current.node_widgets_math_node_options_multiplication;
    case MathNodeType.squareRoot:
      return S.current.node_widgets_math_node_options_squareRoot;
    case MathNodeType.power:
      return S.current.node_widgets_math_node_options_power;
    case MathNodeType.min:
      return S.current.node_widgets_math_node_options_min;
    case MathNodeType.max:
      return S.current.node_widgets_math_node_options_max;
    case MathNodeType.sign:
      return S.current.node_widgets_math_node_options_sign;
    case MathNodeType.round:
      return S.current.node_widgets_math_node_options_round;
    case MathNodeType.floor:
      return S.current.node_widgets_math_node_options_floor;
    case MathNodeType.ceil:
      return S.current.node_widgets_math_node_options_ceil;
    case MathNodeType.truncate:
      return S.current.node_widgets_math_node_options_truncate;
    case MathNodeType.sin:
      return S.current.node_widgets_math_node_options_sin;
    case MathNodeType.cos:
      return S.current.node_widgets_math_node_options_cos;
    case MathNodeType.tan:
      return S.current.node_widgets_math_node_options_tan;
    case MathNodeType.asin:
      return S.current.node_widgets_math_node_options_asin;
    case MathNodeType.acos:
      return S.current.node_widgets_math_node_options_acos;
    case MathNodeType.atan:
      return S.current.node_widgets_math_node_options_atan;
    case MathNodeType.sinh:
      return S.current.node_widgets_math_node_options_sinh;
    case MathNodeType.cosh:
      return S.current.node_widgets_math_node_options_cosh;
    case MathNodeType.tanh:
      return S.current.node_widgets_math_node_options_tanh;
    case MathNodeType.asinh:
      return S.current.node_widgets_math_node_options_asinh;
    case MathNodeType.acosh:
      return S.current.node_widgets_math_node_options_acosh;
    case MathNodeType.atanh:
      return S.current.node_widgets_math_node_options_atanh;
    case MathNodeType.ln:
      return S.current.node_widgets_math_node_options_ln;
    case MathNodeType.log10:
      return S.current.node_widgets_math_node_options_log10;
    case MathNodeType.abs:
      return S.current.node_widgets_math_node_options_abs;
  }
}