import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/system/shortcuts/shortcuts_activators.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_bottom_toolbox.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel.dart';
import 'package:minddy/ui/components/nodes/node_editor_grid_painter.dart';
import 'package:minddy/ui/components/nodes/node_editor_show_node_add_menu.dart';
import 'package:minddy/ui/components/nodes/nodes_connections_painter.dart';
import 'package:minddy/ui/components/nodes/selection_rect_painter.dart';
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

  Offset? _dragStartPosition;
  Offset? _currentDragPosition;
  bool _isDragging = false;
  Rect? _selectionRect;

  bool savedFirstState = false;

  Offset _globalToLocal(Offset globalPosition) {
    // Apply the inverse of the current transformation matrix to convert the global position to local
    final Matrix4 transform = widget.controller.viewPositionController.value;
    final Matrix4 inverseMatrix = Matrix4.inverted(transform);
    return MatrixUtils.transformPoint(inverseMatrix, globalPosition);
  }

  void _selectNodesWithinRect() {
    if (_selectionRect == null) return;

    final Rect localSelectionRect = Rect.fromLTWH(
      _selectionRect!.topLeft.dx,
      _selectionRect!.topLeft.dy,
      _selectionRect!.width,
      _selectionRect!.height
    );

    List<INodeWidget> selectedNodes = widget.controller.getSelectedNodes();

    for (var nodeWidget in widget.controller.nodesWidgets) {
      final Rect nodeRect = Rect.fromLTRB(
        nodeWidget.position.dx,
        nodeWidget.position.dy,
        nodeWidget.position.dx + nodeWidget.width,
        nodeWidget.position.dy + nodeWidget.height
      );

      bool overlaps = localSelectionRect.overlaps(nodeRect);

      if (overlaps) {
        selectedNodes.add(nodeWidget);
      }
    }

    widget.controller.setSelectedNode(selectedNodes);
  }

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
      duration: const Duration(milliseconds: 700),
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
              child: Shortcuts(
                shortcuts: {
                  undoActivator: const UndoPressIntent(),
                  redoActivator: const RedoPressIntent(),
                  copyActivator: const CopyPressIntent(),
                  pasteActivator: const PastePressIntent(),
                  duplicateActivator: const DuplicatePressIntent(),
                  deleteActivator: const DeletePressIntent()
                },
                child: Actions(
                  actions: {
                    UndoPressIntent: CallbackAction<UndoPressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.undo()
                      }
                    ),
                    RedoPressIntent: CallbackAction<RedoPressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.redo()
                      }
                    ),
                    CopyPressIntent: CallbackAction<CopyPressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.copySelectedNodes()
                      }
                    ),
                    PastePressIntent: CallbackAction<PastePressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.pasteCopiedNodes()
                      }
                    ),
                    DuplicatePressIntent: CallbackAction<DuplicatePressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.copySelectedNodes(),
                        widget.controller.pasteCopiedNodes(),
                        widget.controller.state.copiedNodes.clear()
                      }
                    ),
                    DeletePressIntent: CallbackAction<DeletePressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.deleteSelectedNodes()
                      }
                    )
                  },
                  child: Focus(
                    autofocus: true,
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
                          if (widget.controller.nodeTreeChanged) {
                            widget.controller.nodeTreeChanged = false;
                            widget.controller.isInitialized = false;
                            savedFirstState = false;
                            widget.controller.state.clearHistory();
                            widget.controller.initialize(widget.theme);
                            if (widget.controller.nodesWidgets.isEmpty) {
                              widget.controller.eraseNodesWidgets(widget.theme);
                            }
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.controller.nodeConnectionUpdater.notify();
                            if (!savedFirstState) {
                              widget.controller.saveState();
                              savedFirstState = true;
                            }
                          });
                          return Stack(
                            children: [
                              // Grid with nodes
                              GestureDetector(
                                onTap: () {
                                  if (widget.controller.selectedNodes.isNotEmpty) {
                                    widget.controller.setSelectedNode([]);
                                  }
                                },
                                onPanStart: (details) {
                                  bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
                                  if (isShiftPressed) {
                                    _isDragging = true;
                                    _dragStartPosition = _globalToLocal(details.localPosition);
                                    _currentDragPosition = _dragStartPosition;
                                  } 
                                },
                                onPanUpdate: (details) {
                                  if (_isDragging) {
                                    setState(() {
                                      _currentDragPosition = _globalToLocal(details.localPosition);
                                      _selectionRect = Rect.fromPoints(
                                        _dragStartPosition!,
                                        _currentDragPosition!,
                                      );
                                    });
                                  }
                                },
                                onPanEnd: (details) {
                                  if (_isDragging) {
                                    setState(() {
                                      _selectNodesWithinRect();
                                      _isDragging = false;
                                      _selectionRect = null;
                                    });
                                  }
                                },
                                child: ClipRRect(
                                  child: InteractiveViewer(
                                    transformationController: widget.controller.viewPositionController,
                                    maxScale: 3,
                                    minScale: 0.4,
                                    constrained: false,
                                    child: SizedBox(
                                      width: 3500,
                                      height: 1000,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: const Size(3500, 1000), // Size of the node board
                                            painter: NodeEditorGridPainter(
                                              theme: widget.theme,
                                              scale: 1.0,
                                            ),
                                          ),
                                          AnimatedBuilder(
                                            animation: widget.controller.nodeConnectionUpdater,
                                            builder: (context, child) {
                                              widget.controller.getNodesConnections();
                                              widget.controller.context = context;
                                              widget.controller.getSelectedNodesConnections();
                                              if (widget.controller.nodesConnections.isEmpty) {
                                                return const SizedBox();
                                              } else {
                                                return FutureBuilder(
                                                  future: waitNextFrame(),
                                                  builder: (context, snapshot) {
                                                    return CustomPaint(
                                                      key: UniqueKey(),
                                                      size: const Size(3500, 1000), // Size of the node board
                                                      painter: NodeConnectionPainter(
                                                        connections: widget.controller.nodesConnections, 
                                                        selectedConnections: widget.controller.selectedNodesConnections,
                                                        theme: widget.theme
                                                      ),
                                                    );
                                                  }
                                                );
                                              }   
                                            }
                                          ),
                                          ...widget.controller.nodesWidgets,
                                          if (_isDragging && _selectionRect != null)
                                              CustomPaint(
                                                size: const Size(3500, 1000), // Size of the node board
                                                painter: SelectionRectPainter(_selectionRect!, widget.theme.secondary),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Side panel
                              Positioned(
                                left: 5,
                                top: (((appWindowSize.height / 1.8) + 5) - (appWindowSize.height / 1.8)),
                                child: NodeEditorBottomSheetSidePanel(
                                  height: (appWindowSize.height / 1.8) - 10, 
                                  theme: widget.theme,
                                  isClosedInitially: widget.controller.isSidePanelClosed,
                                  setIsClosed: widget.controller.setIsSidePanelClosed,
                                  controller: widget.controller,
                                )
                              ),
                              // Bottom toolbar
                              Positioned(
                                bottom: 5,
                                left: (appWindowSize.width / 2) - 112.5,
                                child: AnimatedBuilder(
                                  animation: widget.controller.bottomToolbarUpdater,
                                  builder: (context, child) {
                                    return NodeEditorBottomSheetBottomToolbox(
                                      controller: widget.controller, 
                                      theme: widget.theme
                                    );
                                  }
                                )
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
                                            child: Tooltip(
                                              message: widget.controller.isClosed ? S.of(context).node_editor_view_open_node_panel_tooltip : S.of(context).node_editor_view_close_node_panel_tooltip,
                                              child: Container(
                                                width: appWindowSize.width * 0.02,
                                                height: appWindowSize.height * 0.005,
                                                constraints: const BoxConstraints(
                                                  minWidth: 40,
                                                  minHeight: 5
                                                ),
                                                decoration: BoxDecoration(
                                                  color: widget.theme.onSurface.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular((appWindowSize.height * 0.005) / 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // New node button
                                        IconButton(
                                          onPressed: () {
                                            showNodeEditorAddMenu(
                                              context, 
                                              widget.controller.nodes.asList, 
                                              widget.theme, 
                                              (node) {
                                                widget.controller.addNode(node, true);
                                              }, 
                                              true
                                            );
                                          },
                                          style: ButtonThemes.secondaryButtonStyle(context),
                                          tooltip: S.of(context).node_editor_view_new_node_tooltip,
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
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<void> waitNextFrame() async {
  Completer completer = Completer();

  WidgetsBinding.instance.addPostFrameCallback((_) => completer.complete());

  return completer.future;
}