import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuListTile extends StatelessWidget {
  const CustomSelectionMenuListTile({
    super.key, 
    required this.item, 
    required this.itemHeight, 
    required this.menuWidth, 
    required this.theme, 
    required this.showBottomBorder, 
    required this.dismissOverlay
  });

  final CustomSelectionMenuItem item;
  final double itemHeight;
  final double menuWidth;
  final StylesGetters theme;
  final bool showBottomBorder;
  final Function dismissOverlay;

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
        child: ListTile(
          enabled: item.enabled,
          title: Text(
            item.label, 
            style: item.labelStyle ?? theme.bodyMedium.copyWith(
              color: item.foregroundColor ?? theme.onPrimary
            ),
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          trailing: item.iconReplacement ?? (item.icon != null 
            ? Icon(
                item.icon, 
                color: item.foregroundColor ?? theme.onPrimary
              )
            : null),
          tileColor: Colors.transparent,
          onTap: () async {
            if (item.enabled) {
              await item.onTap();
              dismissOverlay();
            }
          },
        ),
      ),
    );
  }
}
