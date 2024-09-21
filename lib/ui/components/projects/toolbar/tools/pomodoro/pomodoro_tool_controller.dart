import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/projects/tools/countdown_timer.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_focus_timer_view.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_setup_view.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_timer_view.dart';

enum PomodoroSession {
  working,
  pause
}

class PomodoroToolController {

  static int _repetitionsCount = 4;
  static int _workingDuration = 25 * 60;
  static int _breakDuration = 5 * 60;
  static int _doneRepetitions = 0;
  static bool _useFocusTimer = false;
  static Widget _actualView = const PomodoroToolSetupView();
  static CountdownTimer? timer;

  static int focusTimerDuration = 120;

  static bool isShown = true;

  static PomodoroSession currentSession = PomodoroSession.working;

  static final _controller = StreamController<bool>.broadcast();

  static final _timerStream = StreamController<int>.broadcast();

  static Stream<int> get timerStream => _timerStream.stream;

  static Stream<bool> get stream => _controller.stream;

  static int get repetitionCount => _repetitionsCount;
  static int get workingDuration => _workingDuration;
  static int get breakDuration => _breakDuration;
  static int get doneRepetitions => _doneRepetitions;
  static bool get useFocusTimer => _useFocusTimer;
  static Widget get actualView => _actualView;


  static void _notify() {
    _controller.add(true);
  }

  static void nextRound(BuildContext context, [bool showMessage = true]) {
    switch (currentSession) {
      case PomodoroSession.working:
        _doneRepetitions++;
        bool allRepetitionsDone = _areAllRepetitionsDone(context);
        if (allRepetitionsDone) {
          resetEverything();
          if (showMessage) {
            int totalWorkingDuration = _workingDuration * _doneRepetitions;
            PomodoroToolController.showMessage(
              S.current.tool_pomodoro_end_session(totalWorkingDuration)
            );
          }
        }

        if (showMessage) {
          PomodoroToolController.showMessage(S.current.tool_pomodoro_break_snackbar(_breakDuration ~/ 60));
        }

        currentSession = PomodoroSession.pause;
        timer = CountdownTimer(durationInSeconds: _breakDuration);
        startTimer();
        setActualView(const PomodoroToolTimerView());
        break;
      case PomodoroSession.pause:
        if (showMessage) {
          PomodoroToolController.showMessage(S.current.tool_pomodoro_work_snackbar(_workingDuration ~/ 60));
        }
        currentSession = PomodoroSession.working;
        timer = CountdownTimer(durationInSeconds: _workingDuration);
        startTimer();
        setActualView(const PomodoroToolTimerView());
        break;
    }
  }

  static bool _areAllRepetitionsDone(BuildContext context) {
    if (_doneRepetitions >= _repetitionsCount) {
      return true;
    } else {
      return false;
    }
  } 

  static void showMessage(String message) {
      NotificationHandler.addNotification(
        NotificationModel(
          content: message,
          action: null,
          actionLabel: S.current.snacbar_close_button, 
          duration: NotificationDuration.long
        )
      );
  } 

  static void startTimer() {
    if (timer != null) {
      timer!.start(() {
        if (PomodoroToolController.isShown) {
          addToTimerStream(timer!.remainingTime);
        }
      });
    }
  }

  static void addToTimerStream(int value) {
    _timerStream.add(value);
  }

  static void setActualView(Widget newView) {
    _actualView = newView;
    _notify();
  }

  static void resetEverything() {
    timer?.stop();
    _doneRepetitions = 0;
    timer = null;
    currentSession = PomodoroSession.working;
    _actualView = const PomodoroToolSetupView();
    _notify();
  }


  static void startFocusTimer() {
    timer = CountdownTimer(durationInSeconds: focusTimerDuration);
    startTimer();
    setActualView(const PomodoroToolFocusTimerView());
  }

  static void setDoneRepetitions(int newCount) {
    _doneRepetitions = newCount;
    _notify();
  }

  static void setWorkingDuration(int newWorkingDuration) {
    _workingDuration = newWorkingDuration;
    _notify();
  }

  static void setBreakDuration(int newBreakDuration) {
    _breakDuration = newBreakDuration;
    _notify();
  }

  static void setRepetitionsCount(int newRepetitionsCount) {
    _repetitionsCount = newRepetitionsCount;
    _notify();
  }

  static void setUseFocusTimer(bool newValue) {
    _useFocusTimer = newValue;
    _notify();
  }

  static void dispose() {
    _controller.close();
    _timerStream.close();
  }
}
