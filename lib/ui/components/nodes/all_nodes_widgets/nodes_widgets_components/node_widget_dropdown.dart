import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeWidgetDropdown<T> extends StatefulWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final double width;
  final double height;
  final StylesGetters theme;
  final String Function(T) itemToString;

  const NodeWidgetDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.width,
    required this.height,
    required this.theme,
    required this.itemToString,
  });

  @override
  State<NodeWidgetDropdown<T>> createState() => _NodeWidgetDropdownState<T>();
}

class _NodeWidgetDropdownState<T> extends State<NodeWidgetDropdown<T>> {

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: 20,
        width: widget.width - 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.theme.surface,
        ),
        margin: const EdgeInsets.only(top: 5),
        child: CustomSelectionMenu(
          menuMaxHeight: widget.height * 2,
          theme: widget.theme, 
          enableSearch: true,
          buttonStyle: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            padding: WidgetStatePropertyAll(EdgeInsets.only(left: 7, right: 4)),
            elevation: WidgetStatePropertyAll(0)
          ),
          items: widget.items.map((item) {
            return CustomSelectionMenuItem(
              label: widget.itemToString(item), 
              labelStyle: widget.theme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: widget.itemToString(item) == widget.itemToString(widget.value)
                  ? widget.theme.secondary
                  : widget.theme.onPrimary,
              ),
              icon: null, 
              onTap: () {
                widget.onChanged(item);
              }
            );
          }).toList(),
          child: SizedBox(
            width: widget.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    widget.itemToString(widget.value),
                    style: widget.theme.titleMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 8,
                      color: widget.theme.onPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: widget.theme.onSurface,
                  size: 16,
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}