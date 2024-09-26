import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetTextInput extends StatefulWidget {
  const NodeWidgetTextInput({
    super.key, 
    required this.onChange, 
    required this.theme,
    required this.portInfo,
    required this.type, 
    required this.hint, 
    required this.defaultText
  });

  final Function(dynamic, NodePortInfo, INodeWidget) onChange;
  final NodePortInfo portInfo;
  final StylesGetters theme;
  final NodeDataType type;
  final String hint;
  final String? defaultText;

  @override
  State<NodeWidgetTextInput> createState() => _NodeWidgetTextInputState();
}


class _NodeWidgetTextInputState extends State<NodeWidgetTextInput> {

  TextEditingController controller = TextEditingController();

  void _performOnChange(String text) {
    dynamic valueToReturn = text;
    if (widget.type == NodeDataType.number) {
      valueToReturn = num.tryParse(text) ?? 0.0;
    }

    widget.onChange(valueToReturn, widget.portInfo, widget.portInfo.node);
  }

  void _incrementValue() {
    controller.text = (num.parse(controller.text) + 0.1).toStringAsFixed(2);
    _performOnChange(controller.text);
  }

  void _decrementValue() {
    controller.text = (num.parse(controller.text) - 0.1).toStringAsFixed(2);
    _performOnChange(controller.text);
  }

  String _formatNumber(String number) {
    String newNumber = number;
    if (number.contains('.') && number.split('.').last.length < 2) {
      List<String> characters = number.characters.toList();
      characters.add('0');
      newNumber = characters.join();
    } 
    return newNumber;
  }

  bool isHoveringLeftArrow = false;
  bool isHoveringRightArrow = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _truncateText(String text, int treshold) {
    if (text.length > treshold) {
      return text.substring(0, treshold);
    } else {
      return text;
    }
  }

  @override
  void initState() {
    String defaultValue = widget.defaultText ?? '';

    if (widget.type == NodeDataType.number) {
      if (widget.defaultText == null) {
        defaultValue = '0';
      }
      defaultValue = _formatNumber(defaultValue);
    }

    controller.text = defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87,
      height: 15,
      decoration: BoxDecoration(
        color: widget.theme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          if (widget.type == NodeDataType.number)
            MouseRegion(
              onEnter: (event) {
                setState(() {
                  isHoveringLeftArrow = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHoveringLeftArrow = false;
                });
              },
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _decrementValue();
                },
                child: Container(
                  width: 10,
                  height: 15,
                  decoration: BoxDecoration(
                    color: isHoveringLeftArrow ? widget.theme.onPrimary.withOpacity(0.15) : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)
                    )
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: widget.theme.onPrimary,
                    size: 6
                  ),
                ),
              ),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.type == NodeDataType.number)
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Tooltip(
                      message: widget.hint.length > 8 ? widget.hint : '',
                      child: Text(
                        _truncateText(widget.hint, 8),
                        style: widget.theme.titleMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color: widget.theme.onPrimary.withOpacity(0.4)
                      ),
                      ),
                    ),
                  ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (widget.type == NodeDataType.number) {
                        final dashCommaRegex = RegExp(r'[,]');
                  
                        controller.text = value.replaceAll(dashCommaRegex, '');
                  
                        // Handle empty input
                        if (value.isEmpty) {
                          controller.text = '0';
                          _performOnChange('0');
                          return;
                        }
                  
                        final dotCommaRegex = RegExp(r'[.]');
                  
                        int dotCommaCount = dotCommaRegex.allMatches(value).length;
                  
                        bool endsWithDotComma = value.characters.last == '.' || value.characters.last == ',';
                  
                        if (dotCommaCount > 1 || (endsWithDotComma && dotCommaCount > 1)) {
                          controller.text = value.substring(0, value.length - 1);
                          controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length)
                          );
                        } 
                        else if (endsWithDotComma && dotCommaCount == 1) {
                          // Do nothing, allow the dot or comma
                        }
                        else {
                          String sanitizedValue = value.replaceAll(RegExp(r'[^\d.,]'), '');
                          if (sanitizedValue != value) {
                            controller.text = sanitizedValue;
                            controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: sanitizedValue.length)
                            );
                          }
                        }
                      }
                  
                      _performOnChange(controller.text);
                    },
                    keyboardType: widget.type == NodeDataType.number ? TextInputType.number : TextInputType.text,
                    controller: controller,
                    maxLines: 1,
                    cursorColor: widget.theme.onPrimary,
                    cursorWidth: 1,
                    cursorHeight: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]+$'))
                    ],
                    style: widget.theme.titleMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 8,
                      color: widget.theme.onPrimary
                    ),
                    textAlign: widget.type == NodeDataType.number ? TextAlign.end : TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      contentPadding: const EdgeInsets.only(bottom: 18, left: 5),
                      hintStyle: widget.theme.titleMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color: widget.theme.onPrimary.withOpacity(0.5)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.type == NodeDataType.number)
            MouseRegion(
              onEnter: (event) {
                setState(() {
                  isHoveringRightArrow = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHoveringRightArrow = false;
                });
              },
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _incrementValue();
                },
                child: Container(
                  width: 10,
                  height: 15,
                  decoration: BoxDecoration(
                    color: isHoveringRightArrow ? widget.theme.onPrimary.withOpacity(0.15) : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                    )
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: widget.theme.onPrimary,
                    size: 6
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}