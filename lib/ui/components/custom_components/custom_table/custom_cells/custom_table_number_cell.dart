import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/number_value.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/system/utils/column_letters.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableNumberCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableNumberCell({super.key, required this.theme, required this.initialValue, required this.controller, required this.position}) {
    data = initialValue;
  }

  final dynamic initialValue;
  final CustomTableController controller;
  final StylesGetters theme;

  final CustomTableCellPosition position;

  @override
  var data = 0;

  @override
  State<CustomTableNumberCell> createState() => _CustomTableNumberCellState();
}

class _CustomTableNumberCellState extends State<CustomTableNumberCell> {

  bool isHovering = false;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  void _initializeTextController() {
    if (widget.initialValue != null) {
      if (widget.initialValue is String && widget.initialValue.toString().startsWith("=")) {
        _textEditingController.text = formatCalculation( _performCalculations());
      } else {
        _textEditingController.text = formatCalculation( widget.initialValue.toString().replaceAll('.', ','));
      }
    }
  }

  String _performCalculations() {
    if (widget.data.toString().contains('(${getColumnLetter(widget.position.column - 1)}${widget.position.row})')) {
      return ''; // Forbid to reference itself
    }
    NumberValue? result =  widget.controller.calculateExpression(widget.data.toString().replaceAll(',', '.'));
    if (result != null) {
      String finalString = '';
      if (result.currency != null) {
       finalString = result.currency == '\$' ? '${result.currency}${result.value.toStringAsFixed(2)}' : '${result.value.toStringAsFixed(2)}${result.currency}';
      } else if (result.isPercentage) {
        finalString = '${result.value}%';
      } else {
        finalString = result.value.toStringAsFixed(2);
      }

      return finalString.replaceAll('.', ',');
    } else {
      return '';
    }
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  
  _hidePositions() {
    widget.controller.needToShowPosition = false;
    widget.controller.currentNumberTextEditingController = null;
    widget.controller.hiddenPositionCell = null;
    widget.controller.usedPositions.clear();
    widget.controller.rebuildEveryNumbersCell();
  }

  List<CustomTableCellPosition> _getAlreadyUsedPosions() {
    RegExp regExp = RegExp(r'\([A-Z]+\d+\)');

    Iterable<Match> matches = regExp.allMatches(widget.data);
    List<String> extractedPositions = matches.map((match) => match.group(0)!).toList();

    List<CustomTableCellPosition> positions = [];

    if (extractedPositions.isNotEmpty) {
      for (String position in extractedPositions) {
        positions.add(widget.controller.parseCellPosition(position));
      }
    }

    return positions;
  }

  _showPositions() {
    widget.controller.needToShowPosition = true;
    widget.controller.currentNumberTextEditingController = _textEditingController;
    widget.controller.hiddenPositionCell = widget.position;
    widget.controller.usedPositions = _getAlreadyUsedPosions();
    widget.controller.rebuildEveryNumbersCell();
  }

  void _updateState({bool? setIsHovering, bool? setNeedToRequestFocus}) {
    bool needToRequestFocus = setNeedToRequestFocus ?? false;
     if (_focusNode.hasFocus && setNeedToRequestFocus == null) {
      needToRequestFocus = true;
    }
    setState(() {
      if (setIsHovering != null) {
        isHovering = setIsHovering;
      }
    });
    if (needToRequestFocus) {
      _focusNode.requestFocus();
      final cursorPosition = _textEditingController.selection;
      _textEditingController.selection = cursorPosition;
    }
  }

   @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _updateState(setIsHovering: true),
      onExit: (event) => _updateState(setIsHovering: false),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 5, right: 2),
            child: TextField(
              onChanged: (value) {
                if (value == '=') {
                  _showPositions();
                } else if (value == '') {
                  _hidePositions();
                }
                widget.data = value.replaceAll(',', '.');
                widget.controller.numbersChanged();
                _updateState();
              },
              onEditingComplete: () {
                if (_textEditingController.text.startsWith('=') && _textEditingController.text.length > 1) {
                  widget.data = _textEditingController.text;
                  _textEditingController.text = _performCalculations();
                }
                _hidePositions();
                widget.controller.rebuildWholeTable();
                _updateState();
              },
              focusNode: _focusNode,
              onTapOutside: (event) {
                if (widget.controller.currentNumberTextEditingController == _textEditingController) {
                  _focusNode.requestFocus();
                } else {
                  _focusNode.unfocus();
                  _hidePositions();
                }
                _updateState(setNeedToRequestFocus: false);
              },
              keyboardType: TextInputType.number,
              controller: _textEditingController,
              style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
              cursorColor: widget.theme.onSurface,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 8),
              ),
            ),
          ),
          if (isHovering && widget.data.toString().startsWith('=') && widget.controller.currentNumberTextEditingController == null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: isHovering ? 0.8 : 0.9,
                    end: isHovering ? 0.9 : 0.8,
                  ),
                  duration: const Duration(milliseconds: 100),
                  builder: (context, size, child) {
                    return Transform.scale(
                      scale: size,
                      child: IconButton(
                        onPressed: () {
                          if (_textEditingController.text.startsWith('=')) {
                            _textEditingController.text = formatCalculation( _performCalculations());
                            _focusNode.unfocus();
                            _hidePositions();
                          } else {
                            _textEditingController.text = widget.data != null ? formatCalculation(widget.data) : '';
                            _focusNode.requestFocus();
                            _showPositions();
                          }
                          _updateState();
                        },
                        tooltip: _textEditingController.text.startsWith('=')
                          ? S.of(context).submenu_artilces_image_description_button
                          : S.of(context).projects_module_notes_modify_category,
                        style: _textEditingController.text.startsWith('=')
                          ? ButtonThemes.primaryButtonStyle(context)
                          : ButtonThemes.secondaryButtonStyle(context),
                        icon: _textEditingController.text.startsWith('=')
                          ? Icon(Icons.check_rounded, color: widget.theme.onSecondary)
                          : Icon(Icons.brush_rounded, color: widget.theme.onPrimary)
                      ),
                    );
                  }
                ),
              ),
            )
        ],
      ),
    );
  }
}