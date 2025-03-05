import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final String? menuTitle;
  final String selectedOptionTitle;
  final StylesGetters theme;
  final List<CustomSelectionMenuItem> items;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isMultipleSelectionMenu;
  final double? menuMaxHeight;
  final bool enabled;
  final bool enableSearch;
  final Function? onMenuClosed;

  const CustomDropdownButton({
    super.key,
    required this.width, 
    required this.menuTitle,
    required this.selectedOptionTitle,
    required this.items,
    required this.theme,
    this.enabled = true,
    this.enableSearch = false,
    this.isMultipleSelectionMenu = false,
    this.menuMaxHeight,
    this.onMenuClosed,
    this.backgroundColor,
    this.foregroundColor
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 50,
      padding: const EdgeInsets.only(right: 5, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.enabled ? widget.backgroundColor ?? widget.theme.surface : Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.menuTitle != null)
            Text(
              widget.menuTitle!,
              style: widget.theme.titleMedium.copyWith(
                color: widget.enabled ? widget.foregroundColor ?? widget.theme.onSurface : const Color.fromARGB(255, 120, 120, 120),
                fontWeight: FontWeight.w500
              ),
            ),
          Container(
            width: widget.menuTitle != null ? (_calculateTextWidth(widget.selectedOptionTitle, widget.theme.bodyMedium) + 11 + 20) : widget.width - 26, // Here we add the selectedOptionTitle size, the Container padding, and the icon size
            height: 40,
            constraints: BoxConstraints(
              maxWidth: widget.width - 15 - _calculateTextWidth(widget.menuTitle ?? '', widget.theme.titleMedium), // Here we remove the above padding and menu title size
              minWidth: 10
            ),
            padding: const EdgeInsets.only(left: 7, right: 4),
            decoration: BoxDecoration(
              color: widget.enabled ? widget.theme.primary :  widget.menuTitle == null ? Colors.transparent : const Color.fromARGB(255, 120, 120, 120),
              borderRadius: BorderRadius.circular(10)
            ),
            child: CustomSelectionMenu(
              enabled: widget.enabled,
              theme: widget.theme, 
              items: widget.items, 
              menuMaxHeight: widget.menuMaxHeight,
              onMenuClosed: widget.onMenuClosed,
              enableSearch: widget.enableSearch,
              isMultipleSelectionMenu: widget.isMultipleSelectionMenu,
              buttonStyle: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(0, 0, 0, 0)),
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                elevation: WidgetStatePropertyAll(0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedOptionTitle,
                      style: widget.theme.bodyMedium.copyWith(
                        color: widget.enabled ? widget.foregroundColor ?? widget.theme.onSurface : widget.menuTitle == null ? const Color.fromARGB(255, 120, 120, 120) : Colors.grey[400]
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: widget.enabled ? widget.foregroundColor ?? widget.theme.onSurface : widget.menuTitle == null ? const Color.fromARGB(255, 120, 120, 120) : Colors.grey[400],
                    size: 20,
                  )
                ],
              )
            ),
          ),
        ],
      )
    );
  }
}

double _calculateTextWidth(String text, TextStyle textStyle) {
  TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle, // Use default style if none provided
      ),
      textDirection: TextDirection.ltr,
    )..layout(); // Perform layout to calculate width

  return textPainter.width;
}