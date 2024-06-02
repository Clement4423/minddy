import 'package:flutter/material.dart';
import 'package:minddy/system/projects/tools/countdown_timer.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_controller.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_timer_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class PomodoroToolFocusTimerView extends StatefulWidget {
  const PomodoroToolFocusTimerView({super.key});

  @override
  State<PomodoroToolFocusTimerView> createState() => _PomodoroToolFocusTimerViewState();
}

class _PomodoroToolFocusTimerViewState extends State<PomodoroToolFocusTimerView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 55),
          child: Center(
            child: StreamBuilder<int>(
               stream: PomodoroToolController.timerStream,
               initialData: PomodoroToolController.focusTimerDuration,
               builder: (context, snapshot) {
                 if (snapshot.data == 0) {
                    PomodoroToolController.timer = CountdownTimer(durationInSeconds: PomodoroToolController.workingDuration);
                    PomodoroToolController.startTimer();
                    PomodoroToolController.setActualView(PomodoroToolTimerView(key: UniqueKey()));
                 }
                 return Text(
                   snapshot.data.toString(),
                   style: theme.headlineLarge.copyWith(color: theme.onSurface, fontSize: 60),
                 );
               }
             ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 50,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: TextButton(
                onPressed: () {
                  PomodoroToolController.resetEverything();
                },
                style: ButtonThemes.primaryButtonStyle(context),
                child: Text("Stop", style: theme.titleSmall.
                copyWith(color: theme.onSecondary)),
              ),
            ),
          ),
        )
      ]
    );
  }
}