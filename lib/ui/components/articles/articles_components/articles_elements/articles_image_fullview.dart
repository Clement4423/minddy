import 'dart:ui';

import 'package:flutter/material.dart';

Future<dynamic> showFullImage(Image image, BuildContext context) async {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(),
                )
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.9, maxHeight: screenHeight * 0.9),
                    child: image
                  )
                )
              )
            ],
          ),
        ),
      );
    });
}