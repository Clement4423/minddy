import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/calendar/calendar_bottom_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarBottomMenu extends StatefulWidget {
  final CalendarBottomMenuController controller;
  const CalendarBottomMenu({super.key, required this.controller});

  @override
  State<CalendarBottomMenu> createState() => _CalendarBottomMenuState();
}

class _CalendarBottomMenuState extends State<CalendarBottomMenu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // Check if the user is dragging upwards
        if (details.primaryDelta! < 0) {
          setState(() {
            widget.controller.isClosed = false;
          });
        } else {
          setState(() {
            widget.controller.isClosed = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
                child: AnimatedContainer(
                  constraints: const BoxConstraints(
                    maxWidth: 350
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubicEmphasized,
                  width: widget.controller.isClosed ? screenWidth / 5 : 350,
                  height: widget.controller.isClosed ? 56 : 400,
                  decoration: BoxDecoration(
                    color: theme.primaryContainer,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
                      width: 0.5
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Top bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Buttons for pages buttons
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // Week
                                        SizedBox(
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () {
                                              widget.controller.setCurrentPage('/week');
                                              widget.controller.setCurrentSelected(0);
                                              widget.controller.updateMenu();
                                            },
                                            style: widget.controller.getActive(0)
                                              ? ButtonThemes.primaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0))
                                              : ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
                                            child: Text(
                                              "Week",
                                              style: theme.bodyMedium.copyWith(
                                                color: widget.controller.getActive(0)
                                                  ? theme.onSecondary
                                                  : theme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Button to open or close the menu
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.controller.isClosed = !widget.controller.isClosed;
                                      });
                                    },
                                    tooltip: widget.controller.isClosed 
                                    ? S.of(context).articles_bottom_menu_open_semantic_text
                                    : S.of(context).articles_bottom_menu_close_semantic_text,
                                    style: ButtonThemes.secondaryButtonStyle(context),
                                    icon: AnimatedRotation(
                                      duration: const Duration(milliseconds: 300),
                                      turns: widget.controller.isClosed 
                                      ? 0
                                      : -0.5,
                                      child: Icon(Icons.keyboard_arrow_up_rounded,
                                          color: theme.onPrimary, 
                                          size: 24,
                                          semanticLabel: widget.controller.isClosed 
                                            ? S.of(context).articles_bottom_menu_open_semantic_text
                                            : S.of(context).articles_bottom_menu_close_semantic_text,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Bottom menu content
                          if (!widget.controller.isClosed)
                            widget.controller.currentPage
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}