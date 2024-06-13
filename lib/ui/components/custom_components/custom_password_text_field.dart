import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({super.key, required this.hintText, required this.onChanged, required this.padding, required this.width, required this.height, required this.margin, required this.borderRadius, required this.style});

  final String hintText;

  final Function(String) onChanged;
  final EdgeInsets padding;
  final double width;
  final double height;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final TextStyle style;


  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: widget.borderRadius
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (newValue) {
                widget.onChanged(newValue);
              },
              obscureText: _isObscured,
              cursorColor: theme.onPrimary,
              textAlign: TextAlign.left,
              style: widget.style,
              autofocus: true,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              child: _isObscured 
              ? Tooltip(
                message: S.of(context).welcome_password_creation_show_semantic,
                child: Icon(Icons.remove_red_eye_outlined, color: theme.onSurface)
              )
              : Tooltip(
                message: S.of(context).welcome_password_creation_hide_semantic,
                child: Icon(Icons.remove_red_eye_rounded, color: theme.onSurface)
              ),
            ),
          )
        ],
      ),
    );
  }
}
