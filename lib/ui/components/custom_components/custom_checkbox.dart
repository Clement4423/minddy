import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key, 
    required this.value,
    required this.onChanged,
    required this.theme,
    this.scale = 1.4, 
    this.backgroundColor, 
    this.checkedColor
  });

  final bool value;
  final Function(bool) onChanged;
  final StylesGetters theme;
  final double scale;
  final Color? backgroundColor;
  final Color? checkedColor;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Checkbox(
        checkColor: widget.theme.onSecondary,
        fillColor: WidgetStatePropertyAll(
          isChecked 
            ? widget.checkedColor ?? widget.theme.secondary 
            : widget.backgroundColor ?? widget.theme.primary
        ),
        hoverColor: widget.theme.onPrimary.withOpacity(0.8),
        splashRadius: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide.none,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            widget.onChanged(isChecked);
          });
        },
      ),
    );
  }
}