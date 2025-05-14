import 'package:flutter/material.dart';
import 'package:minddy/system/model/plugin_ui_component_icon_icons.dart';
import 'package:minddy/ui/components/menus/sub_menus/select_icon_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomIconSelectorInput extends StatefulWidget {
  const CustomIconSelectorInput({
    super.key, 
    required this.theme, 
    required this.onSelected, 
    required this.icon
  });

  final StylesGetters theme;
  final Function(IconInfo) onSelected;
  final IconInfo? icon;

  @override
  State<CustomIconSelectorInput> createState() => _CustomIconInputState();
}

class _CustomIconInputState extends State<CustomIconSelectorInput> {

  IconInfo? selectedIcon;

  @override
  void initState() {
    selectedIcon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: "Select an icon",
        child: GestureDetector(
          onTap: () {
            showSubMenu(
              context, 
              SelectIconSubMenu(
                theme: widget.theme, 
                onSelected: (newIcon) {
                  widget.onSelected(newIcon);
                  selectedIcon = newIcon;
                  setState(() {});
                },
                selectedIcon: selectedIcon
              )
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: widget.theme.surface,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: Icon(selectedIcon?.icon ?? Icons.question_mark_rounded, color: widget.theme.onSurface)
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      selectedIcon?.category ?? "Select an icon",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}