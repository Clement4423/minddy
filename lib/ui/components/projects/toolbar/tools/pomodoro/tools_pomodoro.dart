import 'package:flutter/material.dart';
import 'package:minddy/ui/components/projects/toolbar/tool_container.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/pomodoro_tool_controller.dart';

class ToolPomodoro extends StatefulWidget {
  const ToolPomodoro({super.key});

  @override
  State<ToolPomodoro> createState() => _ToolPomodoroState();
}

class _ToolPomodoroState extends State<ToolPomodoro> {
  @override
  Widget build(BuildContext context) {
    return ToolContainer(
      tooltip: "Pomodoro",
      icon: const Icon(Icons.timer_outlined),
      onOpened: () {
        PomodoroToolController.isShown = true;
      },
      onClosed: () {
        PomodoroToolController.isShown = false;
      },
      content: StreamBuilder<bool>(
        stream: PomodoroToolController.stream,
        builder: (context, snapshot) {
          return PomodoroToolController.actualView;
        }
      ),
    );
  }
}


