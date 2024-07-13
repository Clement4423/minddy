import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableCalculationExplanationTooltip extends StatelessWidget {
  const CustomTableCalculationExplanationTooltip({
    super.key, 
    required this.theme,
    required this.message, 
    required this.example, 
    required this.child
  });

  final StylesGetters theme;
  final String message;
  final String example;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            offset: const Offset(5, 5),
            blurRadius: 20,
          )
        ]
      ),
      richMessage: WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(example, style: theme.titleMedium.copyWith(fontWeight: FontWeight.w300)), // TODO : Faire sonner les textes plus simples
              Container(
                width: 100,
                height: 3,
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: theme.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1)
                ),
              ),
              Text(message, style: theme.bodyMedium)
            ],
          ),
        )
      ),
      preferBelow: true,
      child: child,
    );
  }
}
