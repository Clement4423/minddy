import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuTileMenu extends StatefulWidget {
  const CustomSelectionMenuTileMenu({
    super.key, 
    required this.theme,
    required this.enableSearch,
    required this.inititalItem,
    required this.closePreviousMenu,
    required this.items,
  });

  final StylesGetters theme;
  final bool enableSearch;
  final List<CustomSelectionMenuItem> items;
  final CustomSelectionMenuItem inititalItem;
  final Function closePreviousMenu;

  @override
  State<CustomSelectionMenuTileMenu> createState() => _CustomSelectionMenuTileMenuState();
}

class _CustomSelectionMenuTileMenuState extends State<CustomSelectionMenuTileMenu> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey(); // GlobalKey to track button
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  Alignment menuScaleStartAlignment = Alignment.topLeft;

  double itemHeight = 50.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250)
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  double _calculateTextWidth(String string, TextStyle style) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: string,
          style: style
        ),
        textDirection: TextDirection.ltr,
      )..layout(); // Perform layout to calculate width

      return textPainter.width;
  }

  double _calculateMenuWidth() {
    double maxWidth = 0.0;
    for (var item in widget.items) {

      double itemWidth = 0.0;
      // Measure the width of each item's text
      
      itemWidth += _calculateTextWidth(item.label, item.labelStyle ?? widget.theme.bodyMedium);

      // Add width of icon if present
      if (item.icon != null) {
        itemWidth += 24.0; // Approximate width of an icon
        itemWidth += 16.0; // Padding between icon and text
      } 
      
      if (item.iconReplacement != null) {
        if (item.iconReplacelemntWidth != null) {
          itemWidth += (item.iconReplacelemntWidth! * 2); 
        } else {
          throw Exception("iconReplacementWidth must be provided if an iconReplacement widget is.");
        }
      }

      // Consider padding around ListTile
      itemWidth += 20.0; // Left and right padding inside the ListTile

      // Update max width if this item is wider
      if (itemWidth > maxWidth) {
        maxWidth = itemWidth;
      }
    }

    if (widget.enableSearch && widget.items.length > 1) {
      double searchTileWidth = 0.0;
      searchTileWidth += _calculateTextWidth(S.current.articles_search, widget.theme.bodyMedium);
      searchTileWidth += 24.0;
      searchTileWidth += 16.0;
      searchTileWidth += 20.0;

      if (searchTileWidth > maxWidth) {
        maxWidth = searchTileWidth;
      }
    }

    return maxWidth;
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    var buttonSize = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    var screenSize = MediaQuery.of(context).size;

    double menuHeight = (widget.enableSearch && widget.items.length > 3 ? widget.items.length + 1 : widget.items.length) * itemHeight;
    double menuWidth = _calculateMenuWidth();

    // This is meant to avoid the border to create scroll.
    menuHeight += 1;
    menuWidth += 1;

    double top = offset.dy + buttonSize.height - (buttonSize.height / 2);
    if (top + menuHeight > screenSize.height) {
      // If the menu goes off the screen vertically, show it above the button
      menuScaleStartAlignment = Alignment.bottomLeft;
      top = offset.dy - menuHeight + (buttonSize.height / 2);
    }

    // Horizontal adjustment (ensure menu stays within horizontal bounds)
    double left = offset.dx + (buttonSize.width / 2);
    if (left + menuWidth > screenSize.width) {
      // Adjust left so it doesn't overflow the right edge
      if (menuScaleStartAlignment == Alignment.bottomLeft) {
        menuScaleStartAlignment = Alignment.bottomRight;
      } else {
        menuScaleStartAlignment = Alignment.topRight;
      }
      left = screenSize.width - menuWidth - (buttonSize.width / 2); // Add some padding
    } else if (left < 0) {
      // Adjust left if it goes off the left edge
      left = buttonSize.width / 2;
    }

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Close the menu when tapping outside of it
          _dismissOverlay(false);
        },
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              child: Material(
                type: MaterialType.transparency,
                child: ScaleTransition(
                  alignment: menuScaleStartAlignment,
                  scale: _fadeAnimation,
                  child: CustomSelectionMenuWidget(
                    menuWidth: menuWidth, 
                    menuHeight: menuHeight, 
                    itemHeight: itemHeight, 
                    items: widget.items, 
                    theme: widget.theme,
                    dismissOverlay: _dismissOverlay,
                    animation: _fadeAnimation,
                    enableSearch: widget.enableSearch
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dismissOverlay([bool selectedAnOption = true]) {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      if (selectedAnOption) {
        widget.closePreviousMenu();
      }
      _overlayEntry = null;
    });
  }

  void _showOverlayMenu(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: _buttonKey,
      enabled: widget.inititalItem.enabled,
      title: Text(
        widget.inititalItem.label, 
        style: widget.inititalItem.labelStyle ?? widget.theme.bodyMedium.copyWith(
          color: widget.inititalItem.foregroundColor ?? widget.theme.onPrimary
        ),
        overflow: TextOverflow.ellipsis,
      ),
      splashColor: widget.theme.primary.withValues(alpha: 0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: widget.inititalItem.foregroundColor ?? widget.theme.onPrimary),
      tileColor: Colors.transparent,
      onTap: () {
        if (_overlayEntry != null) {
          _dismissOverlay();
        } else {
          _showOverlayMenu(context);
        }
      },
    );
  }
}