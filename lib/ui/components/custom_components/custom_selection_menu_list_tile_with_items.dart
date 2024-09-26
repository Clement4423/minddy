import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu_tile_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuListTileWithItems extends StatelessWidget {
  const CustomSelectionMenuListTileWithItems({
    super.key, 
    required this.enableSearch,
    required this.item, 
    required this.itemHeight, 
    required this.menuWidth, 
    required this.theme, 
    required this.showBottomBorder, 
    required this.dismissOverlay
  });

  final bool enableSearch;
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
        child: CustomSelectionMenuTileMenu(
          theme: theme, 
          inititalItem: item, 
          enableSearch: enableSearch,
          closePreviousMenu: dismissOverlay, 
          items: item.items!
        )
      ),
    );
  }
}