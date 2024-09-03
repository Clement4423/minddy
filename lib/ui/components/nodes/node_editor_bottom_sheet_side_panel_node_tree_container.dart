import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/nodes/node_widget_tree.dart';
import 'package:minddy/ui/theme/theme.dart';

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
              child: TextSelectionTheme(
                data: TextSelectionThemeData(selectionColor: widget.isSelected ? widget.theme.onPrimary : widget.theme.secondary),
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
                    hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                    hintStyle: widget.theme.bodyMedium
                    .copyWith(
                      color: widget.isSelected 
                      ? widget.theme.onSecondary
                      : widget.theme.onPrimary,
                      fontWeight: FontWeight.w500
                    ),
                  ),
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
