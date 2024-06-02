import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/ui/theme/theme.dart';

/// Shows a custom snackbar at the bottom of the screen, made to display informations with a button that can trigger an action
///   * [context] : Becauses it is a custom snackbar, it needs the context to work properly
///   * [message] : This is the main text of the snackbar, it's where you will give the user all the infos he needs
///   * [actionLabel] : This is the text that will be inside the button
///   * [action] : This is the action that will be triggered by the press of the button. If [action] is () {}, it will just close the snackbar
///   * [argument] : If passed, it will trigger the action with the given arguments
///   * [duration] : This is the duration of the snackar to be visible. Counted in second
void showBottomSnackBar(BuildContext context, String message, String actionLabel, Function action,  int duration, {dynamic argument}) {
  try{
    final overlay = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _CustomSnackbar(
        overlayEntry: overlayEntry!, 
        argument: argument, 
        action: action, 
        message: message, 
        actionLabel: actionLabel, 
        duration: duration
      )
    );
    overlay.insert(overlayEntry);
  }catch(e) {
    AppLogs.writeError(e, "snackbar.dart - showBottomSnackbar");
    return;
  }
}

class _CustomSnackbar extends StatefulWidget {
  const _CustomSnackbar({
    required this.overlayEntry,
    required this.argument,
    required this.action,
    required this.message,
    required this.actionLabel,
    required this.duration,
  });

  final OverlayEntry overlayEntry;
  final dynamic argument;
  final Function action;
  final String message;
  final String actionLabel;
  final int duration;

  @override
  State<_CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<_CustomSnackbar> with SingleTickerProviderStateMixin {
  bool _hasBeenClosed = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
    _waitTillNeedToClose(widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startCloseAnimation() {
    if (!_hasBeenClosed) {
      _controller.reverse().then((_) {
        widget.overlayEntry.remove();
      });
    }
  }

  void _waitTillNeedToClose(int duration) {
    Timer(Duration(seconds: duration), () {
      _startCloseAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Positioned(
      bottom: 8,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.down,
          onDismissed: (direction) {
            widget.overlayEntry.remove();
            _hasBeenClosed = true;
          },
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 550,
                  height: 65,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadow.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(5, 5)
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: IconButton(
                          tooltip: S.of(context).snackbar_cancel_button,
                          style: ButtonThemes.secondaryButtonStyle(context),
                          onPressed: () {
                            _startCloseAnimation();
                            _hasBeenClosed = true;
                            return;
                          }, 
                          icon: Icon(Icons.close_rounded, color: theme.onPrimary),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: theme.bodyMedium.copyWith(color: theme.onSurface),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        style: ButtonThemes.primaryButtonStyle(context),
                        onPressed: () async {
                          widget.argument != null 
                            ? await widget.action(widget.argument) 
                            : await widget.action();
                          _startCloseAnimation();
                          _hasBeenClosed = true;
                          return;
                        },
                        child: Text(
                          widget.actionLabel,
                          style: theme.bodyMedium.copyWith(color: theme.onSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
