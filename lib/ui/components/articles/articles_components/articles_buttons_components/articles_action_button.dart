import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

/// Creates a button that takes a method to perform an action
class ArticlesActionButton extends StatelessWidget {
  final Function action;
  final IconData icon;
  final String semanticLabel;
  const ArticlesActionButton({required this.icon, required this.action ,super.key, required this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 0, right: 0, left: 8),
      child: IconButton(
        onPressed: () {
          action();
        },
        tooltip: semanticLabel,
        icon: Icon(icon, color: theme.onPrimary, semanticLabel: semanticLabel),
        style: ButtonThemes.secondaryButtonStyle(context).
        copyWith(backgroundColor: MaterialStatePropertyAll(theme.primaryContainer)),
      ),
    );
  }
}