import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/model/node_port_info.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetStringInput extends StatefulWidget {
  const NodeWidgetStringInput({
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
  State<NodeWidgetStringInput> createState() => _NodeWidgetStringInputState();
}

class _NodeWidgetStringInputState extends State<NodeWidgetStringInput> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.defaultText ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _performOnChange(String text) {
    widget.onChange(text, widget.portInfo, widget.portInfo.node);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87,
      height: 15,
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: widget.theme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextField(
        onChanged: _performOnChange,
        controller: controller,
        maxLines: 1,
        cursorWidth: 1,
        cursorHeight: 10,
        cursorColor: widget.theme.onPrimary,
        style: widget.theme.titleMedium.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 8,
          color: widget.theme.onPrimary,
          overflow: TextOverflow.ellipsis
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
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
}