import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ShortcutActivator escapeActivator = const SingleActivator(LogicalKeyboardKey.escape);

Future<dynamic> showSubMenu(BuildContext context, Widget child, {bool isDismissible = true, Function? onMenuDismissed}) async {
  return showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (BuildContext context) {
      return CallbackShortcuts(
        bindings: {
          escapeActivator: () async {
            if (isDismissible) {
              if (onMenuDismissed != null) {
                await onMenuDismissed();
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          }
        },
        child: Focus(
          child: GestureDetector(
            onTap: () async {
              if (isDismissible) {
                if (onMenuDismissed != null) {
                  await onMenuDismissed();
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Dismissible(
              key: UniqueKey(),
              dismissThresholds: {
                DismissDirection.down: isDismissible ? 0.4 : 1.0,
              },
              movementDuration: const Duration(milliseconds: 500),
              direction: DismissDirection.down,
              onDismissed: (direction) async {
                if (onMenuDismissed != null) {
                  await onMenuDismissed();
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: GestureDetector(
                onTap: () {
                  // This does nothing, it stands only to prevent closing the menu by clicking it,
                  // because of the upper GestureDetector.
                },
                child: Center(
                  child: Material(
                    type: MaterialType.transparency,
                    elevation: 7,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}