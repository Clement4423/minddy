import 'package:flutter/material.dart';
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
    return Container(
      height: 20,
      width: widget.width - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.theme.surface,
      ),
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 5),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(
            widget.itemToString(widget.value),
            style: widget.theme.titleMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 8,
              color: widget.theme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          iconSize: 18,
          borderRadius: BorderRadius.circular(13),
          menuWidth: widget.width * 2,
          menuMaxHeight: widget.height * 2,
          onChanged: widget.onChanged,
          icon: Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface),
          dropdownColor: widget.theme.surface,
          itemHeight: kMinInteractiveDimension,
          isExpanded: true,
          items: [
            ...widget.items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Container(
                  height: kMinInteractiveDimension,
                  width: widget.width * 2,
                  decoration: BoxDecoration(
                    border: Border(
                      top: widget.items.indexOf(item) == 0 
                        ? BorderSide.none 
                        : BorderSide(
                        color: widget.theme.onSurface, 
                        width: 0.5
                      )
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemToString(item),
                        style: widget.theme.bodyMedium.copyWith(
                          color: widget.theme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}