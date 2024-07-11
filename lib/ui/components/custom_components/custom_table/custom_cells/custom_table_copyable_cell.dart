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

  StylesGetters theme;
}

class _CustomTableCopyableCellState extends State<CustomTableCopyableCell> {

  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            TextField(
              onChanged: (value) {
                widget.data = value;
              },
              controller: TextEditingController(text: widget.data),
              style: widget.theme.bodyMedium
              .copyWith(color: widget.theme.secondary, decoration: TextDecoration.underline, decorationColor: widget.theme.secondary),
              cursorColor: widget.theme.onSurface,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            if (isHovering && widget.data as String != '')
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
                          Clipboard.setData(ClipboardData(text: widget.data));
                        }, 
                        tooltip: S.of(context).articles_copy_text,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(widget.theme.primary),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                          elevation: const MaterialStatePropertyAll(8)
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