import 'package:flutter/material.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';

class NodeWidgetInformations {
  final INodeWidget widget;
  final Function setState;

  NodeWidgetInformations({required this.widget, required this.setState});

  Offset? draggingStartPort;  // Start port position
  Offset? currentCursorOffset; // Current cursor position
  int outputOffsetsMaxLength = 1;
  int inputsOffsetsMaxLength = 2;
  bool isDraggingStartPortFromAnotherPort = false;
  NodePortInfo? inputPortInfo;
  bool initializedOutputsOffsets = false;
  bool initializedInputsOffsets = false;

  // Those variables are only useful if the widget has options that can modify the needed inputs.
  bool needToBeSmaller = false; // Particular cases only.
  final List<int> inputsThatAreNoLongerNeeded = [1];

  void setNodePortOffset(Offset offset, NodePortInfo portInfo) {
    if (portInfo.type == NodePortType.input && !initializedInputsOffsets) {
      widget.inputsOffsets.add(offset);

      if (widget.inputsOffsets.length == inputsOffsetsMaxLength) {
        initializedInputsOffsets = true;
      }
    } else if (!initializedOutputsOffsets) {
      widget.outputsOffsets.add(offset);

      if (widget.outputsOffsets.length == outputOffsetsMaxLength) {
        initializedOutputsOffsets = true;
      }
    }
  }

  void setCursorOffset(Offset? offset) {
    setState(() {
      currentCursorOffset = offset;
    });
  }

  Offset? getDraggingStartPortOffset() {
    return draggingStartPort;
  }

  void setStartDraggingPoint(int? index, NodePortType? portType, [INodeWidget? otherNode, NodePortInfo? inputPort]) {
    if (index == null || portType == null) {
      return;
    }

    INodeWidget nodeWidget = otherNode ?? widget;

    if (inputPort != null) {
      inputPortInfo = inputPort;
      isDraggingStartPortFromAnotherPort = true;
    } else {
      isDraggingStartPortFromAnotherPort = false;
    }

    switch (portType) {
      case NodePortType.input:
        draggingStartPort = nodeWidget.inputsOffsets[index] + nodeWidget.position;
        break;
      case NodePortType.output:
        draggingStartPort = nodeWidget.outputsOffsets[index] + nodeWidget.position;
        break;
    }
  }
}
