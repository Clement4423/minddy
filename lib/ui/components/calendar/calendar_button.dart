import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/calendar/calendar_event_due_date_preview.dart';
import 'package:minddy/ui/components/calendar/calendar_event_preview.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/manage_calendars_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_due_date_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';


// TODO : Faire la vue Week

class _CalendarsEventsList {
  DateTime date;
  List<CalendarEvent> events;

  _CalendarsEventsList({required this.date, required this.events});
}

class CalendarButtonEventsUpdater extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class CalendarButton extends StatefulWidget {
  const CalendarButton({
    super.key,
    required this.useUsDateFormat
  });

  final bool useUsDateFormat;

  @override
  State<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {

  bool isHovering = false;
  bool isOpened = false;
  bool showPrivateEvents = false;

  CalendarButtonEventsUpdater eventsUpdater = CalendarButtonEventsUpdater();
  CalendarButtonEventsUpdater dueDatesUpdater = CalendarButtonEventsUpdater();

  double borderRadius = 13.0;

  List<Calendar> calendars = [];

  Future<void> _updateShowPrivateEvents(bool value) async {
    showPrivateEvents = value;
    await _getCalendars();
    eventsUpdater.notify();
    dueDatesUpdater.notify();
  }

  double _getTodayTextWidth(String dateString, TextStyle style) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: dateString,
          style: style
        ),
        textDirection: TextDirection.ltr
      )..layout();

    return textPainter.width;
  }

  String _getDateText(DateTime date, bool useUsFormat) {

    String dateFormat = useUsFormat ? 'EEEE MMMM d, yyyy' : 'EEEE d MMMM yyyy';

    String formattedDate = intl.DateFormat(dateFormat).format(date);

    formattedDate = formattedDate.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');

    return formattedDate;
  }

  void _toggleDateMenu() {
    setState(() {
      isOpened = !isOpened;
      isHovering = false;
      borderRadius = isOpened ? 25 : 13;
    });
  }

  Future<List<Calendar>> _getCalendars() async {
    List<Calendar> cldrs = await AppCalendar.getCalendars();
    calendars = cldrs;
    return cldrs;
  }

  List<_CalendarsEventsList> _groupEvents(List<CalendarEvent> events) {

    DateTime extractDate(CalendarEvent event) {
      return DateTime(event.start.year, event.start.month, event.start.day);
    }

    Map<DateTime, List<CalendarEvent>> dates = {};

    for (CalendarEvent event in events) {
      DateTime eventDay = extractDate(event);
      if (dates[eventDay] == null) {
        dates[eventDay] = [];
      }
      dates[eventDay]?.add(event);
    }

    List<_CalendarsEventsList> list = [];

    for (MapEntry<DateTime, List<CalendarEvent>> entry in dates.entries) {
      list.add(_CalendarsEventsList(date: entry.key, events: entry.value));
    }

    list.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return list;
  }


  Future<List<_CalendarsEventsList>> _getNextEventsWithin5Days() async {

    List<CalendarEvent> events = [];

    DateTime now = DateTime.now();

    DateTime nowRounded = now.copyWith(hour: now.hour, minute: 0);

    DateTime in5Days = nowRounded.add(const Duration(days: 5));

    for (Calendar calendar in calendars) {
      events.addAll(calendar.getEventsAndRecurrencesWithin(nowRounded, in5Days));
    }

    events.removeWhere((e) => e.end.isBefore(nowRounded) || e.start.isAfter(in5Days) || e.isDueDate);

    if (events.length >= 2) {
      events.sort((a, b) {
        return a.start.compareTo(b.start);
      });
    }

    for (CalendarEvent event in events) {
      if (event.recurrence != null) {
        event.isRecurrence = true;
      }
    }
    
    List<_CalendarsEventsList> eventsLists = _groupEvents(events);

    return eventsLists;
  }

  Future<List<_CalendarsEventsList>> _getDueDates() async {

    List<CalendarEvent> events = [];

    DateTime now = DateTime.now();

    DateTime lastMonth = now.copyWith(month: now.month - 1, hour: now.hour, minute: 0);

    DateTime in1month = now.add(const Duration(days: 30));

    for (Calendar calendar in calendars) {
      events.addAll(calendar.getEventsAndRecurrencesWithin(lastMonth, in1month));
    }
    
    List<CalendarEvent> eventsLists = events.where((event) => event.isDueDate && event.dueDateInfo != null && event.dueDateInfo!.isCompleted == false).toList();

    return _groupEvents(eventsLists);
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return FutureBuilder(
      future: _getCalendars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 8),
            child: MouseRegion(
              onEnter: (details) {
                if (!isOpened) {
                  setState(() {
                    if (!isOpened) {
                      isHovering = true;
                    }
                  });
                }
              },
              onExit: (event) {
                if (!isOpened) {
                  setState(() {
                    if (!isOpened) {
                      isHovering = false;
                    }
                  });
                }
              },
              cursor: isOpened 
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click,
              child: GestureDetector(
                onTap: isOpened 
                  ? null 
                  : _toggleDateMenu,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: theme.onPrimary.withOpacity(0.2),
                      width: 0.5
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubicEmphasized,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: theme.primaryContainer,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        width: isOpened
                          ? 650
                          : isHovering 
                            ? _getTodayTextWidth(_getDateText(DateTime.now(), widget.useUsDateFormat), theme.titleMedium.copyWith(fontWeight: FontWeight.w600)) + 37 + 15
                            : 37,
                        height: isOpened ? 550 : 37,
                        child: SingleChildScrollView(
                          // Top when opened || Preview while hovering
                          child: Column(
                            children: [
                              Container(
                                height: isOpened 
                                  ? 45 
                                  : 37,
                                margin: isOpened 
                                  ? const EdgeInsets.symmetric(vertical: 5, horizontal: 5) 
                                  : EdgeInsets.zero,
                                padding: isOpened 
                                  ? const EdgeInsets.symmetric(vertical: 0, horizontal: 4) 
                                  : EdgeInsets.zero,
                                decoration: isOpened 
                                  ? BoxDecoration(
                                    color: theme.surface,
                                    borderRadius: BorderRadius.circular(borderRadius - 5)
                                  )
                                  : null,
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    height: isOpened 
                                      ? 45 
                                      : 37,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 37,
                                            height: 37,
                                            child: SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: SvgPicture.asset(
                                                "assets/logo/calendar/Calendar${DateTime.now().day}.svg", 
                                                // ignore: deprecated_member_use
                                                color: theme.onPrimary
                                              )
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                              child: TweenAnimationBuilder(
                                                duration: const Duration(milliseconds: 300),
                                                tween: Tween<double>(
                                                  begin: isHovering ? 0.0 : 1.0,
                                                  end: isHovering ? 1.0 : isOpened ? 1.0 : 0.0
                                                ),
                                                builder: (context, opacity, child) {
                                                  return Opacity(
                                                    opacity: opacity,
                                                    child: Text(
                                                      _getDateText(DateTime.now(), widget.useUsDateFormat),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: theme.titleMedium.copyWith(
                                                        color: theme.onPrimary,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  );
                                                }
                                              ),
                                            ),
                                          ),
                                          if (isOpened) 
                                            ...[
                                              // Manage calendars
                                              Tooltip(
                                                message: S.of(context).calendar_button_manage_calendar_button_tooltip,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: SizedBox(
                                                    width: 32,
                                                    height: 32,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        showSubMenu(
                                                          context, 
                                                          onMenuDismissed: () async {
                                                            await _getCalendars();
                                                            eventsUpdater.notify();
                                                            dueDatesUpdater.notify();
                                                          },
                                                          ManageCalendarsSubMenu(onClosed: () async {
                                                            await _getCalendars();
                                                            eventsUpdater.notify();
                                                            dueDatesUpdater.notify();
                                                          })
                                                        );
                                                      }, 
                                                      style: ButtonThemes.secondaryButtonStyle(context),
                                                      icon: Icon(
                                                        Icons.calendar_month_rounded,
                                                        color: theme.onSurface,
                                                        size: 17,
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Add event / Due date
                                              Tooltip(
                                                message: S.of(context).calendar_button_add_event_button_tooltip,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: CustomSelectionMenu(
                                                      theme: theme, 
                                                      buttonStyle: ButtonStyle(
                                                        backgroundColor: WidgetStatePropertyAll(theme.secondary),
                                                        elevation: const WidgetStatePropertyAll(0),
                                                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius - 10)))
                                                      ),
                                                      items: [
                                                        CustomSelectionMenuItem(
                                                          label: S.of(context).calendar_button_new_event_button_title, 
                                                          icon: Icons.event_rounded, 
                                                          onTap: () async {
                                                            await showSubMenu(context, NewCalendarEventSubMenu(
                                                              onSelected: (event) async {
                                                                await AppCalendar.addEvent(event);
                                                                await _getCalendars();
                                                                eventsUpdater.notify();
                                                              }, 
                                                              theme: theme
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
                                                                await _getCalendars();
                                                                dueDatesUpdater.notify();
                                                              }, 
                                                              theme: theme
                                                            ));
                                                          }
                                                        )
                                                      ], 
                                                      child: Icon(
                                                        Icons.add_rounded, 
                                                        color: theme.onSecondary,
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (isOpened)
                                SizedBox(
                                  width: 650,
                                  height: 490,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Next events
                                          AnimatedBuilder(
                                            animation: eventsUpdater,
                                            builder: (context, child) {
                                              return Container(
                                                width: 317.5,
                                                height: 490,
                                                margin: const EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                  color: theme.surface,
                                                  borderRadius: BorderRadius.circular(borderRadius - 5)
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 317.5,
                                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                      child: Text(
                                                        S.of(context).calendar_button_next_events_title,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: theme.titleMedium
                                                          .copyWith(
                                                            color: theme.onSurface,
                                                            fontSize: 20
                                                          )
                                                      )
                                                    ),
                                                    FutureBuilder(
                                                      key: UniqueKey(),
                                                      future: _getNextEventsWithin5Days(), 
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                          return Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(15),
                                                              child: SizedBox(
                                                                height: 435,
                                                                child: ListView(
                                                                  children: [
                                                                    ...snapshot.data!.map((events) => Padding(
                                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 5, bottom: 3),
                                                                            child: Text(
                                                                              _getDateText(events.date, widget.useUsDateFormat),
                                                                              style: theme.bodySmall
                                                                                .copyWith(
                                                                                  color: theme.onSurface.withOpacity(0.5),
                                                                                  fontSize: 13
                                                                                ),
                                                                            ),
                                                                          ),
                                                                          ...events.events.map((event) => 
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(bottom: 5),
                                                                              child: CalendarEventPreview(
                                                                                key: UniqueKey(),
                                                                                event: event, 
                                                                                calendar: calendars.firstWhere((c) => c.id == event.calendarId), 
                                                                                calendars: calendars, 
                                                                                showPrivateEvents: showPrivateEvents, 
                                                                                updateShowPrivateEvents: _updateShowPrivateEvents, 
                                                                                updateUi: () async {
                                                                                  await _getCalendars();
                                                                                  eventsUpdater.notify();
                                                                                }, 
                                                                                formatDate: _getDateText, 
                                                                                useUsDateFormat: widget.useUsDateFormat, 
                                                                                theme: theme
                                                                              ),
                                                                            )
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return IntrinsicHeight(
                                                            child: Container(
                                                              width: 300,
                                                              margin: const EdgeInsets.only(top: 20),
                                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                                                              decoration: BoxDecoration(
                                                                color: theme.primary,
                                                                borderRadius: BorderRadius.circular(13)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  S.of(context).calendar_button_free_for_next_days,
                                                                  maxLines: 2,
                                                                  style: theme.bodyMedium
                                                                    .copyWith(color: theme.onSurface)
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          ),
                                          // Due dates, open week view and close menu
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                // Due dates
                                                AnimatedBuilder(
                                                  animation: dueDatesUpdater,
                                                  builder: (context, child) {
                                                    return Container(
                                                      width: 317.5,
                                                      height: 400,
                                                      decoration: BoxDecoration(
                                                        color: theme.surface,
                                                        borderRadius: BorderRadius.circular(borderRadius - 5)
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 317.5,
                                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                            child: Text(
                                                              S.of(context).calendar_button_next_due_dates_title,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: theme.titleMedium
                                                                .copyWith(
                                                                  color: theme.onSurface,
                                                                  fontSize: 20
                                                                )
                                                            )
                                                          ),
                                                          FutureBuilder(
                                                            future: _getDueDates(), 
                                                            builder: (context, snapshot) {
                                                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                                DateTime now = DateTime.now();
                                                                return Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    child: SizedBox(
                                                                      height: 345,
                                                                      width: 307.5,
                                                                      child: ListView(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 15),
                                                                            child: Column(
                                                                              children: [
                                                                                ...snapshot.data!.where((events) => events.date.isBefore(now)).map((events) {
                                                                                    return Column(
                                                                                      children: events.events.map((event) => 
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 5),
                                                                                            child: CalendarEventDueDatePreview(
                                                                                              key: UniqueKey(),
                                                                                              event: event, 
                                                                                              calendar: calendars.firstWhere((c) => c.id == event.calendarId), 
                                                                                              calendars: calendars, 
                                                                                              showPrivateEvents: showPrivateEvents, 
                                                                                              updateShowPrivateEvents: _updateShowPrivateEvents, 
                                                                                              updateUi: () async {
                                                                                                await _getCalendars();
                                                                                                dueDatesUpdater.notify();
                                                                                              },  
                                                                                              formatDate: _getDateText, 
                                                                                              useUsDateFormat: widget.useUsDateFormat, 
                                                                                              theme: theme
                                                                                            ),
                                                                                          )
                                                                                        ).toList(),
                                                                                    );
                                                                                  })
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          ...snapshot.data!.where((events) => events.date.isAfter(now)).map((events) {
                                                                            return Column(
                                                                              children: events.events.map((event) => 
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(bottom: 5),
                                                                                    child: CalendarEventDueDatePreview(
                                                                                      key: UniqueKey(),
                                                                                      event: event, 
                                                                                      calendar: calendars.firstWhere((c) => c.id == event.calendarId), 
                                                                                      calendars: calendars, 
                                                                                      showPrivateEvents: showPrivateEvents, 
                                                                                      updateShowPrivateEvents: _updateShowPrivateEvents, 
                                                                                      updateUi: () async {
                                                                                        await _getCalendars();
                                                                                        dueDatesUpdater.notify();
                                                                                      }, 
                                                                                      formatDate: _getDateText, 
                                                                                      useUsDateFormat: widget.useUsDateFormat, 
                                                                                      theme: theme
                                                                                    ),
                                                                                  )
                                                                                ).toList(),
                                                                            );
                                                                          })
                                                                        ]
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return const SizedBox();
                                                              }
                                                            }
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: SizedBox(
                                                    width: 317.5, height: 85,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // Week view
                                                          MouseRegion(
                                                            cursor: SystemMouseCursors.click,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                // TODO : Show week view
                                                              },
                                                              child: Tooltip(
                                                                message: S.of(context).calendar_button_open_week_view_button_tooltip,
                                                                waitDuration: const Duration(seconds: 1),
                                                                child: Container(
                                                                  width: 156,
                                                                  height: 85,
                                                                  margin: const EdgeInsets.only(right: 5),
                                                                  decoration: BoxDecoration(
                                                                    color: theme.surface,
                                                                    borderRadius: BorderRadius.circular(borderRadius - 5)
                                                                  ),
                                                                  child: Center(
                                                                    child: Transform.scale(
                                                                      scaleX: -1,
                                                                      child: Icon(
                                                                        CupertinoIcons.arrow_up_left_arrow_down_right, 
                                                                        color: theme.onSurface,
                                                                        size: 40,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // Close button
                                                          MouseRegion(
                                                            cursor: SystemMouseCursors.click,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                _toggleDateMenu();
                                                              },
                                                              child: Tooltip(
                                                                message: S.of(context).snacbar_close_button,
                                                                waitDuration: const Duration(seconds: 1),
                                                                child: Container(
                                                                  width: 156,
                                                                  height: 85,
                                                                  decoration: BoxDecoration(
                                                                    color: theme.surface,
                                                                    borderRadius: BorderRadius.circular(borderRadius - 5)
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons.close_rounded, 
                                                                      color: theme.onSurface,
                                                                      size: 40,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ]
                                      )
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }      
      }
    );
  }
}