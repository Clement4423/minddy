import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';
import 'package:minddy/ui/theme/theme.dart';

class SwitchTile extends StatefulWidget {
  final bool value;
  final String title;
  final bool needToRestart;
  final Function(bool value) action;
  const SwitchTile(
    this.value,
    this.title,
    this.action,
    this.needToRestart,
    {super.key}
  );

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {

  bool _isSwitched = false;

  Future<void>  triggerSwitch() async {
    setState(() {
      _isSwitched = !_isSwitched;                
    });
    await widget.action(_isSwitched);
    if (widget.needToRestart && mounted) {
      showBottomSnackBar(
        context, 
        S.of(context).snackbar_restart_needed_text, 
        S.of(context).snackbar_restart_button, 
        closeApp,
        7
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
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            triggerSwitch();
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.bodyMedium.copyWith(color: theme.onSurface),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Switch(
                  activeColor: theme.primary,
                  thumbColor: MaterialStatePropertyAll(theme.secondary),
                  trackColor: MaterialStatePropertyAll(theme.primary),
                  trackOutlineColor: MaterialStatePropertyAll(theme.secondary),
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  activeTrackColor: theme.secondary,
                  value: _isSwitched,
                  onChanged: (value) async {
                    await triggerSwitch();
                  }
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