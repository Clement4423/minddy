import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/navigation_list_tile_model.dart';
import 'package:minddy/system/router/settings_router.dart';
import 'package:minddy/ui/components/menus/center_menu/center_menu.dart';

List<NavigationListTileModel> generalListTiles = [
  NavigationListTileModel(
    title: S.current.settings_personalize_title, 
    icon: const Icon(Icons.brush_rounded), 
    index: 1, 
    routeName: "/personalize"
  ),
  NavigationListTileModel(
    title: S.current.settings_security_title, 
    icon: const Icon(Icons.lock_outline_rounded), 
    index: 2, 
    routeName: "/personalize"
  ),
  NavigationListTileModel(
    title: S.current.settings_accessibility_title, 
    icon: const Icon(Icons.accessibility_rounded), 
    index: 3, 
    routeName: "/personalize"
  ),
];

List<NavigationListTileModel> bottomListTiles = [
  NavigationListTileModel(
    title: S.current.settings_account_title, 
    icon: const Icon(Icons.account_circle_outlined), 
    index: 4, 
    routeName: "/account"
  ),
];

Future<dynamic> showSettings(BuildContext context, {String? pageRouteName, dynamic argument}) {
  if (pageRouteName != null) {
    return showCenterMenu(
      context, 
      const Icon(Icons.settings_rounded, size: 40,), 
      SettingsRouter(), 
      generalListTiles, 
      bottomListTiles,
      pageRouteName: pageRouteName,
      argument: argument
    );
  } else {
    return showCenterMenu(
      context, 
      const Icon(Icons.settings_rounded, size: 40,),
      SettingsRouter(), 
      generalListTiles, 
      bottomListTiles
    );
  }
}