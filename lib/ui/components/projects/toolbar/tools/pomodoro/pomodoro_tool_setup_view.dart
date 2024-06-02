import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/projects/tools/countdown_timer.dart';
import 'package:minddy/ui/components/custom_elements/switch_tile.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_controller.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_timer_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class PomodoroToolSetupView extends StatelessWidget {
  const PomodoroToolSetupView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _ValueContainer(
                  theme: theme,
                  title: S.of(context).tool_pomodoro_work_duration, 
                  onChanged: (value) {
                    if (value.isNaN || value == 0 || value > 120) {
                      value = 25;
                    }
                    PomodoroToolController.setWorkingDuration(value * 60);
                  }, 
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), 
                    topRight: Radius.circular(10)), 
                  defaultValue: (PomodoroToolController.workingDuration / 60).round()
                ),
                _ValueContainer(
                  theme: theme,
                  title: S.of(context).tool_pomodoro_break_duration, 
                  onChanged: (value) {
                    if (value.isNaN || value == 0 || value > 40) {
                      value = 5;
                    }                    
                    PomodoroToolController.setBreakDuration(value * 60);
                  }, 
                  borderRadius: null,
                  defaultValue: (PomodoroToolController.breakDuration / 60).round()
                ),
                _ValueContainer(
                  theme: theme,
                  title: S.of(context).tool_pomodoro_repetition_count, 
                  onChanged: (value) {
                    if (value.isNaN || value == 0 || value > 20) {
                      value = PomodoroToolController.repetitionCount;
                    }
                    PomodoroToolController.setRepetitionsCount(value);
                  }, 
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10), 
                    bottomRight: Radius.circular(10)),
                  defaultValue: 4
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: SwitchTile(
            PomodoroToolController.useFocusTimer, 
            S.of(context).tool_pomodoro_focus_timer, 
            (value) {
              PomodoroToolController.setUseFocusTimer(value);
            }, 
            false
          )
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
                  if (PomodoroToolController.useFocusTimer) {
                    PomodoroToolController.startFocusTimer();
                    return;
                  } else {
                    PomodoroToolController.timer = CountdownTimer(durationInSeconds: PomodoroToolController.workingDuration);
                  }
                  PomodoroToolController.setActualView(PomodoroToolTimerView(key: UniqueKey()));
                  PomodoroToolController.startTimer();
                },
                style: ButtonThemes.primaryButtonStyle(context),
                child: Text(S.of(context).tool_pomodoro_start_button, style: theme.titleSmall.copyWith(color: theme.onSecondary)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ValueContainer extends StatefulWidget {
  const _ValueContainer({required this.title, required this.onChanged, required this.borderRadius, required this.defaultValue, required this.theme});

  final String title;
  final Function(int) onChanged;
  final BorderRadius? borderRadius;
  final int defaultValue;

  final StylesGetters theme;

  @override
  State<_ValueContainer> createState() => _ValueContainerState();
}

class _ValueContainerState extends State<_ValueContainer> {

  FocusNode focusNode = FocusNode();

  late Color color = widget.theme.surface;

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          color = widget.theme.surface.withOpacity(0.8);
        });
      },
      onExit: (event) {
        setState(() {
          color = widget.theme.surface;
        });
      },
      child: GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Container(
          width: 290,
          height: 45,
          margin: const EdgeInsets.only(bottom: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: widget.borderRadius,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.title,
                    style: widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    onChanged: (value) {
                      widget.onChanged(int.tryParse(value) ?? widget.defaultValue);
                    },
                    focusNode: focusNode,
                    cursorColor: widget.theme.onSurface,
                    textAlign: TextAlign.center,
                    style: widget.theme.bodySmall.copyWith(fontSize: 15),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.defaultValue.toString(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}