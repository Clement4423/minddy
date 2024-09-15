import 'package:flutter/material.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/nodes/nodes_connections_painter.dart';

class NodeWidgetCursorConnectionPainter extends StatelessWidget {
  const NodeWidgetCursorConnectionPainter({
    super.key,
    required this.draggingStartPortOffset,
    required this.isDraggingStartPortFromAnotherPort,
    required this.widget,
    required this.inputPortInfo,
    required Offset? currentCursorOffset,
    required this.isSelected,
  }) : _currentCursorOffset = currentCursorOffset;

  final Offset draggingStartPortOffset;
  final bool isDraggingStartPortFromAnotherPort;
  final INodeWidget widget;
  final NodePortInfo? inputPortInfo;
  final Offset? _currentCursorOffset;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        Offset cursorOffset = draggingStartPortOffset;
        if (isDraggingStartPortFromAnotherPort) {
          cursorOffset = widget.inputsOffsets[inputPortInfo!.portIndex];
        }
        return CustomPaint(
          painter: CurvedLinePainter(
            start: draggingStartPortOffset,
            end: _currentCursorOffset! + cursorOffset,
            color: isSelected ? DefaultAppColors.blue.color : widget.theme.onSurface,
            plusSignColor: isDraggingStartPortFromAnotherPort ? Colors.transparent : widget.theme.onSurface,
            isHoveringANodePort: widget.functions.getSelectedPort() != null
          ),
        );
      }
    );
  }
}