import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu_list_tile.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu_list_tile_with_items.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu_search_tile.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuItem {
  String label;
  TextStyle? labelStyle;
  String? tooltipTitle;
  String? tooltip;
  IconData? icon;
  /// This will replace the icon if provided.
  Widget? iconReplacement;
  /// This will help the menu to properly size itself. 
  /// 
  /// Will throw an error if iconReplacement is provided but not iconReplacementWidth.
  double? iconReplacelemntWidth;
  Color? foregroundColor;
  bool enabled;
  Function onTap;
  List<CustomSelectionMenuItem>? items;

  CustomSelectionMenuItem({
    required this.label, 
    this.labelStyle, 
    required this.icon, 
    this.iconReplacement,
    this.iconReplacelemntWidth,
    required this.onTap, 
    this.foregroundColor, 
    this.enabled = true,
    this.tooltipTitle,
    this.tooltip,
    this.items
  });
}

enum CustomSelectionMenuButttonType {
  elevated,
  icon
}

class CustomSelectionMenu extends StatefulWidget {
  const CustomSelectionMenu({
    super.key, 
    this.enabled = true,
    this.enableSearch = false,
    this.enableRightClick = false,
    this.enableLeftClick = true,
    required this.theme,
    this.buttonStyle,
    this.type = CustomSelectionMenuButttonType.elevated,
    this.menuMaxHeight,
    this.menuMaxWidth,
    required this.items,
    required this.child
  });

  final bool enabled;
  final bool enableSearch;
  final bool enableRightClick;
  final bool enableLeftClick;
  final StylesGetters theme;
  final ButtonStyle? buttonStyle;
  final CustomSelectionMenuButttonType type;
  final List<CustomSelectionMenuItem> items;
  final double? menuMaxHeight;
  final double? menuMaxWidth;
  final Widget child;

  @override
  State<CustomSelectionMenu> createState() => _CustomSelectionMenuState();
}

class _CustomSelectionMenuState extends State<CustomSelectionMenu> with SingleTickerProviderStateMixin {
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
    
    if (widget.menuMaxWidth != null && menuWidth > widget.menuMaxWidth!) {
      menuWidth = widget.menuMaxWidth!;
    }

    if (widget.menuMaxHeight != null && menuHeight > widget.menuMaxHeight!) {
      menuHeight = widget.menuMaxHeight!;
    }

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
          _dismissOverlay();
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

  void _dismissOverlay() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  void _showOverlayMenu(BuildContext context) {
    if (widget.items.isEmpty || !widget.enabled) {
      return;
    }
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case CustomSelectionMenuButttonType.elevated:
        return GestureDetector(
          onSecondaryTap: () {
            if (widget.enableRightClick) {
              if (_overlayEntry != null) {
                _dismissOverlay();
              } else {
                _showOverlayMenu(context);
              }
            }
          },
          child: ElevatedButton(
            key: _buttonKey,
            onPressed: () {
              if (!widget.enableLeftClick) {
                return;
              }
              if (_overlayEntry != null) {
                _dismissOverlay();
              } else {
                _showOverlayMenu(context);
              }
            },
            style: widget.buttonStyle ?? ButtonThemes.secondaryButtonStyle(context),
            child: widget.child,
          ),
        );
      case CustomSelectionMenuButttonType.icon:
        return IconButton(
          key: _buttonKey,
          onPressed: () {
            if (!widget.enableLeftClick) {
              return;
            }
            if (_overlayEntry != null) {
              _dismissOverlay();
            } else {
              _showOverlayMenu(context);
            }
          },
          style: widget.buttonStyle ?? ButtonThemes.secondaryButtonStyle(context)
            .copyWith(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)
                )
              )
            ),
          icon: widget.child,
        );
    }
    
  }
}

class _CustomSelectionMenuSearchUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class CustomSelectionMenuWidget extends StatefulWidget {
  const CustomSelectionMenuWidget({
    super.key, 
    required this.menuWidth, 
    required this.menuHeight, 
    required this.itemHeight, 
    required this.items,
    required this.theme,
    required this.dismissOverlay,
    required this.animation,
    required this.enableSearch
  });

  final double menuWidth;
  final double menuHeight;
  final double itemHeight;
  final List<CustomSelectionMenuItem> items;
  final StylesGetters theme;
  final Function dismissOverlay;
  final Animation<double> animation;
  final bool enableSearch;

  @override
  State<CustomSelectionMenuWidget> createState() => _CustomSelectionMenuWidgetState();
}

class _CustomSelectionMenuWidgetState extends State<CustomSelectionMenuWidget> {

  _CustomSelectionMenuSearchUpdater searchUpdater = _CustomSelectionMenuSearchUpdater();

  double menuHeight = 0;
  List<CustomSelectionMenuItem> items = [];

  _search(String query) {
    if (query.isEmpty) {
      items = widget.items;
      menuHeight = widget.menuHeight;
    } else {
      String transformedQuery = SearchTextFormatter.format(query);
      items = widget.items.where((item) => SearchTextFormatter.format(item.label).contains(transformedQuery) && item.enabled).toList();
      menuHeight = ((items.length + 1) * widget.itemHeight + 1.0).clamp(0, widget.menuHeight);
      // length + 1 for the search input
    }
    setState(() {});
  }

  @override
  void initState() {
    menuHeight = widget.menuHeight;
    items = List.from(widget.items);
    super.initState();
  }

  @override
  void dispose() {
    searchUpdater.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.menuWidth,
      height: menuHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: widget.theme.shadow.withValues(alpha: 0.15),
            offset: const Offset(0, 0),
            blurRadius: 10.0,
          ),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: FadeTransition(
            opacity: widget.animation,
            child: Container(
              height: menuHeight,
              width: widget.menuWidth,
              decoration: BoxDecoration(
                color: widget.theme.primaryContainer,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.4),
                  width: 0.5,
                  strokeAlign: BorderSide.strokeAlignInside
                )
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.enableSearch && widget.items.length > 3)
                      CustomSelectionMenuSearchTile(
                        itemHeight: widget.itemHeight, 
                        menuWidth: widget.menuWidth, 
                        theme: widget.theme, 
                        onEscapePressed: widget.dismissOverlay,
                        onChanged: (query) {
                          _search(query);
                        },
                        onEnterPressed: () {
                          if (items.isNotEmpty && items.first.items == null) {
                            items.first.onTap();
                            widget.dismissOverlay();
                          }
                        },
                        showBottomBorder: items.isNotEmpty,
                      ),
                    AnimatedBuilder(
                      animation: searchUpdater, 
                      builder: (context, child) {
                        return Column(
                          children: items.map((item) {
                            if (item.items != null && item.items!.isNotEmpty) {
                              return CustomSelectionMenuListTileWithItems(
                                item: item, 
                                itemHeight: widget.itemHeight, 
                                menuWidth: widget.menuWidth, 
                                theme: widget.theme, 
                                enableSearch: widget.enableSearch,
                                showBottomBorder: items.indexOf(item) < items.length - 1, 
                                dismissOverlay: widget.dismissOverlay
                              );
                            } else {
                              return CustomSelectionMenuListTile(
                                item: item, 
                                itemHeight: widget.itemHeight, 
                                menuWidth: widget.menuWidth, 
                                theme: widget.theme, 
                                showBottomBorder: items.indexOf(item) < items.length - 1, 
                                dismissOverlay: widget.dismissOverlay
                              );
                            }
                          }).toList()
                        );
                      }
                    )
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}