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
      margin: const EdgeInsets.only(left: 490),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withValues(alpha: 0.2),
            offset: const Offset(5, 5),
            blurRadius: 20,
          )
        ]
      ),
      richMessage: WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(example, style: theme.titleMedium.copyWith(fontWeight: FontWeight.w300)),
                  Container(
                    width: 100,
                    height: 3,
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                      color: theme.onSurface.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(1)
                    ),
                  ),
                  Text(message, style: theme.bodySmall)
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 5,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    border: Border.all(color: theme.onSurface, width: 2),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Icon(Icons.close_rounded, color: theme.onSurface, size: 16,),
                ),
              ),
            ),
          ],
        )
      ),
      preferBelow: false,
      child: child,
    );
  }
}
