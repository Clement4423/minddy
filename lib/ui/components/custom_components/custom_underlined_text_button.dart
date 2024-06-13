import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomUnderlinedTextButton extends StatefulWidget {
  const CustomUnderlinedTextButton({super.key, required this.text, required this.action});

  final String text;
  final Function action;

  @override
  State<CustomUnderlinedTextButton> createState() => _CustomTextUnderlinedButtonState();
}

class _CustomTextUnderlinedButtonState extends State<CustomUnderlinedTextButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovering = false;
          });
        },
        child: GestureDetector(
          onTap: () async {
            await widget.action();
          },
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.bodyMedium.copyWith(
              color: _isHovering 
                ? theme.brightness == Brightness.light 
                  ? Colors.grey
                  : theme.onPrimary
                : theme.brightness == Brightness.light 
                  ? theme.onPrimary
                  : Colors.grey,
              decoration: TextDecoration.underline
            ),
          ),
        ),
      ),
    );
  }
}


