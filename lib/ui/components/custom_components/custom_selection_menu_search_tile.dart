import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/shortcuts/shortcuts_activators.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuSearchTile extends StatefulWidget {
  const CustomSelectionMenuSearchTile({
    super.key, 
    required this.itemHeight, 
    required this.menuWidth, 
    required this.theme, 
    required this.showBottomBorder, 
    required this.onEscapePressed,
    required this.onChanged,
    required this.onEnterPressed
  });

  final double itemHeight;
  final double menuWidth;
  final StylesGetters theme;
  final bool showBottomBorder;
  final Function onEscapePressed;
  final Function(String) onChanged;
  final void Function() onEnterPressed;

  @override
  State<CustomSelectionMenuSearchTile> createState() => _CustomSelectionMenuSearchTileState();
}

class _CustomSelectionMenuSearchTileState extends State<CustomSelectionMenuSearchTile> {

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: widget.itemHeight,
        width: widget.menuWidth,
        decoration: BoxDecoration(
          border: widget.showBottomBorder
            ? Border(
                bottom: BorderSide(
                  color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.4),
                  width: 0.5
                )
              )
            : null
        ),
        child: CallbackShortcuts(
          bindings: {
            escapeActivator: () {
              widget.onEscapePressed();
            }
          },
          child: Focus(
            child: ListTile(
              title: TextSelectionTheme(
                data: TextSelectionThemeData(
                  selectionColor: widget.theme.secondary.withValues(alpha: 0.5)
                ),
                child: TextField(
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEnterPressed,
                  focusNode: _focusNode,
                  cursorColor: widget.theme.onPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: S.of(context).articles_search,
                    contentPadding: const EdgeInsets.only(bottom: 10)
                  ), 
                  style: widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary),
                ),
              ),
              contentPadding: const EdgeInsets.only(right: 10, left: 10, bottom: 12),
              trailing: Icon(Icons.search_rounded, color: widget.theme.onPrimary),
              tileColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
