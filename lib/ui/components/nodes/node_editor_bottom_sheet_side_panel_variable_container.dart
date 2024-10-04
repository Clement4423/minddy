import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/node_tree_variable.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeEditorBottomSheetSidePanelVariableContainer extends StatefulWidget {
  const NodeEditorBottomSheetSidePanelVariableContainer({
    super.key,
    required this.variable,
    required this.onRename,
    required this.onTypeChanged,
    required this.theme,
    required this.deleteNodeTreeVariable
  });

  final NodeTreeVariable variable;
  final Function onRename;
  final Function onTypeChanged;
  final StylesGetters theme;
  final Function(int id) deleteNodeTreeVariable;

  @override
  State<NodeEditorBottomSheetSidePanelVariableContainer> createState() => _NodeEditorBottomSheetSidePanelVariableContainerState();
}

class _NodeEditorBottomSheetSidePanelVariableContainerState extends State<NodeEditorBottomSheetSidePanelVariableContainer> {

  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 40,
      decoration: BoxDecoration(
        color: widget.theme.primary,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 35,
            margin: const EdgeInsets.only(left: 3),
            decoration: BoxDecoration(
              color: widget.theme.surface,
              borderRadius: BorderRadius.circular(9)
            ),
            child: CustomSelectionMenu(
              theme: widget.theme, 
              enableSearch: true,
              menuMaxHeight: 250,
              buttonStyle: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                padding: WidgetStatePropertyAll(EdgeInsets.only(left: 7)),
                elevation: WidgetStatePropertyAll(0)
              ),
              items: NodeDataType.values.sublist(0, NodeDataType.values.length - 1).map((type) {
                return CustomSelectionMenuItem(
                  label: getCorrectNameBasedOnNodeDataType(type), 
                  foregroundColor: widget.variable.type == type ? widget.theme.secondary : null,
                  icon: _getCorrectIconBasedOnType(type), 
                  onTap: () {
                    setState(() {
                      widget.variable.type = type;
                      widget.onTypeChanged();
                    });
                  }
                );
              }).toList(),
              child: Row(
                children: [
                  Icon(_getCorrectIconBasedOnType(widget.variable.type), color: widget.theme.onSurface),
                  Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface)
                ],
              )
            )
          ),
          Expanded(
            child: TextSelectionTheme(
              data: TextSelectionThemeData(selectionColor: widget.theme.secondary),
              child: TextField(
                onChanged: (value) {
                  widget.variable.name = value;
                },
                onEditingComplete: () {
                  focusNode.unfocus();
                  widget.onRename();
                },
                onTapOutside: (event) {
                  focusNode.unfocus();
                  widget.onRename();
                },
                focusNode: focusNode,
                controller: TextEditingController(text: widget.variable.name),
                cursorColor: widget.theme.onPrimary,
                style: widget.theme.bodyMedium
                .copyWith(
                  color: widget.theme.onPrimary,
                  fontWeight: FontWeight.w500
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 7, left: 15),
                  hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                  hintStyle: widget.theme.bodyMedium
                  .copyWith(
                    color: widget.theme.onPrimary,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: SizedBox(
              width: 35,
              height: 35,
              child: IconButton(
                onPressed: () {
                  widget.deleteNodeTreeVariable(widget.variable.id);
                },
                style: ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
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

String getCorrectNameBasedOnNodeDataType(NodeDataType type) {
  switch (type) {
    case NodeDataType.any:
      return S.current.node_editor_view_side_panel_variables_variable_type_any;
    case NodeDataType.number:
      return S.current.node_editor_view_side_panel_variables_variable_type_number;
    case NodeDataType.string:
      return S.current.node_editor_view_side_panel_variables_variable_type_text;
    case NodeDataType.boolean:
      return S.current.node_editor_view_side_panel_variables_variable_type_boolean;
    case NodeDataType.list:
      return S.current.node_editor_view_side_panel_variables_variable_type_list;
    case NodeDataType.color:
      return S.current.node_editor_view_side_panel_variables_variable_type_color;
  }
}

IconData _getCorrectIconBasedOnType(NodeDataType type) {
  switch (type) {
    case NodeDataType.any:
      return Icons.error_outline_rounded;
    case NodeDataType.number:
      return Icons.numbers_rounded;
    case NodeDataType.string:
      return Icons.text_fields_rounded;
    case NodeDataType.boolean:
      return Icons.check_box_outlined;
    case NodeDataType.list:
      return Icons.list_rounded;
    case NodeDataType.color:
      return Icons.color_lens_outlined;
  }
}