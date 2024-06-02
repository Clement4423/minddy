import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/rooter_interface.dart';
import 'package:minddy/system/model/navigation_list_tile_model.dart';
import 'package:minddy/ui/components/settings/settings_components/navigation_list_tile.dart';
import 'package:minddy/ui/components/settings/settings_components/sidebar_navigation_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

Future<dynamic> showCenterMenu(BuildContext context, Widget icon, IRouter router, List<NavigationListTileModel> generalListTiles, List<NavigationListTileModel> bottomListTiles, {String? pageRouteName, dynamic argument}) async {
  SidebarNavigationController controller = SidebarNavigationController(router);
  if (pageRouteName != null) {
    if (argument != null) {
      controller.setCurrentCustomPageNoRefresh(pageRouteName, argument);
    } else {
      controller.setCurrentPage(pageRouteName);
    }
    controller.setCurrentSelected(-1);
  }
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      StylesGetters theme = StylesGetters(context);
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.down,
          movementDuration: const Duration(milliseconds: 500),
          onDismissed: (direction) {
            if (direction == DismissDirection.down && context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              elevation: 12,
              child: Stack(
                children : [ 
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // This does nothing, it stands only to prevent closing the menu by clicking it, 
                      //because of the upper GestureDetector.
                    },
                    child: Container(
                      width: 550,
                      height: 550,
                      decoration: BoxDecoration(
                        color: theme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Sidebar container
                          Container(
                            width: 214,
                            height: 540,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.primary,
                            ),
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Sidebar header
                                      Padding (
                                      padding: const EdgeInsets.all(25),
                                      child: icon,
                                    ),
                                    // General list tiles secion
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Text(
                                                S.of(context).center_menu_general,
                                                style: theme.bodySmall.
                                                copyWith(color: Colors.grey)
                                              )
                                            ),
                                          ),
                                          ...buildNavigationListTiles(theme, generalListTiles, controller)
                                        ],
                                      ),
                                    ),
                                    // Bottom list tiles section
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text(
                                          S.of(context).center_menu_others,
                                          style: theme.bodySmall.
                                          copyWith(color: Colors.grey)
                                        )
                                      ),
                                    ),
                                    ...buildNavigationListTiles(theme, bottomListTiles, controller)
                                  ],
                                );
                              }
                            ),
                          ),
                          // Page container
                          AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return ClipRRect(
                                 borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 321,
                                  height: 540,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: theme.primary,
                                  ),
                                  child: controller.currentPage,
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      );
    }
  );
}

List<NavigationListTile> buildNavigationListTiles(StylesGetters theme, List<NavigationListTileModel> list, SidebarNavigationController controller) {
  List<NavigationListTile> listTilesList = [];
  for (NavigationListTileModel element in list) {
    NavigationListTile navigationListTile = NavigationListTile(
      controller, 
      element.index, 
      () {controller.setCurrentPage(element.routeName);},
      controller.getActive(element.index), 
      element.title, 
      element.icon
    );
    listTilesList.add(navigationListTile);
  }
  return listTilesList;
}
