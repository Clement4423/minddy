import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/theme/theme.dart';

// DO NOT add any tooltip to this widget, as it will throw an error, 
// as no Overlay widget can be created due to where the NotificationBuilder is placed in the app

enum NotificationDuration {
  short,
  long,
  untilClosed
}

class _NotificationDurationRemainUpdater extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class NotificationWidget extends StatefulWidget { 
  const NotificationWidget({
    super.key,
    required this.state,
    required this.theme,
    required this.ammountOfNotifications
  });

  final NotificationState state;
  final StylesGetters theme;
  final int ammountOfNotifications;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> with SingleTickerProviderStateMixin {
  bool needToFadeIn = true;
  bool _hasBeenClosed = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  _NotificationDurationRemainUpdater durationRemainUpdater = _NotificationDurationRemainUpdater();

  late Animation<double> _noFadeAnimation;

  // Calculate percentage from remaining time
  double get durationPercentage {
    return widget.state.timer.remainingTime / widget.state.timer.duration;
  }

  @override
  void initState() {
    super.initState();

    // Initialize the Animation Controller for sliding effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _noFadeAnimation = Tween<double>(
      begin: 1.0, 
      end: 1.0
    ).animate(_controller);

    // Forward the sliding animation
    _controller.forward();

    _handleTimer();
  }

  void _handleTimer() {
    if (widget.state.model.duration != NotificationDuration.untilClosed) {
      if (widget.state.timer.timer == null || !widget.state.timer.timer!.isActive) {
        needToFadeIn = true;
        widget.state.timer.start();
      } else {
        needToFadeIn = false; // Timer was already shwon, as the timer is already running.
      }

      widget.state.timer.onTick = (remainingTime) {
        if (_hasBeenClosed || remainingTime <= 0) {
          _startCloseAnimation();
        } else {
          durationRemainUpdater.notify();
        }
      };
    }
  }

  void _startCloseAnimation() {
    // Here we ensure that the animation that is going to play is the fade animation.
    // Otherwise, if the widget started with the _noFadeAnimation, the controller will reverse with no fade.
    setState(() {
      needToFadeIn = true;
    });

    if (!_hasBeenClosed) {
      _controller.reverse().then((_) {
        _hasBeenClosed = true;
        widget.state.timer.stop();
        NotificationHandler.removeNotification(widget.state.model);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    durationRemainUpdater.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    return FadeTransition(
      opacity: needToFadeIn ? _fadeAnimation : _noFadeAnimation,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.down,
        onDismissed: (direction) {
          _hasBeenClosed = true;
          widget.state.timer.stop();
          NotificationHandler.removeNotification(widget.state.model);
        },
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Stack(
                    children: [
                      Container(
                        width: 550,
                        height: 65,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: widget.theme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: widget.theme.shadow.withOpacity(0.10),
                              blurRadius: 10,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10, left: 3),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  style: ButtonThemes.secondaryButtonStyle(context),
                                  onPressed: () {
                                    _startCloseAnimation();
                                    return;
                                  },
                                  icon: Icon(
                                    Icons.close_rounded, 
                                    color: widget.theme.onPrimary,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.state.model.content,
                                style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            TextButton(
                              style: ButtonThemes.primaryButtonStyle(context),
                              onPressed: () async {
                                if (widget.state.model.action != null) {
                                  widget.state.model.action!();
                                }
                                _startCloseAnimation();
                              },
                              child: Text(
                                widget.state.model.actionLabel,
                                style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Duration indicator
                      if (widget.state.model.duration != NotificationDuration.untilClosed)
                        AnimatedBuilder(
                          animation: durationRemainUpdater,
                          builder: (context, child) {
                            return Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                width: 550,
                                height: 5,
                                child: LinearProgressIndicator(
                                  value: durationPercentage, // Use the percentage from state timer
                                  color: DefaultAppColors.blue.color,
                                  backgroundColor: widget.theme.onPrimary,
                                ),
                              ),
                            );
                          },
                        )
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