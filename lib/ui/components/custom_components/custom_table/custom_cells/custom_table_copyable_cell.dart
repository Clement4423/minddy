import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableCopyableCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableCopyableCell({super.key, required this.theme, required this.initialValue}) {
    data = initialValue;
  }

  @override
  State<CustomTableCopyableCell> createState() => _CustomTableCopyableCellState();

  final String initialValue;

  @override
  var data = 0;

  final StylesGetters theme;
}

class _CustomTableCopyableCellState extends State<CustomTableCopyableCell> {
  bool isHovering = false;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  void _initializeTextController() {
    _textEditingController.text = widget.data.toString();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateState({bool? setIsHovering}) {
    bool needToRequestFocus = false;
     if (_focusNode.hasFocus) {
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
      onEnter: (event) {
        _updateState(setIsHovering: true);
      },
      onExit: (event) {
        _updateState(setIsHovering: false);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            TextField(
              onChanged: (value) {
                widget.data = value;
                _updateState();
              },
              controller: _textEditingController,
              focusNode: _focusNode,
              style: widget.theme.bodyMedium.copyWith(
                color: widget.theme.secondary,
                decoration: TextDecoration.underline,
                decorationColor: widget.theme.secondary
              ),
              cursorColor: widget.theme.onSurface,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            if (isHovering && widget.data.toString().isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
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
                            Clipboard.setData(ClipboardData(text: widget.data.toString()));
                          },
                          tooltip: S.of(context).articles_copy_text,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(widget.theme.primary),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                            elevation: const WidgetStatePropertyAll(8)
                          ),
                          icon: Icon(Icons.copy_outlined, color: widget.theme.onPrimary)
                        ),
                      );
                    }
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}