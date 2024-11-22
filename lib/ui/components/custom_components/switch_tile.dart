import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class SwitchTile extends StatefulWidget {
  final bool value;
  final String title;
  final bool needToRestart;
  final bool enabled;
  final EdgeInsets? margin;
  final Function(bool value) action;
  const SwitchTile(
    this.value,
    this.title,
    this.action,
    this.needToRestart, {
      super.key, 
      this.margin,
      this.enabled = true
    }
  );

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {

  bool _isSwitched = false;

  Future<void> triggerSwitch() async {
    setState(() {
      _isSwitched = !_isSwitched;                
    });
    
    await widget.action(_isSwitched);
    if (widget.needToRestart && mounted) {
      NotificationHandler.addNotification(
        NotificationModel(
          content: S.of(context).snackbar_restart_needed_text,
          action: closeApp, 
          actionLabel: S.of(context).snackbar_restart_button, 
          duration: NotificationDuration.long
        )
      );
    } 
  }

  @override
    void initState() {
      _isSwitched = widget.value;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: widget.margin ?? const EdgeInsets.only(top: 2, bottom: 2),
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () async {
            widget.enabled 
            ? await triggerSwitch()
            : () {};
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.enabled ? theme.surface : Colors.grey,
              borderRadius: BorderRadius.circular(15)
            ),
            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.bodyMedium.copyWith(color: widget.enabled ? theme.onSurface : const Color.fromARGB(255, 120, 120, 120)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                Switch(
                  activeColor: widget.enabled ? theme.primary : Colors.grey,
                  thumbColor: WidgetStatePropertyAll(widget.enabled ? _isSwitched ? theme.onSecondary : theme.secondary : const Color.fromARGB(255, 120, 120, 120)),
                  trackColor: WidgetStatePropertyAll(widget.enabled ? _isSwitched ? theme.secondary : theme.primary : Colors.grey),
                  trackOutlineColor: WidgetStatePropertyAll(widget.enabled ? theme.secondary : const Color.fromARGB(255, 120, 120, 120)),
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  activeTrackColor: widget.enabled ? theme.secondary : const Color.fromARGB(255, 120, 120, 120),
                  value: _isSwitched,
                  onChanged: (value) async {
                    widget.enabled 
                    ? await triggerSwitch()
                    : () {};
                  },
                  mouseCursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

closeApp() {
  SystemNavigator.pop();
}