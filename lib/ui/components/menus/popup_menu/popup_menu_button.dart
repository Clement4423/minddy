import 'package:flutter/material.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<CustomPopupItemModel> items;

  const CustomPopupMenuButton({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return PopupMenuButton<CustomPopupItemModel>(
      elevation: 12,
      color: theme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      itemBuilder: (BuildContext context) {
        return items.map((CustomPopupItemModel item) {
          return PopupMenuItem<CustomPopupItemModel>(
            value: item,
            child: _buildMenuItem(context, item),
          );
        }).toList();
      },
      onSelected: (CustomPopupItemModel item) {
        item.action();
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(Icons.more_horiz_rounded, color: theme.secondary, size: 28,),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, CustomPopupItemModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        item.text,
        item.icon,
      ],
    );
  }
}
