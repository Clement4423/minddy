import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_widget_functions.dart';

enum NodePortType {
  input,
  output
}

class NodePortWidget extends StatefulWidget {
  const NodePortWidget({
    super.key, 
    required this.portInfo, 
    required this.color,
    required this.onHoveredColor,
    required this.setCursorPosition,
    required this.setDragStartingPort,
    required this.getDraggingStartPortOffset,
    required this.setOffset,
    required this.functions
  });

  final NodePortInfo portInfo;
  final Color color;
  final Color onHoveredColor;
  final Function(Offset?) setCursorPosition;
  final Function(int?, NodePortType?, [INodeWidget?, NodePortInfo?]) setDragStartingPort;
  final Offset? Function() getDraggingStartPortOffset;
  final Function(Offset, NodePortInfo) setOffset;
  final NodeWidgetFunctions functions;

  @override
  State<NodePortWidget> createState() => _NodePortWidgetState();
}

class _NodePortWidgetState extends State<NodePortWidget> {
  bool isHovering = false;
  bool startedIsDragging = false;

  bool isDraggingWithMouse = true;

  Offset _cursorDragOffset = const Offset(0, 0);
  NodeConnection? connection;

  NodeConnection? _isAlreadyConnected() {
    NodeConnection? connection;
    if (widget.portInfo.type == NodePortType.input) {
      for (NodeConnection c in widget.functions.getConnections()) {
        if (c.endNode == widget.portInfo.node && c.endInputIndex == widget.portInfo.portIndex) {
          connection = c;
        }
      }
    } else {
      for (NodeConnection c in widget.functions.getConnections()) {
        if (c.startNode == widget.portInfo.node && c.startOutputIndex == widget.portInfo.portIndex) {
          connection = c;
        }
      }
    }
    return connection;
  }

  Offset _calculatePosition(BuildContext context) {
    RenderBox child = context.findRenderObject() as RenderBox;
    Offset childOffset = child.localToGlobal(Offset.zero);

    RenderBox parent = (widget.portInfo.node.key as GlobalKey).currentContext!.findRenderObject() as RenderBox;
    Offset childRelativeToParent = parent.globalToLocal(childOffset);

    childRelativeToParent = childRelativeToParent.translate(4, 4);

    return childRelativeToParent;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.setOffset(_calculatePosition(context), widget.portInfo);
    });
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          if (widget.functions.getIsDragging() && !startedIsDragging) {
            widget.functions.setSelectedPort(widget.portInfo);
            isHovering = true;
          }
        });
      },
      onExit: (event) {
        setState(() {
          if (widget.functions.getIsDragging() && !startedIsDragging || isHovering) {
            widget.functions.setSelectedPort(null);
            isHovering = false;
          }
        });
      },
      child: GestureDetector(
        onPanStart: (details) {
          if (details.kind != PointerDeviceKind.mouse) {
            isDraggingWithMouse = false;
            return;
          } else {
            isDraggingWithMouse = true;
          }
          connection = _isAlreadyConnected();
          if (connection != null && widget.portInfo.type == NodePortType.input) {
            widget.functions.setIsDragging(true);

            widget.setDragStartingPort(
              connection!.startOutputIndex,
              NodePortType.output,
              connection!.startNode,
              widget.portInfo
            );

            connection!.startNode.node.targets.removeWhere((target) => target.node.id == widget.portInfo.node.node.id && target.inputIndex == widget.portInfo.portIndex);
            
            widget.functions.updateAllNodes();
            widget.functions.updateConnections();
          } else {
            widget.setDragStartingPort(widget.portInfo.portIndex, widget.portInfo.type);
            widget.functions.setIsDragging(true);
            startedIsDragging = true;
          }
        },
        onPanUpdate: (details) {
          if (isDraggingWithMouse) {
            _cursorDragOffset += details.delta;
            widget.setCursorPosition(_cursorDragOffset);
          }
        },
        onPanEnd: (details) async {
          if (isDraggingWithMouse) {
            Offset draggingStartPortOffset = widget.getDraggingStartPortOffset()!;
            if (connection != null) {
              if (widget.functions.getSelectedPort() != null && widget.portInfo.type != NodePortType.output) { 
                // This ensure that no connection is added and that the add menu is not shown 
                // if the user simply disconnected a node from another.
                widget.functions.addConnection(
                  NodePortInfo(
                    node: connection!.startNode, 
                    type: NodePortType.output, 
                    portIndex: connection!.startOutputIndex
                  ),
                  _cursorDragOffset + draggingStartPortOffset
                );
              } else if (widget.portInfo.type == NodePortType.output) {
                widget.functions.addConnection(
                  NodePortInfo(
                    node: widget.portInfo.node, 
                    type: NodePortType.output, 
                    portIndex: widget.portInfo.portIndex
                  ),
                  _cursorDragOffset + draggingStartPortOffset
                );
              }
            } else {
              widget.functions.addConnection(widget.portInfo, _cursorDragOffset + draggingStartPortOffset);
            }

            widget.setCursorPosition(null);
            widget.setDragStartingPort(null, null);
            widget.functions.setIsDragging(false);
            startedIsDragging = false;
            _cursorDragOffset = const Offset(0, 0);
            setState(() {isHovering = false;});
            widget.functions.saveState();
          } else {
            isDraggingWithMouse = true;
          }
        },
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isHovering ? widget.onHoveredColor : Colors.black, width: 1.0),
            color: isHovering ? widget.onHoveredColor : widget.color
          ),
        ),
      ),
    );
  }
}