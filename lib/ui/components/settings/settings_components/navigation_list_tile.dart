import 'package:flutter/material.dart';
import 'package:minddy/ui/components/settings/settings_components/sidebar_navigation_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class NavigationListTile extends StatelessWidget {

  final Icon icon;
  final String title;
  final bool isActive;
  final Function action;
  final int index;
  final SidebarNavigationController _controller;


  const NavigationListTile(
    this._controller,
    this.index,
    this.action,
    this.isActive,
    this.title,
    this.icon,
    {super.key}
    );

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return isActive ?
      Card(
        color: theme.secondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: icon,
          iconColor: theme.onSecondary,
          title: Text(
            title, 
            style: theme.bodyMedium.
            copyWith(color: theme.onSecondary)
          ),
          onTap: () {
            _controller.setCurrentSelected(index);
            action();
          },
        )
      )
      :
      Card(
        color: theme.primary,
        elevation: 0,
        child: ListTile(
          leading: icon,
          title: Text(
            title, 
            style: theme.bodyMedium.
            copyWith(color: theme.onPrimary)
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            _controller.setCurrentSelected(index);
            action();
          },
        ),
      );
  }
}