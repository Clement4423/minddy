import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomIconInput extends StatefulWidget {
  const CustomIconInput({
    super.key, 
    required this.theme, 
    this.initialValue, 
    required this.onChanged, 
    this.onEditingComplete, 
    required this.hint, 
    this.maxLength, 
    required this.icon, 
    this.inputFormatter
  });

  final StylesGetters theme;
  final String? initialValue;
  final Function(String) onChanged;
  final Function(String)? onEditingComplete;
  final String hint;
  final int? maxLength;
  final Widget icon;
  final TextInputFormatter? inputFormatter;

  @override
  State<CustomIconInput> createState() => _CustomIconInputState();
}

class _CustomIconInputState extends State<CustomIconInput> {

  String text = '';

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    if (widget.initialValue != null) {
      text = widget.initialValue!;
    } 
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: widget.theme.surface,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Tooltip(
              message: widget.hint,
              child: SizedBox(
                width: 35,
                height: 35,
                child: widget.icon
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextField(
                focusNode: focusNode,
                controller: TextEditingController(text: widget.initialValue),
                onChanged: widget.onChanged,
                onEditingComplete: () {
                  if (widget.onEditingComplete != null) {
                    widget.onEditingComplete!(text);
                  }
                  focusNode.unfocus();
                },
                inputFormatters: widget.inputFormatter != null 
                  ? [widget.inputFormatter!]
                  : [],
                maxLines: 1,
                maxLength: widget.maxLength,
                buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                  return const SizedBox.shrink();
                },
                cursorColor: widget.theme.onSurface,
                style: widget.theme.bodyMedium
                  .copyWith(color: widget.theme.onSurface),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: widget.theme.bodyMedium
                    .copyWith(color: widget.theme.onSurface.withValues(alpha: 0.5))
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}