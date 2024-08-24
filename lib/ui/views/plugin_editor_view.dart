import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
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
    required this.updateConnections
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
  String toJson() {
    return jsonEncode({
      'node': node.toJson(),
      'widget_type': runtimeType.toString(),
      'positionX': position.dx,
      'positionY': position.dy
    });
  }

  // Static method to deserialize from JSON
  static MathNodeWidget fromJson(String json, Offset maxOffset, StylesGetters theme, Function(NodePortInfo? info) setSelectedPort, bool Function() getIsDragging, Function(bool) setIsDragging, Function(NodePortInfo) addConnection, NodePortInfo? Function() getSelectedPort, List<NodeConnection> Function() getConnections, Function updateConnections) {
    final Map<String, dynamic> data = jsonDecode(json);

    return MathNodeWidget(
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
  Function updateConnections;
}

class _MathNodeWidgetState extends State<MathNodeWidget> {
  late Offset _dragOffset;
  Offset? _draggingStartPort;  // Start port position
  Offset? _currentCursorOffset; // Current cursor position

  bool isDraggingStartPortFromAnotherPort = false;
  NodePortInfo? inputPortInfo;

  @override
  void initState() {
    super.initState();
    _dragOffset = widget.position;
  }

  void _calculatePortCenters() {
    // Clear previous offsets
    widget.inputsOffsets.clear();
    widget.outputsOffsets.clear();

    // Relative positions within the widget
    double outputPortOffsetX = widget.width - 4; // Right edge minus container width minus extra space
    double outputPortOffsetY = 15 + 5 + 7.5; // Top part height + Padding + half of output port container height

    double inputPort1OffsetX = -4; // Start offset
    double inputPort1OffsetY = 15 + 5 + 20 + 5 + 7.5; // Top part height + Padding + Math operation container height + Padding + half of input port container height

    double inputPort2OffsetX = -4; // Start offset
    double inputPort2OffsetY = 15 + 5 + 20 + 5 + 15 + 5 + 7.5; // Similar calculation as inputPort1OffsetY

    // Calculate absolute center positions
    Offset outputPortCenter = Offset(
      _dragOffset.dx + outputPortOffsetX + 4, // Adding half of the port width (8/2)
      _dragOffset.dy + outputPortOffsetY
    );

    Offset inputPort1Center = Offset(
      _dragOffset.dx + inputPort1OffsetX + 4, // Adding half of the port width (8/2)
      _dragOffset.dy + inputPort1OffsetY + 20
    );

    Offset inputPort2Center = Offset(
      _dragOffset.dx + inputPort2OffsetX + 4, // Adding half of the port width (8/2)
      _dragOffset.dy + inputPort2OffsetY + 20
    );

    // Store the calculated centers
    widget.outputsOffsets.add(outputPortCenter);
    widget.inputsOffsets.add(inputPort1Center);
    widget.inputsOffsets.add(inputPort2Center);
  }

  void verifyPosition() {
    double maxDx = (widget.maxOffset.dx - widget.width).clamp(0.0, double.infinity);
    double maxDy = (widget.maxOffset.dy - widget.height).clamp(0.0, double.infinity);

    double dx = _dragOffset.dx.clamp(0.0, maxDx);
    double dy = _dragOffset.dy.clamp(0.0, maxDy);

    Offset clampedPosition = Offset(dx, dy);
    _dragOffset = clampedPosition;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      verifyPosition();
      _calculatePortCenters();
    });
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
        _draggingStartPort = nodeWidget.inputsOffsets[index];
        break;
      case NodePortType.output:
        _draggingStartPort = nodeWidget.outputsOffsets[index];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _calculatePortCenters();
    Offset draggingStartPortOffset = _draggingStartPort?.translate(-_dragOffset.dx, -_dragOffset.dy) ?? const Offset(0, 0);
    return Positioned(
      top: _dragOffset.dy,
      left: _dragOffset.dx,
      child: GestureDetector(
        onPanUpdate: _onDragUpdate,
        onPanEnd: (details) {widget.position = _dragOffset;},
        // Whole node
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: widget.theme.primary,
                borderRadius: BorderRadius.circular(10),
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
                      onChanged: (type) => setState(() {widget.node.operationType = type ?? MathNodeType.addition;}),
                      underline: const SizedBox(),
                      icon: Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface),
                      dropdownColor: widget.theme.primary,
                      isExpanded: true,
                      items: [
                        ...MathNodeType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.name,
                              style: widget.theme.bodyMedium
                              .copyWith(
                                color: widget.theme.onPrimary, 
                                fontWeight: FontWeight.w500
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
                            transformHitTests: true,
                            child: NodePortWidget(
                              portInfo: NodePortInfo(node: widget, type: NodePortType.input, portIndex: 1), 
                              color: DefaultAppColors.mintGreen.color,
                              onHoveredColor: widget.theme.onSurface,
                              setSelectedPort: widget.setSelectedPort,
                              setIsDragging: widget.setIsDragging,
                              getNodesConnections: widget.getConnections,
                              updateConnections: widget.updateConnections,
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
                    cursorOffset = widget.inputsOffsets[inputPortInfo!.portIndex] - _dragOffset;
                  }
                  return CustomPaint(
                    painter: CurvedLinePainter(
                      start: draggingStartPortOffset,
                      end: _currentCursorOffset! + cursorOffset,
                      color: widget.theme.onSurface,
                      isHoveringANodePort: widget.getSelectedPort() != null
                    ),
                  );
                }
              ),
          ],
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
    required this.updateConnections
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

  @override
  State<NodePortWidget> createState() => _NodePortWidgetState();
}

class _NodePortWidgetState extends State<NodePortWidget> {
  bool isHovering = false;
  bool startedIsDragging = false;

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

  @override
  Widget build(BuildContext context) {
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
          if (widget.getIsDragging() && !startedIsDragging) {
            widget.setSelectedPort(null);
            isHovering = false;
          }
        });
      },
      child: GestureDetector(
        onPanStart: (details) {
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
          _cursorDragOffset += details.delta;
          widget.setCursorPosition(_cursorDragOffset);
        },
        onPanEnd: (details) async {
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

Offset substractOffset(Offset offset) {
  double dx = offset.dx - 3;
  double dy = offset.dy + 90;

  return Offset(dx, dy);
}