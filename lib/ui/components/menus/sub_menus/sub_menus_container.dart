import 'dart:ui';

import 'package:flutter/material.dart';

Future<dynamic> showSubMenu(BuildContext context, Widget child, {bool isDisbissible = true}) async {
  return showDialog(
    barrierDismissible: isDisbissible,
    context: context,
    builder: (BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDisbissible) {
          Navigator.pop(context);
        }
      },
      child: Dismissible(
        key: UniqueKey(),
        dismissThresholds: {
          DismissDirection.down: isDisbissible ? 0.4 : 1
        },
        movementDuration: const Duration(milliseconds: 500),
        direction: DismissDirection.down,
        onDismissed: (direction) {
            Navigator.pop(context);
        },
        child: GestureDetector(
          onTap: () {
            // This does nothing, it stands only to prevent closing the menu by clicking it, 
            //because of the upper GestureDetector.
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
                ] 
              ),
            ),
          ),
        ),
      ),
    );
    }
 );
}