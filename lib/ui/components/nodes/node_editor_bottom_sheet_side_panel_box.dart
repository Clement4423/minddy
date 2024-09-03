import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel.dart';
import 'package:minddy/ui/theme/theme.dart';

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