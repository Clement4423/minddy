import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class PomodoroToolTimerView extends StatefulWidget {
  const PomodoroToolTimerView({
    super.key,
  });

  @override
  State<PomodoroToolTimerView> createState() => _PomodoroToolTimerViewState();
}

class _PomodoroToolTimerViewState extends State<PomodoroToolTimerView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return ListView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CyclesCounter(
                  totalCycleCount: PomodoroToolController.repetitionCount, 
                  completedCycles: PomodoroToolController.doneRepetitions
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TimerView(key: UniqueKey()),
              )
            ],
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
                child: Text(S.of(context).tool_pomodoro_stop_button, style: theme.titleSmall.
                copyWith(color: theme.onSecondary)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TimerView extends StatefulWidget {
  const TimerView({super.key});


  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {

  String formatTimerInMinutes(int remainingTimeInSeconds) {
    if (remainingTimeInSeconds == 0) {
      PomodoroToolController.nextRound();
    }
    final int minutes = remainingTimeInSeconds ~/ 60;
    final int seconds = remainingTimeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 250,
      height: 140,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: SingleChildScrollView(
        child: StreamBuilder<int>(
          stream: PomodoroToolController.timerStream,
          builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 5),
                  child: Text(
                    formatTimerInMinutes(PomodoroToolController.timer != null ? PomodoroToolController.timer!.remainingTime : 0),
                    style: theme.headlineLarge.copyWith(color: theme.onSurface, fontSize: 60),
                  ),
                ),
                Text(
                  PomodoroToolController.currentSession == PomodoroSession.working 
                    ? S.of(context).tool_pomodoro_work_session 
                    : S.of(context).tool_pomodoro_break_session, 
                  style: theme.bodyMedium.copyWith(color: theme.onSurface)
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

class CyclesCounter extends StatefulWidget {
  const CyclesCounter({
    super.key, 
    required this.totalCycleCount, 
    required this.completedCycles
  });

  final int totalCycleCount;
  final int completedCycles;

  @override
  State<CyclesCounter> createState() => _CyclesCounterState();
}

class _CyclesCounterState extends State<CyclesCounter> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SizedBox(
          width: widget.totalCycleCount * 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.totalCycleCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: index >= widget.completedCycles 
                        ? Colors.transparent 
                        : theme.secondary,
                    border: Border.all(color: theme.secondary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
