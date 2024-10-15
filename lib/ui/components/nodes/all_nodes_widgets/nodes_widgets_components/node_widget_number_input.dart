import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetNumberInput extends StatefulWidget {
  const NodeWidgetNumberInput({
    super.key, 
    required this.onChange, 
    required this.theme,
    required this.portInfo,
    required this.hint, 
    required this.defaultText
  });

  final Function(dynamic, NodePortInfo, INodeWidget) onChange;
  final NodePortInfo portInfo;
  final StylesGetters theme;
  final String hint;
  final String? defaultText;

  @override
  State<NodeWidgetNumberInput> createState() => _NodeWidgetNumberInputState();
}

class _NodeWidgetNumberInputState extends State<NodeWidgetNumberInput> {
  TextEditingController controller = TextEditingController();
  bool isHoveringLeftArrow = false;
  bool isHoveringRightArrow = false;

  @override
  void initState() {
    super.initState();
    String defaultValue = widget.defaultText ?? '0';
    controller.text = _formatNumber(defaultValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _performOnChange(String text) {
    dynamic valueToReturn = num.tryParse(text) ?? 0.0;
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

  String _truncateText(String text, int threshold) {
    if (text.length > threshold) {
      return text.substring(0, (threshold - 3)).padRight(threshold, '.');
    } else {
      return text;
    }
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
          _buildArrowButton(isLeft: true),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHint(),
                _buildTextField(),
              ],
            ),
          ),
          _buildArrowButton(isLeft: false),
        ],
      ),
    );
  }

  Widget _buildArrowButton({required bool isLeft}) {
    return MouseRegion(
      onEnter: (_) => setState(() => isLeft ? isHoveringLeftArrow = true : isHoveringRightArrow = true),
      onExit: (_) => setState(() => isLeft ? isHoveringLeftArrow = false : isHoveringRightArrow = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLeft ? _decrementValue : _incrementValue,
        child: Container(
          width: 10,
          height: 15,
          decoration: BoxDecoration(
            color: (isLeft ? isHoveringLeftArrow : isHoveringRightArrow) 
              ? widget.theme.onPrimary.withOpacity(0.15) 
              : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? const Radius.circular(5) : Radius.zero,
              bottomLeft: isLeft ? const Radius.circular(5) : Radius.zero,
              topRight: !isLeft ? const Radius.circular(5) : Radius.zero,
              bottomRight: !isLeft ? const Radius.circular(5) : Radius.zero,
            )
          ),
          child: Icon(
            isLeft ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded,
            color: widget.theme.onPrimary,
            size: 6
          ),
        ),
      ),
    );
  }

  Widget _buildHint() {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Tooltip(
        message: widget.hint.length > 6 ? widget.hint : '',
        child: Text(
          _truncateText(widget.hint, 6),
          style: widget.theme.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 8,
            color: widget.theme.onPrimary.withOpacity(0.4)
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        onChanged: _handleTextChange,
        onEditingComplete: _handleEditingComplete,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLines: 1,
        cursorWidth: 1,
        cursorHeight: 10,
        cursorColor: widget.theme.onPrimary,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]+$'))],
        style: widget.theme.titleMedium.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 8,
          color: widget.theme.onPrimary,
          overflow: TextOverflow.ellipsis
        ),
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          hintMaxLines: 1,
          contentPadding: const EdgeInsets.only(bottom: 18),
          hintStyle: widget.theme.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 8,
            color: widget.theme.onPrimary.withOpacity(0.5)
          ),
        ),
      ),
    );
  }

  void _handleTextChange(String value) {
    final dashCommaRegex = RegExp(r'[,]');
    controller.text = value.replaceAll(dashCommaRegex, '');
    
    if (value.isEmpty) return;

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

    _performOnChange(controller.text);
  }

  void _handleEditingComplete() {
    if (controller.text.isEmpty) {
      controller.text = '0';
      _performOnChange(controller.text);
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }
}