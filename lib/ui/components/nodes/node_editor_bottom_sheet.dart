import 'package:flutter/material.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_grid_painter.dart';
import 'package:minddy/ui/components/nodes/nodes_connections_painter.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeEditorBottomSheet extends StatefulWidget {
  const NodeEditorBottomSheet({
    super.key,
    required this.controller,
    required this.theme
  });

  final NodeEditorBottomSheetController controller;
  final StylesGetters theme;

  @override
  State<NodeEditorBottomSheet> createState() => _NodeEditorBottomSheetState();
}

class _NodeEditorBottomSheetState extends State<NodeEditorBottomSheet> {

  @override
  void dispose() {
    widget.controller.viewPositionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.controller.initialize(widget.theme);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size appWindowSize = MediaQuery.of(context).size;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
      tween: Tween<double>(
        begin: widget.controller.isClosed ? appWindowSize.height / 2.2 : 0,
        end: widget.controller.isClosed ? appWindowSize.height / 2.2 : 0,
      ),
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(0, offset),
          child: Material(
            type: MaterialType.transparency,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                width: appWindowSize.width,
                height: appWindowSize.height / 1.8,
                decoration: BoxDecoration(
                  color: widget.theme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // Grid with nodes
                        InteractiveViewer(
                          transformationController: widget.controller.viewPositionController,
                          maxScale: 3,
                          minScale: 0.4,
                          constrained: false,
                          child: SizedBox(
                            width: 4000,
                            height: 2000,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomPaint(
                                  size: const Size(4000, 2500), // Size of the node board
                                  painter: NodeEditorGridPainter(
                                    theme: widget.theme,
                                    scale: 1.0,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: widget.controller.nodeConnectionUpdater,
                                  builder: (context, child) {
                                    widget.controller.getNodesConnections();
                                    if (widget.controller.nodesConnections.isEmpty) {
                                      return const SizedBox();
                                    } else {
                                      return CustomPaint(
                                        size: const Size(4000, 2500), // Size of the node board
                                        painter: NodeConnectionPainter(
                                          widget.controller.nodesConnections, 
                                          widget.theme.onSurface,
                                        ),
                                      );
                                    }   
                                  }
                                ),
                                ...widget.controller.nodesWidgets
                              ],
                            ),
                          ),
                        ),
                        // Top bar
                        Positioned(
                          top: 0,
                          child: SizedBox(
                            width: appWindowSize.width,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(),
                                  // Top notch
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.controller.isClosed = !widget.controller.isClosed;
                                      });
                                    },
                                    child: MouseRegion(
                                      cursor: widget.controller.isClosed
                                          ? SystemMouseCursors.resizeUp
                                          : SystemMouseCursors.resizeDown,
                                      child: Container(
                                        width: appWindowSize.width * 0.02,
                                        height: appWindowSize.height * 0.005,
                                        constraints: const BoxConstraints(
                                          minWidth: 40,
                                          minHeight: 5
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.theme.onSurface.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                              (appWindowSize.height * 0.005) / 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // New node button
                                  IconButton(
                                    onPressed: () async {widget.controller.addTree(widget.theme);},
                                    style: ButtonThemes.secondaryButtonStyle(context),
                                    icon: Icon(Icons.add_rounded, color: widget.theme.onPrimary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}