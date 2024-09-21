import 'package:flutter/material.dart';

class AnimatedRouteBuilder extends PageRouteBuilder {
  final Widget page;

  AnimatedRouteBuilder({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {

        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
            ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
}