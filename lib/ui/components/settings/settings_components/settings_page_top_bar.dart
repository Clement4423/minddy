import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class SettingsPagebar extends StatelessWidget {
  final String title;
  const SettingsPagebar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          title,
          style: theme.titleLarge.
          copyWith(color: theme.onPrimary),
        ),
      ),
    );
  }
}