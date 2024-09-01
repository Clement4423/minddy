import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet.dart';
import 'package:minddy/ui/components/nodes/nodes_connections_painter.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/plugin_editor_view_model.dart';

class PluginEditorView extends StatefulWidget {
  const PluginEditorView({super.key, required this.viewModel});

  final PluginEditorViewModel viewModel;

  @override
  State<PluginEditorView> createState() => _PluginEditorViewState();
}

class _PluginEditorViewState extends State<PluginEditorView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    Size appWindowSize = MediaQuery.of(context).size;

    Offset maxOffset = Offset(appWindowSize.width * 3, appWindowSize.height * 2);

    return Container(
      decoration: BoxDecoration(
        color: theme.primary,
        image: DecorationImage(
          image: AssetImage(
            AppTheme.isUsingBWMode
              ? theme.brightness == Brightness.light
                ? "assets/background/background_project_grey.png"
                : "assets/background/background_project_dark.png"
              : theme.brightness == Brightness.light
                ? "assets/background/background_project_blue.PNG"
                : "assets/background/background_project_blue_dark.PNG"
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          CustomAppBarController(
            widget.viewModel.pluginInfo.name,
            true,
            [
              CustomAppBarButtonModel(
                icon: Icons.settings_rounded,
                semanticText: S.of(context).settings_title,
                isPrimary: false,
                action: () async {await showSettings(context);},
              ),
              CustomAppBarButtonModel(
                icon: Icons.play_arrow_rounded,
                semanticText: "Try",
                isPrimary: true,
                action: () {},
              ),
            ],
            homeButtonIcon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary),
            onHomeButtonPressed: () async => await widget.viewModel.savePlugin()
          )
        ),
        body: FutureBuilder(
          future: widget.viewModel.initialize(maxOffset, theme),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: NodeEditorBottomSheet(controller: widget.viewModel.bottomSheetController, theme: theme)
                ),
              ],
            );
            } else {
              return const SizedBox();
            }
          }
        )
      ),
    );
  }
}

// ignore: must_be_immutable
class MathNodeWidget extends StatefulWidget implements INodeWidget {
  MathNodeWidget({
    super.key,
    required this.node,
    required this.position,
    required this.maxOffset,
    required this.theme,
    required this.getIsDragging,
    required this.setSelectedPort,
    required this.getSelectedPort,
    required this.setIsDragging,
    required this.addConnection,
    required this.getConnections,
    required this.updateConnections,
    required this.getSelectedNodes,
    required this.setSelectedNode,
    required this.updateNode,
    required this.saveState
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
      getIsDragging: getIsDragging, 
      setSelectedPort: setSelectedPort, 
      getSelectedPort: getSelectedPort, 
      setIsDragging: setIsDragging, 
      addConnection: addConnection, 
      getConnections: getConnections, 
      updateConnections: updateConnections, 
      getSelectedNodes: getSelectedNodes, 
      setSelectedNode: setSelectedNode, 
      updateNode: updateNode, 
      saveState: saveState
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
  static MathNodeWidget fromJson(GlobalKey key, String json, Offset maxOffset, StylesGetters theme, Function(NodePortInfo? info) setSelectedPort, bool Function() getIsDragging, Function(bool) setIsDragging, Function(NodePortInfo) addConnection, NodePortInfo? Function() getSelectedPort, List<NodeConnection> Function() getConnections, Function updateConnections, List<INodeWidget> Function() getSelectedNodes, Function(List<INodeWidget>) setSelectedNode, Function(INodeWidget) updateNode, Function saveState) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MathNodeWidget(
      key: key,
      node: MathNode().fromJson(data['node']) as MathNode,
      position: Offset(data['positionX'], data['positionY']),
      maxOffset: maxOffset,
      setSelectedPort: setSelectedPort,
      getSelectedPort: getSelectedPort,
      getIsDragging: getIsDragging,
      setIsDragging: setIsDragging,
      addConnection: addConnection,
      getConnections: getConnections,
      updateConnections: updateConnections,
      setSelectedNode: setSelectedNode,
      getSelectedNodes: getSelectedNodes,
      saveState: saveState,
      updateNode: updateNode,
      theme: theme,
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
  bool Function() getIsDragging;
  
  @override
  Function(NodePortInfo? info) setSelectedPort;
  
  @override
  Function(NodePortInfo info) addConnection;
  
  @override
  Function(bool isDragging) setIsDragging;

  @override
  NodePortInfo? Function() getSelectedPort;

  @override
  List<NodeConnection> Function() getConnections;

  @override
  List<INodeWidget> Function() getSelectedNodes;

  @override
  Function(List<INodeWidget>) setSelectedNode;

  @override
  Function updateConnections;

  @override
  Function saveState;

  @override
  Function(INodeWidget) updateNode;
}

class _MathNodeWidgetState extends State<MathNodeWidget> {
  Offset? _draggingStartPort;  // Start port position
  Offset? _currentCursorOffset; // Current cursor position

  final int _outputOffsetsMaxLength = 1;

  final int _inputsOffsetsMaxLength = 2;

  bool isDraggingWithMouse = true;

  bool isDraggingStartPortFromAnotherPort = false;
  NodePortInfo? inputPortInfo;

  bool isSelected = false;
  bool isLastSelected = false;

  bool isDragging = false;

  void setOffset(Offset offset, NodePortInfo portInfo) {
    if (portInfo.type == NodePortType.input && !initializedInputsOffsets) {
      widget.inputsOffsets.add(offset);

      if (widget.inputsOffsets.length == _inputsOffsetsMaxLength) {
        initializedInputsOffsets = true;
      }
    } else if (!initializedOutputsOffsets) {
      widget.outputsOffsets.add(offset);

      if (widget.outputsOffsets.length == _outputOffsetsMaxLength) {
        initializedOutputsOffsets = true;
      }
    }
  }

  bool initializedOutputsOffsets = false;
  bool initializedInputsOffsets = false;

  void verifyPosition(INodeWidget w) {
    double maxDx = (w.maxOffset.dx - w.width).clamp(0.0, double.infinity);
    double maxDy = (w.maxOffset.dy - w.height).clamp(0.0, double.infinity);

    double dx = w.position.dx.clamp(0.0, maxDx);
    double dy = w.position.dy.clamp(0.0, maxDy);

    Offset clampedPosition = Offset(dx, dy);
    w.position = clampedPosition;
    widget.updateNode(w);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!isDraggingWithMouse) {
      return;
    }
    List<INodeWidget> selectedNodes = widget.getSelectedNodes();
    Offset delta = details.delta;

    for (INodeWidget w in selectedNodes) {
      w.position += delta;
      verifyPosition(w);
    }
  }

  void _setStartDraggingPoint(int? index, NodePortType? portType, [INodeWidget? otherNode, NodePortInfo? inputPort]) {
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
        _draggingStartPort = nodeWidget.inputsOffsets[index] + nodeWidget.position;
        break;
      case NodePortType.output:
        _draggingStartPort = nodeWidget.outputsOffsets[index] + nodeWidget.position;
        break;
    }
  }

  void _handleTapDown() {
    List<INodeWidget> selectedNodes = widget.getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
    if (!selectedNodes.contains(widget) && selectedNodes.length == 1 && !isShiftPressed) {
      selectedNodes.clear();
      selectedNodes.add(widget);
    } else if (!selectedNodes.contains(widget) && isShiftPressed) {
      selectedNodes.add(widget);
    } else if (isShiftPressed) {
      if (selectedNodes.indexOf(widget) == selectedNodes.length - 1) {
        selectedNodes.remove(widget);
      } else {
        selectedNodes.remove(widget);
        selectedNodes.add(widget);
      }
    }
    widget.setSelectedNode(selectedNodes);
  }

  void _handleTapUp() {
    List<INodeWidget> selectedNodes = widget.getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

    if (!selectedNodes.contains(widget) && !isShiftPressed) {
      if (!isShiftPressed) {
        selectedNodes.clear();
      }
      selectedNodes.add(widget);
      isSelected = true;
    } else if (selectedNodes.contains(widget) && selectedNodes.length > 1 && !isShiftPressed) {
      selectedNodes.clear();
      selectedNodes.add(widget);
    }

    widget.setSelectedNode(selectedNodes);
  }

  _setAsSelectedIfNotAlready() {
    List<INodeWidget> selectedNodes = widget.getSelectedNodes();
    bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
    if (!selectedNodes.contains(widget)) {

      if (!isShiftPressed) {
        selectedNodes.clear();
      }

      selectedNodes.add(widget);
      widget.setSelectedNode(selectedNodes);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<INodeWidget> selectedNodesList = widget.getSelectedNodes(); 
    isSelected = selectedNodesList.contains(widget);
    isLastSelected = isSelected ? selectedNodesList.last == widget : false;
    Offset draggingStartPortOffset = _draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    return Positioned(
      top: widget.position.dy,
      left: widget.position.dx,
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
              _setAsSelectedIfNotAlready();
            } else {
              isDraggingWithMouse = false;
            }
          },
          onPanUpdate: _onDragUpdate,
          onPanEnd: (details) {
            setState(() {
              isDraggingWithMouse = true;
              isDragging = false;  
              widget.saveState();            
            });
          },
          onTapDown: (details) {_handleTapDown();},
          onTapUp: (details) {_handleTapUp();},
          // Whole node
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.theme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.theme.shadow.withOpacity(0.05),
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
                      width: widget.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                        ),
                        color: DefaultAppColors.mintGreen.color
                      ),
                      child: Center(
                        // Node title
                        child: Text(
                          "Math operation", 
                          style: widget.theme.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                            color: Colors.white
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    // Output.s
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 15,
                        width: widget.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Value", 
                              style: widget.theme.titleMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                color: widget.theme.onPrimary
                              ),
                              maxLines: 1,
                            ),
                            Transform.translate(
                              offset: const Offset(4, 0),
                              child: NodePortWidget(
                                portInfo: NodePortInfo(node: widget, type: NodePortType.output, portIndex: 0), 
                                color: DefaultAppColors.mintGreen.color,
                                onHoveredColor: widget.theme.onSurface,
                                setSelectedPort: widget.setSelectedPort,
                                getNodesConnections: widget.getConnections,
                                updateConnections: widget.updateConnections,
                                setOffset: setOffset,
                                saveState: widget.saveState,
                                setIsDragging: widget.setIsDragging,
                                setDragStartingPort: _setStartDraggingPoint,
                                setCursorPosition: (offset) {setState(() {
                                  _currentCursorOffset = offset;
                                });}, 
                                finalizeConnection: widget.addConnection,
                                getIsDragging: widget.getIsDragging,
                              )
                            )
                          ],
                        )
                      ),
                    ),
                    // Math operation selector
                    Container(
                      height: 20,
                      width: widget.width - 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.theme.surface
                      ),
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.only(left: 5),
                      child: DropdownButton(
                        hint: Text(
                          widget.node.operationType.name, 
                          style: widget.theme.titleMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                            color: widget.theme.onPrimary
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        iconSize: 18,
                        borderRadius: BorderRadius.circular(13),
                        menuMaxHeight: widget.height * 2,
                        menuWidth: widget.width * 2,
                        onChanged: (type) => setState(() {widget.node.operationType = type ?? MathNodeType.addition; widget.saveState();}),
                        underline: const SizedBox(),
                        icon: Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface),
                        dropdownColor: widget.theme.primary,
                        isExpanded: true,
                        items: [
                          ...MathNodeType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  type.name,
                                  style: widget.theme.bodyMedium
                                  .copyWith(
                                    color: widget.theme.onPrimary, 
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            );
                          })
                        ], 
                      ),
                    ),
                    // Input.s
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 15,
                        width: widget.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-4, 0),
                              child: NodePortWidget(
                                portInfo: NodePortInfo(node: widget, type: NodePortType.input, portIndex: 0), 
                                color: DefaultAppColors.mintGreen.color,
                                onHoveredColor: widget.theme.onSurface,
                                getNodesConnections: widget.getConnections,
                                updateConnections: widget.updateConnections,
                                setOffset: setOffset,
                                saveState: widget.saveState,
                                setSelectedPort: widget.setSelectedPort,
                                setIsDragging: widget.setIsDragging,
                                setDragStartingPort: _setStartDraggingPoint,
                                setCursorPosition: (offset) {setState(() {
                                  _currentCursorOffset = offset;
                                });}, 
                                finalizeConnection: widget.addConnection,
                                getIsDragging: widget.getIsDragging,
                              )
                            ),
                            Text(
                              "Value", 
                              style: widget.theme.titleMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                color: widget.theme.onPrimary
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 15,
                        width: widget.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-4, 0),
                              child: NodePortWidget(
                                portInfo: NodePortInfo(node: widget, type: NodePortType.input, portIndex: 1), 
                                color: DefaultAppColors.mintGreen.color,
                                onHoveredColor: widget.theme.onSurface,
                                setSelectedPort: widget.setSelectedPort,
                                setIsDragging: widget.setIsDragging,
                                getNodesConnections: widget.getConnections,
                                updateConnections: widget.updateConnections,
                                saveState: widget.saveState,
                                setOffset: setOffset,
                                setDragStartingPort: _setStartDraggingPoint,
                                setCursorPosition: (offset) {setState(() {
                                  _currentCursorOffset = offset;
                                });}, 
                                finalizeConnection: widget.addConnection,
                                getIsDragging: widget.getIsDragging,
                              )
                            ),
                            Text(
                              "Value", 
                              style: widget.theme.titleMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                color: widget.theme.onPrimary
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ),
                    )
                  ],
                ),
              ),
              if (_currentCursorOffset != null)
                Builder(
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
                        plusSignColor: widget.theme.onSurface,
                        isHoveringANodePort: widget.getSelectedPort() != null
                      ),
                    );
                  }
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    required this.finalizeConnection, 
    required this.setSelectedPort, 
    required this.getIsDragging,
    required this.setIsDragging,
    required this.getNodesConnections,
    required this.updateConnections, 
    required this.setOffset,
    required this.saveState
  });

  final NodePortInfo portInfo;
  final Color color;
  final Color onHoveredColor;
  final Function(Offset?) setCursorPosition;
  final Function(int?, NodePortType?, [INodeWidget?, NodePortInfo?]) setDragStartingPort;
  final Function(NodePortInfo) finalizeConnection;
  final Function(NodePortInfo?) setSelectedPort;
  final bool Function() getIsDragging;
  final Function(bool) setIsDragging;
  final List<NodeConnection> Function() getNodesConnections;
  final Function updateConnections;
  final Function(Offset, NodePortInfo) setOffset;
  final Function saveState;

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
      for (NodeConnection c in widget.getNodesConnections()) {
        if (c.endNode == widget.portInfo.node && c.endInputIndex == widget.portInfo.portIndex) {
          connection = c;
        }
      }
    } else {
      for (NodeConnection c in widget.getNodesConnections()) {
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
    //convert
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
          if (widget.getIsDragging() && !startedIsDragging) {
            widget.setSelectedPort(widget.portInfo);
            isHovering = true;
          }
        });
      },
      onExit: (event) {
        setState(() {
          if (widget.getIsDragging() && !startedIsDragging || isHovering) {
            widget.setSelectedPort(null);
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
            widget.setIsDragging(true);

            widget.setDragStartingPort(
              connection!.startOutputIndex,
              NodePortType.output,
              connection!.startNode,
              widget.portInfo
            );

            connection!.startNode.node.targets.removeWhere((target) => target.node.id == widget.portInfo.node.node.id && target.inputIndex == widget.portInfo.portIndex);

            widget.updateConnections();
          } else {
            widget.setDragStartingPort(widget.portInfo.portIndex, widget.portInfo.type);
            widget.setIsDragging(true);
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
            if (connection != null) {
              await widget.finalizeConnection(
                NodePortInfo(
                  node: connection!.startNode, 
                  type: NodePortType.output, 
                  portIndex: connection!.startOutputIndex
                )
              );
            } else {
              await widget.finalizeConnection(widget.portInfo);
            }
            widget.setCursorPosition(null);
            widget.setDragStartingPort(null, null);
            widget.setIsDragging(false);
            startedIsDragging = false;
            _cursorDragOffset = const Offset(0, 0);
            setState(() {isHovering = false;});
            widget.saveState();
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