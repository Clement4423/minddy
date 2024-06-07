import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final Duration? waitDuration;
  final int lengthTreshold;
  const CustomTooltip({super.key, required this.message, required this.child, this.waitDuration, this.lengthTreshold = 1});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return message.length > lengthTreshold
    ? Tooltip(
      richMessage: WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: Text(
            message,
            style: theme.bodyMedium
            .copyWith(color: theme.onSecondary)
          ),
        )
      ),
      waitDuration: waitDuration,
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 5),
            blurRadius: 15,
            color: theme.shadow.withOpacity(0.20),
          ),
        ],
      ),
      child: child,
    ) 
    : child;
  }
}