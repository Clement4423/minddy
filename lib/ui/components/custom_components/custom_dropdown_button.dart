import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDropdownButton extends StatelessWidget {
  final String menuTitle;
  final dynamic controller;
  final Function action;
  final List<DropdownMenuItem<dynamic>> items;
  final bool needToRestart;

  const CustomDropdownButton({
    required this.menuTitle,
    required this.action,
    required this.controller,
    required this.items,
    required this.needToRestart,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.surface,
        ),
        padding: const EdgeInsets.only(left: 15, right: 12),
        child: DropdownButton(
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: 25,
          hint: Text(
            menuTitle, 
            style: theme.bodyMedium.
            copyWith(color: theme.onSurface)
          ),
          elevation: 12,
          style: theme.bodyMedium,
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          isExpanded: true,
          items: items,
          onChanged: (value) async {
            await action(value);
            if (needToRestart && context.mounted) {
              showBottomSnackBar(
                context, 
                S.of(context).snackbar_restart_needed_text, 
                S.of(context).snackbar_restart_button, 
                closeApp,
                7
              );
            }
          },
        ),
      ),
    );
  }
}
