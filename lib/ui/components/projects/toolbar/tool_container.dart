import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';


/// If the content is a Column, wrap it within a SingleChildScrollView.
class ToolContainer extends StatefulWidget {
  const ToolContainer({super.key, required this.icon, required this.content, required this.tooltip, this.onOpened, this.onClosed});

  final Widget icon;
  final Widget content;
  final String tooltip;
  final Function? onOpened;
  final Function? onClosed;

  @override
  State<ToolContainer> createState() => _ToolContainerState();
}

class _ToolContainerState extends State<ToolContainer> {
  bool _isClosed = true;

  late Widget actualWidget;

  @override
  void initState() {
    actualWidget = widget.icon;
    super.initState();
  }

  void changeWidget() {
    if (_isClosed) {
      if (widget.onClosed != null) {
        widget.onClosed!();
      } 
      actualWidget = widget.icon;
    } else {
      if (widget.onOpened != null) {
        widget.onOpened!();
      }
      actualWidget = widget.content;
    }
  }

  void toggleOpening() {
    setState(() {
      _isClosed = !_isClosed;
      changeWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: MouseRegion(
        cursor: _isClosed ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () {
            toggleOpening();
          },
          child: Tooltip(
            message: widget.tooltip,
            preferBelow: true,
            waitDuration: const Duration(milliseconds: 500),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubicEmphasized,
              width: _isClosed ? 45 : 300,
              height: _isClosed ? 45 : 300,
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _isClosed ? 0 : 3, sigmaY: _isClosed ? 0 : 3),
                  child: actualWidget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
