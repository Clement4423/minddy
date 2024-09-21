import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTextButton extends StatelessWidget {
  final Function action;
  final String title;
  final bool needsContext;
  final bool needToRestart;
  final bool isCritic;
  final bool isSecondary;

  CustomTextButton(this.title, this.action, this.needsContext, this.needToRestart, {super.key, this.isCritic = false, this.isSecondary = false}) {
    assert(isCritic == true || isSecondary == true || isSecondary == false && isCritic == false);
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return TextButton(
      onPressed: () async {
        needsContext ? await action(context) : await action();
        if (needToRestart && context.mounted) {
          NotificationHandler.addNotification(
            NotificationModel(
              content: S.of(context).snackbar_restart_needed_text,
              action: null, 
              actionLabel: S.of(context).snackbar_restart_button, 
              duration: NotificationDuration.long
            )
          );
        }
      },
      style: isCritic 
        ? ButtonThemes.crititcButtonTheme(context)
        : isSecondary 
          ? ButtonThemes.secondaryButtonStyle(context) 
          : ButtonThemes.primaryButtonStyle(context),
      child: Text(
        title, 
        style: theme.titleSmall
        .copyWith(color: isCritic ? theme.onError : isSecondary ? theme.onPrimary : theme.onSecondary)
      )
    );
  }
}
