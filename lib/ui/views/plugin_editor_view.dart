import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/all_nodes/math_node.dart';
import 'package:minddy/system/nodes/logic/node_types_interfaces.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_port_widget.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_body.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_dropdown.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_informations.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_input.dart';
import 'package:minddy/ui/components/nodes/all_nodes_widgets/nodes_widgets_components/node_widget_output.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet.dart';
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
    widgetInformations = NodeWidgetInformations(widget: widget, setState: setState);
    widget.functions.verifyPosition(widget);
    widget.functions.verifyInputs(widget);
    widgetInformations.needToBeSmaller = typesThatOnlyNeedOneInput.contains(widget.node.operationType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset draggingStartPortOffset = widgetInformations.draggingStartPort?.translate(-widget.position.dx, -widget.position.dy) ?? const Offset(0, 0);
    return NodeWidgetBody(
      nodeTitle: 'Math operation', 
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
          setCursorPosition: (offset) {setState(() {
            widgetInformations.currentCursorOffset = offset;
          });}, 
          theme: widget.theme, 
          label: "Value", 
          type: widget.node.outputsTypes.elementAt(0),
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
          String firstLetter = type.name.characters.first;
          return '${firstLetter.toUpperCase()}${type.name.substring(1).toLowerCase()}';
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
          setCursorPosition: (offset) {setState(() {
            widgetInformations.currentCursorOffset = offset;
          });}, 
          theme: widget.theme, 
          isConnected: widget.functions.isPortAlreadyHaveConnection(0, NodePortType.input, widget),
          connectedLabel: "Value", 
          type: widget.node.inputsTypes.elementAt(0), 
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
            setCursorPosition: (offset) {setState(() {
              widgetInformations.currentCursorOffset = offset;
            });}, 
            theme: widget.theme, 
            isConnected: widget.functions.isPortAlreadyHaveConnection(1, NodePortType.input, widget), 
            connectedLabel: "Value", 
            type: widget.node.inputsTypes.elementAt(1), 
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