import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDropdownButton extends StatelessWidget {
  final double width;
  final String? menuTitle;
  final String selectedOptionTitle;
  final StylesGetters theme;
  final List<CustomSelectionMenuItem> items;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enabled;
  final bool enableSearch;

  const CustomDropdownButton({
    super.key,
    required this.width, 
    required this.menuTitle,
    required this.selectedOptionTitle,
    required this.items,
    required this.theme,
    this.enabled = true,
    this.enableSearch = false,
    this.backgroundColor,
    this.foregroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      padding: const EdgeInsets.only(right: 5, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: enabled ? backgroundColor ?? theme.surface : Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (menuTitle != null)
            Text(
              menuTitle!,
              style: theme.titleMedium.copyWith(
                color: enabled ? foregroundColor ?? theme.onSurface : const Color.fromARGB(255, 120, 120, 120),
                fontWeight: FontWeight.w500
              ),
            ),
          Container(
            width: _calculateTextWidth(selectedOptionTitle, theme.bodyMedium) + 11 + 20, // Here we add the selectedOptionTitle size, the Container padding, and the icon size
            height: 40,
            constraints: BoxConstraints(
              maxWidth: width - 15 - _calculateTextWidth(menuTitle ?? '', theme.titleMedium), // Here we remove the above padding and menu title size
              minWidth: 10
            ),
            padding: const EdgeInsets.only(left: 7, right: 4),
            decoration: BoxDecoration(
              color: enabled ? theme.primary :  menuTitle == null ? Colors.transparent : const Color.fromARGB(255, 120, 120, 120),
              borderRadius: BorderRadius.circular(10)
            ),
            child: CustomSelectionMenu(
              enabled: enabled,
              theme: theme, 
              items: items, 
              enableSearch: enableSearch,
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
                      selectedOptionTitle,
                      style: theme.bodyMedium.copyWith(
                        color: enabled ? foregroundColor ?? theme.onSurface : menuTitle == null ? const Color.fromARGB(255, 120, 120, 120) : Colors.grey[400]
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: enabled ? foregroundColor ?? theme.onSurface : menuTitle == null ? const Color.fromARGB(255, 120, 120, 120) : Colors.grey[400],
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