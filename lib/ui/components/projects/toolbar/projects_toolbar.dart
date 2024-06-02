import 'package:flutter/material.dart';
import 'package:minddy/ui/components/projects/toolbar/tools/pomodoro/tools_pomodoro.dart';

class ProjectsToolbar extends StatelessWidget {
  const ProjectsToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            color: Colors.transparent,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ToolPomodoro(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}