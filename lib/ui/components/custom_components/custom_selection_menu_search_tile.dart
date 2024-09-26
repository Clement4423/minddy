import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/shortcuts/shortcuts_activators.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuSearchTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: itemHeight,
        width: menuWidth,
        decoration: BoxDecoration(
          border: showBottomBorder
            ? Border(
                bottom: BorderSide(
                  color: theme.onPrimary.withOpacity(theme.brightness == Brightness.light ? 1 : 0.4),
                  width: 0.5
                )
              )
            : null
        ),
        child: CallbackShortcuts(
          bindings: {
            escapeActivator: () {
              onEscapePressed();
            }
          },
          child: Focus(
            child: ListTile(
              title: TextSelectionTheme(
                data: TextSelectionThemeData(
                  selectionColor: theme.secondary.withOpacity(0.3)
                ),
                child: TextField(
                  autofocus: true,
                  onChanged: onChanged,
                  onEditingComplete: onEnterPressed,
                  cursorColor: theme.onPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: S.of(context).articles_search,
                    contentPadding: const EdgeInsets.only(bottom: 10)
                  ), 
                  style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                ),
              ),
              contentPadding: const EdgeInsets.only(right: 10, left: 10, bottom: 12),
              trailing: Icon(Icons.search_rounded, color: theme.onPrimary),
              tileColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
