import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/nodes/controllers/node_editor_bottom_sheet_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeEditorBottomSheetBottomToolbox extends StatefulWidget {
  const NodeEditorBottomSheetBottomToolbox({super.key, required this.controller, required this.theme});

  final NodeEditorBottomSheetController controller;
  final StylesGetters theme;

  @override
  State<NodeEditorBottomSheetBottomToolbox> createState() => _NodeEditorBottomSheetBottomToolboxState();
}

class _NodeEditorBottomSheetBottomToolboxState extends State<NodeEditorBottomSheetBottomToolbox> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 40,
          width: 225,
          decoration: BoxDecoration(
            color: widget.theme.primaryContainer,
            borderRadius: BorderRadius.circular(12.5),
            border: Border.all(
              color: widget.theme.onSurface.withOpacity(0.2),
              width: 0.5
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Undo button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.state.canUndo()
                    ? () {widget.controller.undo();} 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_undo_tooltip_mac 
                      : S.of(context).node_editor_view_bottom_toolbar_undo_tooltip_windows,
                  icon: Icon(
                    Icons.undo_rounded, 
                    color: widget.controller.state.canUndo() 
                      ? widget.theme.onPrimary 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
                  )
                ),
              ),
              // Redo button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.state.canRedo()
                    ? () {widget.controller.redo();} 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_redo_tooltip_mac 
                      : S.of(context).node_editor_view_bottom_toolbar_redo_tooltip_windows,
                  icon: Icon(
                    Icons.redo_rounded, 
                    color: widget.controller.state.canRedo() 
                      ? widget.theme.onPrimary 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
                  )
                ),
              ),
              // Copy button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.selectedNodes.isNotEmpty
                    ? () {widget.controller.copySelectedNodes();} 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_copy_tooltip_mac(widget.controller.selectedNodes.length)
                      : S.of(context).node_editor_view_bottom_toolbar_copy_tooltip_windows(widget.controller.selectedNodes.length),
                  icon: Icon(
                    Icons.copy_all_rounded, 
                    color: widget.controller.selectedNodes.isNotEmpty
                      ? widget.theme.onPrimary 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
                  )
                ),
              ),
              // Paste button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.state.copiedNodes.isNotEmpty
                    ? () {widget.controller.pasteCopiedNodes();} 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_paste_tooltip_mac(widget.controller.state.copiedNodes.length)
                      : S.of(context).node_editor_view_bottom_toolbar_paste_tooltip_windows(widget.controller.state.copiedNodes.length),
                  icon: Icon(
                    Icons.paste_rounded, 
                    color: widget.controller.state.copiedNodes.isNotEmpty
                      ? widget.theme.onPrimary 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
                  )
                ),
              ),
              // Duplicate button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.selectedNodes.isNotEmpty
                    ? () {
                      widget.controller.copySelectedNodes();
                      widget.controller.pasteCopiedNodes();
                      widget.controller.state.copiedNodes.clear();
                    } 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_duplicate_tooltip_mac(widget.controller.selectedNodes.length) 
                      : S.of(context).node_editor_view_bottom_toolbar_duplicate_tooltip_windows(widget.controller.selectedNodes.length),
                  icon: Icon(
                    Icons.copy_rounded, 
                    color: widget.controller.selectedNodes.isNotEmpty
                      ? widget.theme.onPrimary 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
                  )
                ),
              ),
              // Delete button
              SizedBox(
                width: 35,
                height: 35,
                child: IconButton(
                  onPressed: widget.controller.selectedNodes.isNotEmpty
                    ? () {
                      widget.controller.deleteSelectedNodes();
                    } 
                    : null,
                  style: ButtonThemes.secondaryButtonStyle(context),
                  tooltip: Platform.isMacOS 
                      ? S.of(context).node_editor_view_bottom_toolbar_delete_tooltip_mac(widget.controller.selectedNodes.length)
                      : S.of(context).node_editor_view_bottom_toolbar_delete_tooltip_windows(widget.controller.selectedNodes.length),
                  icon: Icon(
                    Icons.delete_outline_rounded, 
                    color: widget.controller.selectedNodes.isNotEmpty
                      ? widget.theme.error 
                      : widget.theme.onPrimary.withOpacity(0.5),
                    size: 19,
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