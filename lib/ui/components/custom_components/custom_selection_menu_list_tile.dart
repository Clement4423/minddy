import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

OverlayEntry? _tooltipEntry;

// ignore: must_be_immutable
class CustomSelectionMenuListTile extends StatefulWidget {
  const CustomSelectionMenuListTile({
    super.key, 
    required this.item, 
    required this.itemHeight, 
    required this.menuWidth, 
    required this.theme, 
    required this.showBottomBorder, 
    required this.isMultipleSelectionMenu,
    required this.dismissOverlay
  });

  final CustomSelectionMenuItem item;
  final double itemHeight;
  final double menuWidth;
  final StylesGetters theme;
  final bool isMultipleSelectionMenu;
  final bool showBottomBorder;
  final Function dismissOverlay;

  @override
  State<CustomSelectionMenuListTile> createState() => _CustomSelectionMenuListTileState();
}

class _CustomSelectionMenuListTileState extends State<CustomSelectionMenuListTile> {
  final GlobalKey tileKey = GlobalKey();

  void _hideTooltip() {
    _tooltipEntry?.remove();
    _tooltipEntry = null;
  }

  void _showTooltip(BuildContext context, CustomSelectionMenuItem item) {
    RenderBox renderBox = tileKey.currentContext!.findRenderObject() as RenderBox;
    var buttonSize = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    var screenSize = MediaQuery.of(context).size;

    double availableSpaceRight = screenSize.width - offset.dx - buttonSize.width;
    double availableSpaceLeft = offset.dx;

    double tooltipWidth = 200.0;

    double tooltipLeft;
    Alignment tooltipAlignment;
    if (availableSpaceRight >= tooltipWidth) {
      tooltipLeft = offset.dx + buttonSize.width + 10;
      tooltipAlignment = Alignment.centerLeft;
    } else if (availableSpaceLeft >= tooltipWidth) {
      tooltipLeft = offset.dx - tooltipWidth - 10;
      tooltipAlignment = Alignment.centerRight;
    } else {
      tooltipLeft = offset.dx + buttonSize.width + 10;
      tooltipAlignment = Alignment.centerLeft;
    }

    double tooltipTop = offset.dy + (buttonSize.height / 2) - widget.itemHeight / 2;

    double tooltipHeight = CustomSelectionMenuTooltip.calculateTooltipHeight(item, widget.theme);

    if (tooltipTop + tooltipHeight >= screenSize.height) {
      tooltipTop = screenSize.height - tooltipHeight - 20;
    } else if (tooltipTop < 0) {
      tooltipTop = 20;
    }

    _tooltipEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: tooltipLeft,
        top: tooltipTop,
        child: Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: tooltipAlignment,
            child: CustomSelectionMenuTooltip(
              item: item,
              theme: widget.theme,
              itemHeight: widget.itemHeight
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_tooltipEntry!);  
  }

  void setForegroundColor() {
    if (widget.isMultipleSelectionMenu) {
      if (widget.item.isSelected) {
        widget.item.foregroundColor = widget.theme.secondary;
      } else {
        widget.item.foregroundColor = widget.theme.onPrimary;
      }
    }
  }

  @override
  void initState() {
    setForegroundColor();
    super.initState();
  }

  @override
  void dispose() {
    if (_tooltipEntry != null) {
      _tooltipEntry!.remove();
      _tooltipEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: MouseRegion(
        onEnter: (event) {
          if (widget.item.tooltip != null) {
            _showTooltip(context, widget.item);
          }
        },
        onExit: (event) {
          if (widget.item.tooltip != null) {
            _hideTooltip();
          }
        },
        child: Container(
          key: tileKey,
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
          child: ListTile(
            enabled: widget.item.enabled,
            title: Text(
              widget.item.label, 
              style: widget.item.labelStyle ?? widget.theme.bodyMedium.copyWith(
                color: widget.item.foregroundColor ?? widget.theme.onPrimary
              ),
              overflow: TextOverflow.ellipsis,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            trailing: widget.item.iconReplacement ?? (widget.item.icon != null 
              ? Icon(
                  widget.item.icon, 
                  color: widget.item.foregroundColor ?? widget.theme.onPrimary
                )
              : null),
            tileColor: Colors.transparent,
            onTap: () async {
              if (widget.item.enabled) {
                if (!widget.isMultipleSelectionMenu) {
                  widget.dismissOverlay();
                }
                if (widget.isMultipleSelectionMenu) {
                  if (widget.item.closeMenuAfterSelected) {
                    widget.dismissOverlay();
                  } else {
                    setState(() {
                      widget.item.isSelected = !widget.item.isSelected;
                      setForegroundColor();
                    });
                  }
                }
                await widget.item.onTap();
              }
            },
          ),
        ),
      ),
    );
  }
}
