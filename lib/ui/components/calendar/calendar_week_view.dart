import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/shortcuts/shortcuts_activators.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_back_button.dart';
import 'package:minddy/ui/components/calendar/calendar_bottom_menu.dart';
import 'package:minddy/ui/components/calendar/calendar_bottom_menu_controller.dart';
import 'package:minddy/ui/components/calendar/calendar_week_view_panel.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_controller.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_panel_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_due_date_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarWeekView extends StatefulWidget {
  const CalendarWeekView({
    super.key,
    required this.controller,
    required this.theme,
    this.onClosed
  });

  final CalendarWeekViewController controller;
  final Function? onClosed;
  final StylesGetters theme;

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {

  bool _isClosing = false;

  Future<void> _closeView(BuildContext context) async {
    if (context.mounted) {
      setState(() {
        _isClosing = true;
      });
      Future.delayed(Duration(milliseconds: _isClosing ? 150 : 250), () async {
        if (widget.onClosed != null) {
          await widget.onClosed!();
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: _isClosing ? 150 : 250),
      curve: Curves.easeInOut,
      tween: Tween(
        begin: _isClosing ? 1.0 : 0.0,
        end: _isClosing ? 0.0 : 1.0
      ),
      builder:(context, opacity, child) {
        return AnimatedBuilder(
          animation: widget.controller, 
          builder: (context, child) {
            return Opacity(
              opacity: opacity,
              child: Material(
                type: MaterialType.transparency,
                elevation: 12,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          color: widget.theme.secondaryContainer.withValues(alpha: 0.70),
                          child: Container(),
                        ),
                      ),
                    ),
                    CallbackShortcuts(
                      bindings: <ShortcutActivator, VoidCallback>{
                        escapeActivator:() async {
                          if (context.mounted) {
                            await _closeView(context);
                          }
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 75,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // Back button
                                    ArticlesBackButton(
                                      action: () async {
                                        await _closeView(context);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        S.of(context).calendar_week_view_week_title(widget.controller.selectedWeek),
                                        style: widget.theme.titleLarge
                                          .copyWith(color: widget.theme.onPrimary),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8, top: 6),
                                      child: CustomSelectionMenu(
                                        theme: widget.theme, 
                                        type: CustomSelectionMenuButttonType.icon,
                                        buttonStyle: ButtonThemes.secondaryButtonStyle(context).
                                          copyWith(backgroundColor: WidgetStatePropertyAll(widget.theme.primaryContainer)),
                                        items: [
                                          CustomSelectionMenuItem(
                                            label: S.of(context).calendar_button_new_event_button_title, 
                                            icon: Icons.event_rounded, 
                                            onTap: () async {
                                              await showSubMenu(context, NewCalendarEventSubMenu(
                                                onSelected: (event) async {
                                                  await AppCalendar.addEvent(event);
                                                  widget.controller.update();
                                                }, 
                                                theme: widget.theme
                                              ));
                                            }
                                          ),
                                          CustomSelectionMenuItem(
                                            label: S.of(context).calendar_button_new_due_date_button_title, 
                                            icon: Icons.timelapse_rounded, 
                                            onTap: () async {
                                              await showSubMenu(context, NewCalendarDueDateSubMenu(
                                                onSelected: (event) async {
                                                  await AppCalendar.addEvent(event);
                                                  widget.controller.update();
                                                }, 
                                                theme: widget.theme
                                              ));
                                            }
                                          )
                                        ], 
                                        child: Icon(
                                          Icons.add_rounded, 
                                          color: widget.theme.onPrimary,
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              Size windowSize = MediaQuery.of(context).size;
                              return SizedBox(
                                width: windowSize.width / 1.2,
                                height: windowSize.height / 1.2,
                                child: CalendarWeekViewPanel(
                                  key: UniqueKey(),
                                  theme: widget.theme, 
                                  controller: CalendarWeekViewPanelController(
                                    width: windowSize.width / 1.2, 
                                    height: windowSize.height / 1.2, 
                                    week: widget.controller.selectedWeek, 
                                    year: widget.controller.selectedYear,
                                    onUpdate: widget.controller.update,
                                    highlightedEventID: widget.controller.highlightedEventID,
                                    resetHighligthedEvent: widget.controller.resetHighligthedEvent
                                  )
                                ),
                              );
                            }
                          )
                        ],
                      )
                    ),
                    FutureBuilder(
                      future: widget.controller.getCalendarsAndEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Positioned(
                            bottom: 0,
                            right: 0, 
                            child: CalendarBottomMenu(
                              key: widget.controller.bottomMenuKey,
                              controller: CalendarBottomMenuController(calendarWeekViewController: widget.controller)
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    ), 
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}