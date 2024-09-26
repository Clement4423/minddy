import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/node_tree_variable.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel_box.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel_node_tree_container.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel_variable_container.dart';
import 'package:minddy/ui/theme/theme.dart';

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

  bool isFirstCreation = true;

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
        begin: isFirstCreation ? 255.0 : isClosed ? 0.0 : 255.0,
        end: isFirstCreation ? 255.0 : isClosed ? 255.0 : 0.0,
      ),
      builder: (context, translate, child) {
        if (isFirstCreation) {
          isFirstCreation = false;
        }
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
                          key: UniqueKey(),
                          panel: widget, 
                          title: S.of(context).node_editor_view_side_panel_variables_title, 
                          buttonTooltip: S.of(context).node_editor_view_side_panel_variables_add_button_tooltip,
                          buttonAction: () {
                            widget.controller.addNodeTreeVariable(
                              NodeTreeVariable(
                                name: '', 
                                type: NodeDataType.number, 
                                id: createUniqueId()
                              )
                            );
                          },
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount: widget.controller.variables.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: NodeEditorBottomSheetSidePanelVariableContainer(
                                  variable: widget.controller.variables[index], 
                                  theme: widget.theme, 
                                  deleteNodeTreeVariable: widget.controller.deleteNodeTreeVariable
                                )
                              );
                            }
                          )
                        ),
                        NodeEditorBottomSheetSidePanelBox(
                          key: UniqueKey(),
                          panel: widget, 
                          title: S.of(context).node_editor_view_side_panel_node_trees_title, 
                          buttonTooltip: S.of(context).node_editor_view_side_panel_node_trees_add_button_tooltip,
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
                      message: isClosed 
                        ? S.of(context).node_editor_view_open_side_panel_tooltip 
                        : S.of(context).node_editor_view_close_side_panel_tooltip,
                      preferBelow: true,
                      verticalOffset: (widget.height / 5) / 2,
                      child: Container(
                        width: 40,
                        height: widget.height / 5,
                        constraints: const BoxConstraints(
                          minHeight: 90
                        ),
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
