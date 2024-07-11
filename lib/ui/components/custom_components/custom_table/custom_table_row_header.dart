import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableRowHeader extends StatefulWidget {
  const CustomTableRowHeader({
    super.key,
    required this.widget,
    required this.theme,
    required this.rowIndex,
    required this.deleteRowMethod,
  });

  final CustomTable widget;
  final StylesGetters theme;
  final int rowIndex;
  final Function(int) deleteRowMethod;

  @override
  State<CustomTableRowHeader> createState() => _CustomTableRowHeaderState();
}

class _CustomTableRowHeaderState extends State<CustomTableRowHeader> {
  bool isHovering = false;
  bool isPressed = false;

  bool canBeDeleted = true;

  void triggerPopEffect() {
    if (canBeDeleted) {
      setState(() {
        isPressed = true;
      });
    }
  }

  void endPopEffect() {
    if (canBeDeleted) {
      setState(() {
        isPressed = false;
      });
    }
  }

  @override
  void initState() {
    canBeDeleted = widget.widget.controller.rows > 1 
      ? true 
      : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (canBeDeleted) {
          setState(() {
            isHovering = true;
          });
        }
      },
      onExit: (event) {
        if (canBeDeleted) {
          setState(() {
            isHovering = false;
          });
        }
      },
      child: Container(
        height: widget.widget.cellHeight,
        decoration: BoxDecoration(
          color: widget.theme.surface,
          border: Border.all(color: widget.theme.onSurface, width: 0.5),
          borderRadius: widget.rowIndex == widget.widget.controller.rows
              ? const BorderRadius.only(bottomLeft: Radius.circular(10))
              : null,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: isHovering ? 1 : 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: isHovering ? 24 : 0,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: isHovering ? (isPressed ? 0.8 : 0.9) : 1.0,
                      end: isHovering ? (isPressed ? 0.8 : 1.0) : 0.9,
                    ),
                    duration: const Duration(milliseconds: 100),
                    builder: (context, size, child) {
                      return Transform.scale(
                        scale: size,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTapDown: (details) {
                              triggerPopEffect();
                            },
                            onTapUp: (details) {
                              endPopEffect();
                              widget.deleteRowMethod(widget.rowIndex);
                            },
                            onTapCancel: () {
                              endPopEffect();
                            },
                            child: Tooltip(
                              message: S.of(context).projects_module_spreadsheet_delete_row,
                              child: Icon(Icons.delete_outline_rounded, color: widget.theme.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 100),
                padding: EdgeInsets.only(left: isHovering ? 4 : 8),
                child: CustomTooltip(
                  message: widget.widget.controller.getRowName(widget.rowIndex) ?? '',
                  lengthTreshold: 24,
                  child: TextField(
                    onChanged: (newValue) {
                      widget.widget.controller.setRowName(widget.rowIndex, newValue);
                    },
                    controller: TextEditingController(text: widget.widget.controller.getRowName(widget.rowIndex)),
                    style: widget.theme.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    cursorColor: widget.theme.onSurface,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).projects_module_spreadsheet_value_unnamed
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}