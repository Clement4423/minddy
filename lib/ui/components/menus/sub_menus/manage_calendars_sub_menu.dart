import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/utils/ui_updater.dart';

class ManageCalendarsSubMenu extends StatefulWidget {
  const ManageCalendarsSubMenu({super.key, required this.onClosed});

  final Function onClosed;

  @override
  State<ManageCalendarsSubMenu> createState() => _ManageCalendarsSubMenuState();
}

class _ManageCalendarsSubMenuState extends State<ManageCalendarsSubMenu> {

  UiUpdater uiUpdater = UiUpdater();

  List<Calendar> calendarsList = [];

  Future<void> _getCalendars() async {
    calendarsList = await AppCalendar.getCalendars();
  }

  List<Widget> _buildCalendarCard(List<Calendar> calendars, StylesGetters theme) {
    List<Widget> calendarsCards = [];
    for (Calendar calendar in calendars) {
      calendarsCards.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: CalendarCard(calendar: calendar, theme: theme, updateUi: uiUpdater.update),
        )
      );
    }
    return calendarsCards;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return Container(
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: AnimatedBuilder(
        animation: uiUpdater,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Text(
                  S.of(context).calendar_button_manage_calendar_button_tooltip, 
                  style: theme.titleLarge
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).calendar_button_manage_calendars_sub_menu_all_calendars_subtitle,
                            style: theme.bodySmall.
                            copyWith(color: theme.onPrimary),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: _getCalendars(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListView(
                                  children: [
                                    ..._buildCalendarCard(calendarsList, theme),
                                    Container(
                                      width: 200,
                                      height: 40,
                                      margin: const EdgeInsets.only(top: 5),
                                      child: IconButton(
                                        icon: Icon(Icons.add_rounded, color: theme.onPrimary),
                                        onPressed: () {
                                          showSubMenu(
                                            context, 
                                            NewCalendarSubMenu(
                                              theme: theme, 
                                              onSelected: (calendar) async {
                                                await AppCalendar.createCalendar(calendar);
                                                uiUpdater.update();
                                              }
                                            )
                                          );
                                        },
                                        tooltip: S.of(context).calendar_button_manage_calendars_sub_menu_add_calendar,
                                        style: ButtonThemes.secondaryButtonStyle(context),
                                      ),
                                    )
                                  ]
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomTextButton(
                    S.of(context).snacbar_close_button, 
                    () {
                      Navigator.pop(context);
                    }, 
                    false, 
                    false
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

class CalendarCard extends StatefulWidget {
  const CalendarCard({
    super.key, 
    required this.calendar, 
    required this.updateUi,
    required this.theme
  });

  final Calendar calendar;
  final StylesGetters theme;
  final Function updateUi;

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      decoration: BoxDecoration(
        color: widget.theme.surface,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: widget.calendar.color,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              Text(
                widget.calendar.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.theme.bodyMedium
                  .copyWith(color: widget.theme.onPrimary),
              ),
            ],
          ),
          CustomSelectionMenu(
            theme: widget.theme, 
            buttonStyle: ButtonThemes.secondaryButtonStyle(context),
            type: CustomSelectionMenuButttonType.icon,
            items: [
              CustomSelectionMenuItem(
                label: S.of(context).projects_module_notes_modify_category, 
                icon: Icons.brush_rounded, 
                onTap: () async {
                  showSubMenu(
                    context, 
                    NewCalendarSubMenu(
                      theme: widget.theme, 
                      calendar: widget.calendar,
                      onSelected: (calendar) async {
                        await AppCalendar.deleteCalendar(widget.calendar);
                        await AppCalendar.createCalendar(calendar);
                        widget.updateUi();
                      }
                    )
                  );
                }
              ),
              CustomSelectionMenuItem(
                label: S.of(context).snackbar_delete_button,
                foregroundColor: widget.theme.error, 
                icon: Icons.delete_outline_rounded, 
                onTap: () {
                  NotificationHandler.addNotification(
                    NotificationModel(
                      content: S.of(context).snackbar_delete_element_text(widget.calendar.name), 
                      action: () async {
                        await AppCalendar.deleteCalendar(widget.calendar);
                        widget.updateUi();
                      }, 
                      actionLabel: S.of(context).snackbar_delete_button, 
                      duration: NotificationDuration.long
                    )
                  );
                }
              )
            ], 
            child: Icon(
              Icons.more_horiz_rounded,
              color: widget.theme.onPrimary,
            )
          )
        ],
      ),
    );
  }
}