import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.shadow.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(5, 5)
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: theme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // ignore: deprecated_member_use
                  child: SvgPicture.asset("assets/logo/calendar/Calendar${DateTime.now().day}.svg", color: theme.onPrimary),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}