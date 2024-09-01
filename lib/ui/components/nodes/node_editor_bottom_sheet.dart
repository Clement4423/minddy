import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_grid_painter.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/components/nodes/nodes_connections_painter.dart';
import 'package:minddy/ui/theme/theme.dart';


ShortcutActivator undoActivator = SingleActivator(
  LogicalKeyboardKey.keyZ,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false
);

class UndoPressIntent extends Intent {
  const UndoPressIntent();
}

ShortcutActivator redoActivator = SingleActivator(
  LogicalKeyboardKey.keyZ,
  control: Platform.isWindows || Platform.isLinux 
    ? true 
    : false,
  meta: Platform.isMacOS 
    ? true 
    : false,
  shift: true
);

class RedoPressIntent extends Intent {
  const RedoPressIntent();
}

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

  bool isShiftPressed = false;

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
                  redoActivator: const RedoPressIntent()
                },
                child: Actions(
                  actions: {
                    UndoPressIntent: CallbackAction<UndoPressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.undo(widget.theme)
                      }
                    ),
                    RedoPressIntent: CallbackAction<RedoPressIntent>(
                      onInvoke: (intent) => {
                        widget.controller.redo(widget.theme)
                      }
                    ),
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
                                  isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
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
                                child: InteractiveViewer(
                                  transformationController: widget.controller.viewPositionController,
                                  maxScale: 3,
                                  minScale: 0.4,
                                  constrained: false,
                                  child: SizedBox(
                                    width: 4000,
                                    height: 1500,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CustomPaint(
                                          size: const Size(4000, 1500), // Size of the node board
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
                                              return FutureBuilder(
                                                future: waitNextFrame(),
                                                builder: (context, snapshot) {
                                                  return CustomPaint(
                                                    key: UniqueKey(),
                                                    size: const Size(4000, 1500), // Size of the node board
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
                                              size: const Size(4000, 1500), // Size of the node board
                                              painter: SelectionRectPainter(_selectionRect!, widget.theme.secondary),
                                            ),
                                      ],
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
                                                borderRadius: BorderRadius.circular((appWindowSize.height * 0.005) / 2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // New node button
                                        IconButton(
                                          onPressed: () async {},
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
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectionRectPainter extends CustomPainter {
  final Rect rect;
  final Color color;
  double borderRadius;

  SelectionRectPainter(this.rect, this.color, {this.borderRadius = 5.0});

  @override
  void paint(Canvas canvas, Size size) {

    if (rect.width < borderRadius) {
      borderRadius = rect.width / 2;
    } else if (rect.height < borderRadius) {
      borderRadius = rect.height / 2;
    }

    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Create RRect for rounded rectangle
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Draw the rounded rectangle
    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Future<void> waitNextFrame() async {
  Completer completer = Completer();

  WidgetsBinding.instance.addPostFrameCallback((_) => completer.complete());

  return completer.future;
}


class NodeEditorBottomSheetSidePanel extends StatefulWidget {
  const NodeEditorBottomSheetSidePanel({super.key, required this.height, required this.theme, required this.isClosedInitially, required this.setIsClosed, required this.controller});

  final double height;
  final StylesGetters theme;
  final bool isClosedInitially;
  final Function(bool) setIsClosed;
  final NodeEditorBottomSheetController controller;

  @override
  State<NodeEditorBottomSheetSidePanel> createState() => _NodeEditorBottomSheetSidePanelState();
}

class _NodeEditorBottomSheetSidePanelState extends State<NodeEditorBottomSheetSidePanel> {

  bool isClosed = false;

  void toggleSidePanel() {
    setState(() {
      isClosed = !isClosed;
      widget.setIsClosed(isClosed);
    });
  }

  void setSelectedNodeTree(int id) {
    widget.controller.setSelectedNodeTree(id);
    setState(() {});
  }

  @override
  void initState() {
    isClosed = widget.isClosedInitially;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastEaseInToSlowEaseOut,
      tween: Tween(
        begin: isClosed ? 0.0 : 255.0,
        end: isClosed ? 255.0 : 0.0,
      ),
      builder: (context, translate, child) {
        return Transform.translate(
          offset: Offset(-translate, 0),
          child: SizedBox(
            width: 295,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: isClosed ? translate >= 255 ? false : true : true,
                  child: SizedBox(
                    width: 250,
                    height: widget.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Variabe container
                        NodeEditorBottomSheetSidePanelBox(
                          panel: widget, 
                          title: "Variables", 
                          buttonTooltip: "New variable",
                          buttonAction: () {},
                          child: SizedBox()
                        ),
                        NodeEditorBottomSheetSidePanelBox(
                          key: UniqueKey(),
                          panel: widget, 
                          title: "Node trees", 
                          buttonTooltip: "New node tree",
                          buttonAction: () {
                            widget.controller.addNodeTree();
                          },
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount: widget.controller.views.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: NodeEditorBottomSheetSidePanelNodeTreeContainer(
                                  index: index,
                                  trees: widget.controller.views.map((v) => v.tree).toList(),
                                  theme: widget.theme,
                                  canBeDeleted: widget.controller.views.length > 1,
                                  isSelected: widget.controller.views[index].tree.id == widget.controller.selectedNodeTreeId,
                                  deleteNodeTree: widget.controller.deleteNodeTree,
                                  setSelectedNodeTree: widget.controller.setSelectedNodeTree,
                                ),
                              );
                            }
                          )
                        )
                      ],
                    ),
                  ),
                ),
                // Close / Open panel button
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Tooltip(
                      message: isClosed ? "Open side panel" : "Close side panel",
                      preferBelow: true,
                      verticalOffset: (widget.height / 5) / 2,
                      child: Container(
                        width: 40,
                        height: widget.height / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: widget.theme.primaryContainer,
                          border: Border.all(
                            color: widget.theme.onSurface.withOpacity(0.2),
                            width: 0.5
                          )
                        ),
                        child: IconButton(
                          onPressed: () => toggleSidePanel(),
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)))
                          ),
                          icon: Center(
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 250),
                              turns: isClosed 
                              ? 0
                              : -0.5,
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                color: widget.theme.onSurface, 
                                ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class NodeEditorBottomSheetSidePanelNodeTreeContainer extends StatefulWidget {
  const NodeEditorBottomSheetSidePanelNodeTreeContainer({
    super.key,
    required this.index,
    required this.trees,
    required this.theme,
    required this.canBeDeleted,
    required this.isSelected,
    required this.deleteNodeTree,
    required this.setSelectedNodeTree
  });

  final List<NodeWidgetTree> trees;
  final StylesGetters theme;
  final int index;
  final bool isSelected;
  final bool canBeDeleted;
  final Function(int id) deleteNodeTree;
  final Function(int id) setSelectedNodeTree;

  @override
  State<NodeEditorBottomSheetSidePanelNodeTreeContainer> createState() => _NodeEditorBottomSheetSidePanelNodeTreeContainerState();
}

class _NodeEditorBottomSheetSidePanelNodeTreeContainerState extends State<NodeEditorBottomSheetSidePanelNodeTreeContainer> {

  late final int id;

  bool canEdit = false;

  FocusNode focusNode = FocusNode();

  setCanEdit(bool value) {
    setState(() {
      canEdit = value;
    });

    if (value == true) {
      focusNode.requestFocus();
    } else if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    id = widget.trees[widget.index].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 40,
      decoration: BoxDecoration(
        color: widget.isSelected 
        ? widget.theme.secondary
        : widget.theme.primary,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                setCanEdit(true);
              },
              child: TextField(
                onChanged: (value) {
                  widget.trees[widget.index].name = value;
                },
                onEditingComplete: () {
                  setCanEdit(false);
                },
                focusNode: focusNode,
                controller: TextEditingController(text: widget.trees[widget.index].name),
                cursorColor: widget.isSelected 
                  ? widget.theme.onSecondary
                  : widget.theme.onPrimary,
                mouseCursor: canEdit 
                  ? SystemMouseCursors.text 
                  : widget.trees.length > 1 
                    ? SystemMouseCursors.click 
                    : SystemMouseCursors.basic,
                style: widget.theme.bodyMedium
                .copyWith(
                  color: widget.isSelected 
                  ? widget.theme.onSecondary
                  : widget.theme.onPrimary,
                  fontWeight: FontWeight.w500
                ),
                readOnly: canEdit ? false : true,
                onTap: () {
                  if (canEdit) {
                    return;
                  }
                  if (widget.trees.length > 1) {
                    widget.setSelectedNodeTree(id);
                  }
                },
                onTapOutside: (event) {
                  setCanEdit(false);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 7, left: 15),
                  hintText: S.of(context).projects_module_spreadsheet_value_unnamed
                ),
              ),
            ),
          ),
          if (widget.canBeDeleted)
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: () {
                    widget.deleteNodeTree(id);
                  },
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: S.of(context).snackbar_delete_button,
                  icon: Icon(
                    Icons.delete_outline_rounded, 
                    size: 20,
                    color: widget.theme.error
                  )
                ),
              ),
            )
        ],
      ),
    );
  }
}

class NodeEditorBottomSheetSidePanelBox extends StatefulWidget {
  const NodeEditorBottomSheetSidePanelBox({super.key, required this.panel, required this.title, required this.buttonAction, required this.buttonTooltip, required this.child});

  final NodeEditorBottomSheetSidePanel panel;
  final String title;
  final String buttonTooltip;
  final Function buttonAction;
  final Widget child;

  @override
  State<NodeEditorBottomSheetSidePanelBox> createState() => _NodeEditorBottomSheetSidePanelBoxState();
}

class _NodeEditorBottomSheetSidePanelBoxState extends State<NodeEditorBottomSheetSidePanelBox> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 250,
          height: (widget.panel.height / 2) - 2.5, // Here we remove 5 for padding between containers,
          decoration: BoxDecoration(
            color: widget.panel.theme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.panel.theme.onSurface.withOpacity(0.2),
              width: 0.5
            )
          ),
          child: Column(
            children: [
              // Top with title and button
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: SizedBox(
                  width: 230,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      Text(
                        widget.title,
                        style: widget.panel.theme.titleMedium
                          .copyWith(
                            color: widget.panel.theme.onSurface,
                            fontSize: 20
                          ),
                      ),
                      // Button
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: IconButton(
                          onPressed: () async {
                            await widget.buttonAction();
                          }, 
                          tooltip: widget.buttonTooltip,
                          style: ButtonThemes.primaryButtonStyle(context),
                          icon: Icon(Icons.add_rounded, color: widget.panel.theme.onSecondary, size: 19)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: 240,
                    height: ((widget.panel.height / 2) - 2.5) - 56, // I don't know why 56 but it's the minimal for it to not create overflows
                    child: widget.child
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}