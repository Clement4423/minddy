import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/utils/column_letters.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableCell extends StatefulWidget {
  final CustomTableController controller;
  final CustomTableCellPosition position;
  final ICustomTableCellData child;
  final StylesGetters theme;  
  final double height;
  final double width;

  const CustomTableCell({
    super.key,
    required this.controller,
    required this.position,
    required this.child,
    required this.theme,
    required this.height, 
    required this.width,
  });

  @override
  State<CustomTableCell> createState() => _CustomTableCellState();
}

class _CustomTableCellState extends State<CustomTableCell> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.updateCell(widget.position, widget.child.data);
    });

    return Listener(
      onPointerUp: (event) {
        try {
          if (widget.controller.isExtendingCells && widget.controller.selectedCellsForExtension.first == widget.position) {
            widget.controller.isExtendingCells = false;
            if (widget.controller.selectedCellsForExtension.length > 1) {
              widget.controller.extendCellData(widget.position, widget.controller.selectedCellsForExtension);
            } else {
              setState(() {});
            }
            widget.controller.selectedCellsForExtension.clear();
          }  
        } catch (e) {
          return;
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          try {
            if (widget.controller.isExtendingCells) {
              setState(() {
                if (widget.controller.selectedCellsForExtension.contains(widget.position)) {
                  widget.controller.selectedCellsForExtension.removeLast();
                } else {
                  if (widget.position.column == widget.controller.selectedCellsForExtension.first.column) {
                    widget.controller.selectedCellsForExtension.add(widget.position);
                  }
                }
                if (widget.controller.selectedCellsForExtension.first == widget.position) {
                  isHovering = true;
                }
              });
            } else {
              setState(() {
                isHovering = true;
              });
            }
          } catch (e) {
            widget.controller.selectedCellsForExtension.clear();
            widget.controller.isExtendingCells = false;
            widget.controller.rebuildWholeTable();
            return;
          }
        },
        onExit: (event) {
          try {
            setState(() {
              isHovering = false;
            });
          } catch (e) {
            return;
          }
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.theme.surface,
            border: Border.all(
              color: widget.controller.selectedCellsForExtension.contains(widget.position) 
                ? widget.theme.secondary 
                : widget.theme.onSurface, 
              width: widget.controller.selectedCellsForExtension.contains(widget.position) 
                ? 1.25 
                : 0.25,
            ),
            borderRadius: widget.position.column == widget.controller.columns && widget.position.row == widget.controller.rows 
              ? const BorderRadius.only(bottomRight: Radius.circular(10))
              : null,
          ),
          child: Stack(
            children: [
              widget.child,
              if (isHovering && widget.controller.needToShowPosition == false && widget.controller.rows > 1)
                Positioned(
                  top: widget.position.row == widget.controller.rows ? 5 : null,
                  bottom: widget.position.row == widget.controller.rows ? null : 5,
                  left: widget.width / 2,
                  child: GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        widget.controller.isExtendingCells = true;
                        widget.controller.selectedCellsForExtension.add(widget.position);
                      });
                    },
                    child: _CellExtendButton(widget.theme, widget.position, widget.controller.rows),
                  ),
                ),
              if (
                widget.controller.needToShowPosition 
                && widget.controller.getColumnType(widget.position.column) != null 
                && widget.controller.getColumnType(widget.position.column) == CustomTableType.number 
                && widget.controller.hiddenPositionCell != null 
                && widget.position != widget.controller.hiddenPositionCell
              )
                Align(
                  alignment: Alignment.centerLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        try {
                          if (widget.controller.currentNumberTextEditingController != null) {
                            if (widget.controller.currentNumberTextEditingController!.text.characters.last == ')') {
                              widget.controller.currentNumberTextEditingController!.text += '+';
                            }
                            widget.controller.currentNumberTextEditingController!.text += '(${getColumnLetter(widget.position.column - 1)}${widget.position.row})';
                          }                          
                        } catch (e) {
                          return;
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: widget.theme.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${getColumnLetter(widget.position.column - 1)}${widget.position.row}',
                            style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSecondary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class _CellExtendButton extends StatelessWidget {
  const _CellExtendButton(this.theme, this.position, this.totalRows);

  final CustomTableCellPosition position;
  final int totalRows;

  final StylesGetters theme;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: position.row == totalRows ? SystemMouseCursors.resizeUp : position.row == 1 ? SystemMouseCursors.resizeDown : SystemMouseCursors.resizeUpDown,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(3)
        ),
      ),
    );
  }
}