import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class ColumnTypeSelector extends StatefulWidget {
  const ColumnTypeSelector({
    super.key,
    required this.widget,
    required this.icon,
    required this.theme,
    required this.colIndex,
    required this.deleteColumnMethod,
  });

  final CustomTable widget;
  final Icon icon;
  final int colIndex;
  final Function(int) deleteColumnMethod;
  final StylesGetters theme;

  @override
  State<ColumnTypeSelector> createState() => _ColumnTypeSelectorState();
}

class _ColumnTypeSelectorState extends State<ColumnTypeSelector> {
  bool isHovering = false;
  bool isPressed = false;
  bool canBeDeleted = true;
  CustomTableType? actualType;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    actualType = widget.widget.controller.getColumnType(widget.colIndex);
    canBeDeleted = widget.widget.controller.columns > 1;
    _initializeTextController();
  }

  void _initializeTextController() {
    _textEditingController.text = widget.widget.controller.columnNames[widget.colIndex] ?? '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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

  void _updateState({bool? setIsHovering}) {
    bool needToRequestFocus = _focusNode.hasFocus;
    TextSelection currentSelection = _textEditingController.selection;

    setState(() {
      if (setIsHovering != null) {
        isHovering = setIsHovering;
      }
    });

    if (needToRequestFocus) {
      _focusNode.requestFocus();
      _textEditingController.selection = currentSelection;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (canBeDeleted) {
          _updateState(setIsHovering: true);
        }
      },
      onExit: (event) {
        if (canBeDeleted) {
          _updateState(setIsHovering: false);
        }
      },
      child: Container(
        height: widget.widget.cellHeight,
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: widget.theme.surface,
          border: Border.all(color: widget.theme.onSurface, width: 0.5),
          borderRadius: widget.colIndex == widget.widget.controller.columns
            ? const BorderRadius.only(topRight: Radius.circular(10))
            : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: canBeDeleted ? SystemMouseCursors.click : SystemMouseCursors.basic,
              child: GestureDetector(
                onTapDown: (details) {
                  triggerPopEffect();
                },
                onTapUp: (details) {
                  endPopEffect();
                  if (canBeDeleted) {
                    widget.deleteColumnMethod(widget.colIndex);
                  }
                },
                onTapCancel: () {
                  endPopEffect();
                },
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: isHovering ? isPressed ? 0.8 : 0.9 : 1.0,
                    end: isHovering ? isPressed ? 0.8 : 1.0 : 0.9,
                  ),
                  duration: const Duration(milliseconds: 100),
                  builder: (context, size, child) {
                    return Transform.scale(
                      scale: size,
                      child: isHovering
                        ? Tooltip(
                            message: S.of(context).projects_module_spreadsheet_delete_column,
                            child: Icon(Icons.delete_outline_rounded, color: widget.theme.error),
                          )
                        : widget.icon 
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: CustomTooltip(
                message: widget.widget.controller.getColumnName(widget.colIndex) ?? '',
                lengthTreshold: 12,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      widget.widget.controller.setColumnName(widget.colIndex, value);
                    },
                    onEditingComplete: () {
                      _focusNode.unfocus();
                      _updateState();
                    },
                    style: widget.theme.titleMedium.copyWith(fontWeight: FontWeight.w600),
                    cursorColor: widget.theme.onSurface,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                    ),
                  ),
                ),
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface),
              onSelected: (value) {
                widget.widget.controller.setColumnType(widget.colIndex, value);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              color: widget.theme.primary,
              tooltip: S.of(context).projects_module_spreadsheet_data_choose_column_type_tooltip,
              itemBuilder: (context) {
                return CustomTableType.values.reversed.map((value) {
                  return PopupMenuItem(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          customTableNames[value] ?? '', 
                          style: actualType != null && value == actualType 
                            ? widget.theme.bodyMedium.copyWith(color: widget.theme.secondary) 
                            : widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary)
                        ),
                        Icon(
                          customTableIcons[value]!.icon ?? Icons.error_outline_rounded,
                          color: actualType != null && value == actualType
                            ? widget.theme.secondary
                            : widget.theme.onPrimary
                        ),
                      ],
                    ),
                  );
                }).followedBy(
                  [
                    PopupMenuItem(
                      enabled: false,
                      child: Text(
                        S.of(context).projects_module_spreadsheet_data_column_type,
                        style: widget.theme.titleMedium,
                      )
                    )
                  ]
                ).toList().reversed.toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}