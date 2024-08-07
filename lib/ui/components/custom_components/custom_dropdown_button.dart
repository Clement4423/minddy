import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDropdownButton extends StatelessWidget {
  final String menuTitle;
  final Function action;
  final List<DropdownMenuItem<dynamic>> items;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enabled;
  final bool needToRestart;

  const CustomDropdownButton({
    required this.menuTitle,
    required this.action,
    required this.items,
    required this.needToRestart,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: enabled ? backgroundColor ?? theme.surface : Colors.grey,
      ),
      padding: const EdgeInsets.only(left: 15, right: 12),
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down_rounded, color: enabled ? foregroundColor ?? theme.onSurface : const Color.fromARGB(255, 130, 130, 130)),
        iconSize: 25,
        hint: Text(
          menuTitle, 
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.bodyMedium.
          copyWith(color: enabled ? foregroundColor ?? theme.onSurface : const Color.fromARGB(255, 130, 130, 130))
        ),
        elevation: 12,
        style: theme.bodyMedium.copyWith(color: backgroundColor ?? theme.onSurface),
        borderRadius: BorderRadius.circular(10),
        underline: const SizedBox(),
        dropdownColor: enabled ? backgroundColor ?? theme.surface : Colors.grey,
        isExpanded: true,
        items: enabled ? items : [],
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
    );
  }
}
