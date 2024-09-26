import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/utils/calculate_text_contrast.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_cursor_connection_painter.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetBody extends StatefulWidget {
  const NodeWidgetBody({
    super.key, 
    required this.nodeTitle, 
    required this.theme,
    required this.nodeWidget, 
    required this.needToBeSmaller, 
    required this.inputsThatAreNoLongerNeeded, 
    required this.isDraggingStartPortFromAnotherPort, 
    required this.currentCursorOffset, 
    required this.draggingStartPortOffset, 
    required this.inputPortInfo,
    required this.children
  });

  final String nodeTitle;
  final StylesGetters theme;
  final INodeWidget nodeWidget;
  final bool needToBeSmaller;
  final List inputsThatAreNoLongerNeeded;
  final bool isDraggingStartPortFromAnotherPort;
  final Offset? currentCursorOffset;
  final Offset draggingStartPortOffset;
  final NodePortInfo? inputPortInfo;
  final List<Widget> children;

  @override
  State<NodeWidgetBody> createState() => _NodeWidgetBodyState();
}

class _NodeWidgetBodyState extends State<NodeWidgetBody> {

  late final Color nodeColor;
  bool isDraggingWithMouse = true;
  bool isDragging = false;
  bool isSelected = false;
  bool isLastSelected = false;

  @override
  void initState() {
    nodeColor = getCorrectColorBasedOnNodeDataType(widget.nodeWidget.node.outputsTypes.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<INodeWidget> selectedNodesList = widget.nodeWidget.functions.getSelectedNodes(); 
    isSelected = selectedNodesList.contains(widget.nodeWidget);
    isLastSelected = isSelected ? selectedNodesList.last == widget.nodeWidget : false;
    return Positioned(
      top: widget.nodeWidget.position.dy,
      left: widget.nodeWidget.position.dx,
      child: MouseRegion(
        cursor: isDragging 
          ? Platform.isMacOS 
            ? SystemMouseCursors.grabbing 
            : SystemMouseCursors.move 
          : SystemMouseCursors.basic,
        child: GestureDetector(
          onPanStart: (details) {
            if (details.kind == PointerDeviceKind.mouse) {
              isDragging = true;
              isDraggingWithMouse = true;
              widget.nodeWidget.functions.setAsSelectedIfNotAlready(widget.nodeWidget);
            } else {
              isDraggingWithMouse = false;
            }
          },
          onPanUpdate: (details) {
            widget.nodeWidget.functions.onDragUpdate(details, widget.nodeWidget);
          },
          onPanEnd: (details) {
            setState(() {
              isDraggingWithMouse = true;
              isDragging = false;
              widget.nodeWidget.functions.saveState();           
            });
          },
          onTapDown: (details) {widget.nodeWidget.functions.handleTapDown(widget.nodeWidget);},
          onTapUp: (details) {widget.nodeWidget.functions.handleTapUp(widget.nodeWidget);},
          // Whole node
          child: Stack(
            children: [
              Container(
                width: widget.nodeWidget.width,
                height: widget.needToBeSmaller 
                  ? (widget.nodeWidget.height - (widget.inputsThatAreNoLongerNeeded.length * 20)) 
                  : widget.nodeWidget.height,
                decoration: BoxDecoration(
                  color: widget.nodeWidget.theme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.nodeWidget.theme.shadow.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4)
                    )
                  ],
                  border: Border.all(
                    color: isSelected 
                      ? isLastSelected 
                        ? DefaultAppColors.blue.color
                        : DefaultAppColors.yellow.color
                      : Colors.transparent, 
                    width: 1.2,
                    strokeAlign: BorderSide.strokeAlignOutside
                  ),
                ),
                // Node body
                child: Column(
                  children: [
                    // Node top part, with title
                    Container(
                      height: 15,
                      width: widget.nodeWidget.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                        ),
                        color: nodeColor
                      ),
                      child: Center(
                        // Node title
                        child: Text(
                          widget.nodeTitle,
                          style: widget.nodeWidget.theme.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            color: hasSufficientContrast(Colors.black, nodeColor) 
                              ? Colors.black 
                              : Colors.white
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    ...widget.children,
                  ],
                ),
              ),
              // Do not modify
              if (widget.currentCursorOffset != null)
                NodeWidgetCursorConnectionPainter(
                  draggingStartPortOffset: widget.draggingStartPortOffset, 
                  isDraggingStartPortFromAnotherPort: widget.isDraggingStartPortFromAnotherPort,
                  widget: widget.nodeWidget, 
                  inputPortInfo: widget.inputPortInfo, 
                  currentCursorOffset: widget.currentCursorOffset, 
                  isSelected: isSelected
                ),
            ],
          ),
        ),
      ),
    );
  }
}