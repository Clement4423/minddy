import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/calendar/calendar_event_week_view_preview.dart';
import 'package:minddy/ui/components/calendar/calendar_week_view_day_container.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_panel_controller.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/utils/ui_updater.dart';

class RealTimeTicker {
  Timer? _timer;

  void start(Function(DateTime currentTime) onTick) {
    DateTime now = DateTime.now();
    int secondsUntilNextMinute = 60 - now.second;

    Duration initialDelay = Duration(seconds: secondsUntilNextMinute);

    Timer(initialDelay, () {
      onTick(DateTime.now());

      _timer = Timer.periodic(const Duration(minutes: 1), (_) {
        onTick(DateTime.now());
      });
    });
  }

  void stop() {
    _timer?.cancel();
  }
}

class CalendarWeekViewPanel extends StatefulWidget {
  const CalendarWeekViewPanel({
    super.key,
    required this.theme,
    required this.controller
  });

  final StylesGetters theme;
  final CalendarWeekViewPanelController controller;

  @override
  State<CalendarWeekViewPanel> createState() => _CalendarWeekViewPanelState();
}

class _CalendarWeekViewPanelState extends State<CalendarWeekViewPanel> {

  List<String> timeList = ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00','06:00', '07:00', '08:00', '09:00', '10:00', '11:00','12:00', '13:00', '14:00', '15:00', '16:00', '17:00','18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '00:00'];

  List<DateTime> days = [];

  UiUpdater timeUpdater = UiUpdater();

  RealTimeTicker ticker = RealTimeTicker();

  void startTimeUpdaterLoop() {
    ticker.start((time) {
      timeUpdater.update();
    });
  }

  int maxEventsHorizontaly = 2;
  double timeTextMaxWidth = 0;
  double eventPreviewZoneWidth = 0;
  double eventPreviewZoneHeight = 0;

  double spaceBetweenDaysAndEvents = 0;

  double getTimeTextMaxWidth() {
    List<num> widths = [];
    for (String time in timeList) {
      TextPainter painter = TextPainter(
        text: TextSpan(text: time, style: widget.theme.bodyMedium),
        textDirection: TextDirection.ltr
      );

      painter.layout();

      widths.add(painter.width);
    }
    return maximum(widths).toDouble();
  }

  bool datesContainsToday(List<DateTime> days) {
    DateTime now = DateTime.now();
    return days.where((date) => date.day == now.day && date.month == now.month && date.year == now.year).isNotEmpty;
  }


  double calculateEventTop({required DateTime eventStart, required DateTime eventEnd, required DateTime date, required double totalHeight}) {
    DateTime today = date;
    DateTime todayStart = DateTime(today.year, today.month, today.day);
    DateTime todayEnd = todayStart.add(const Duration(minutes: dayMinutes));

    int minutesSinceStartOfDay = 0;

    // If "today" is between eventStart and eventEnd, position starts at 0
    if (eventStart.isBefore(todayStart) && eventEnd.isAfter(todayEnd) || eventStart.isBefore(todayStart) && eventEnd.isBefore(todayEnd)) {
      minutesSinceStartOfDay = 0;
    } else {
      // Calculate minutes since the start of the day for events on the same day
      minutesSinceStartOfDay = (eventStart.hour * 60) + eventStart.minute;
    }

    return (minutesSinceStartOfDay / dayMinutes) * totalHeight;
  }

  static const int dayMinutes = 24 * 60;

  double calculateEventHeight({required DateTime eventStart, required DateTime eventEnd, required DateTime date, required double totalHeight}) {

      int eventDurationMinutes = 0;

      DateTime today = date;
      DateTime todayStart = DateTime(today.year, today.month, today.day);
      DateTime todayEnd = todayStart.add(const Duration(minutes: dayMinutes));

      DateTime realStart = eventStart;

      if (eventStart.isBefore(todayStart)) {
        realStart = todayStart;
      }

      if (eventStart.isBefore(todayStart) && eventEnd.isAfter(todayEnd)) {
        eventDurationMinutes = dayMinutes;
      } else {
        eventDurationMinutes = eventEnd.difference(realStart).inMinutes.clamp(0, dayMinutes);
      }

      double height = (eventDurationMinutes / dayMinutes) * totalHeight;

      double eventTop = calculateEventTop(eventStart: eventStart, eventEnd: eventEnd, date: date, totalHeight: totalHeight);

      if (height + eventTop > totalHeight) {
        height -= eventTop;
      }

      // Ensure minimum height for very short events
      if (height <= 1) {
        height = (60 / dayMinutes) * totalHeight;
      }

      return height;
  }

  @override
  void dispose() {
    ticker.stop();
    super.dispose();
  }

  @override
  void initState() {
    timeTextMaxWidth = getTimeTextMaxWidth();
    eventPreviewZoneHeight = widget.controller.height - (widget.controller.height / 10);
    eventPreviewZoneWidth = (((widget.controller.width - (timeTextMaxWidth + 30))) / 7) - 5;
    spaceBetweenDaysAndEvents = (widget.controller.height / 10) - (widget.controller.height / 21);
    if ((eventPreviewZoneHeight / 24) < 30) {
      timeList = ['00:00', '02:00', '04:00', '06:00', '08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00', '00:00'];
    }
    days = widget.controller.getWeekDays(year: widget.controller.year, weekNumber: widget.controller.week);
    Future.delayed((const Duration(seconds: 1)), () {
      startTimeUpdaterLoop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return FutureBuilder(
          future: widget.controller.getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DateTime> days = widget.controller.getWeekDays(weekNumber: widget.controller.week, year: widget.controller.year);
              return SizedBox(
                width: widget.controller.width,
                height: widget.controller.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Space and days
                    Row(
                      children: [
                        // Space on top
                        SizedBox(
                          width: timeTextMaxWidth + 30,
                          height: widget.controller.height / 21,
                        ),
                        // Days 
                        SizedBox(
                          width: ((widget.controller.width - (timeTextMaxWidth + 30))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(7, (index) {
                                return CalendarWeekViewDayContainer(
                                  width: eventPreviewZoneWidth, 
                                  height: widget.controller.height / 21, 
                                  date: days[index], 
                                  theme: widget.theme
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                    // Space with whole day events
                    SizedBox(
                      width: widget.controller.width,
                      height: spaceBetweenDaysAndEvents,
                      child: Row(
                        children: [
                          // Space taken by time
                          SizedBox(
                            width: timeTextMaxWidth + 30,
                            height: spaceBetweenDaysAndEvents,
                          ),
                          // Whole days events
                          SizedBox(
                            width: (eventPreviewZoneWidth * 7) + 35,
                            height: spaceBetweenDaysAndEvents,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(7, (index) {
                                  return SizedBox(
                                    width: eventPreviewZoneWidth,
                                    height: spaceBetweenDaysAndEvents - spaceBetweenDaysAndEvents / 5,
                                    child: snapshot.data![index].wholeDayEvents.firstOrNull != null 
                                      ? Stack(
                                        children: [
                                          CalendarEventWeekViewPreview(
                                            model: snapshot.data![index].wholeDayEvents.first, 
                                            showTime: false,
                                            theme: widget.theme, 
                                            updateUi: widget.controller.updateUi,
                                            width: eventPreviewZoneWidth, 
                                            height: spaceBetweenDaysAndEvents - spaceBetweenDaysAndEvents / 5, 
                                            zoneHeight: eventPreviewZoneHeight,
                                            highlightedEventID: widget.controller.highlightedEventID,
                                            resetHighligthedEvent: widget.controller.resetHighligthedEvent,
                                            top: 0,
                                            isWholeDay: true
                                          )
                                        ],
                                      )
                                      : null
                                  );
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Time and events
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Time
                            Container(
                              width: timeTextMaxWidth + 20, // Padding
                              height: eventPreviewZoneHeight,
                              decoration: BoxDecoration(
                                color: widget.theme.primaryContainer,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  ...List.generate(timeList.length, (index) {
                                    num hour = num.parse(timeList[index].split(':').first);
                                    DateTime dateTime = DateTime(2025, 1, 1, hour.toInt(), 0);
                                    return Positioned(
                                      top: calculateEventTop(eventStart: dateTime, eventEnd: dateTime.add(const Duration(hours: 1)), date: dateTime, totalHeight: eventPreviewZoneHeight),
                                      child: Text(
                                        timeList[index],
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                            // Events
                            SizedBox(
                              width: (eventPreviewZoneWidth * 7) + 35,
                              height: eventPreviewZoneHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(snapshot.data!.length, (index) {
                                    return SizedBox(
                                      width: eventPreviewZoneWidth,
                                      height: eventPreviewZoneHeight,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          ...snapshot.data![index].events.reversed.map((event) {
                                            return CalendarEventWeekViewPreview(
                                              key: UniqueKey(),
                                              width: eventPreviewZoneWidth,
                                              height: calculateEventHeight(date: days[index], eventStart: event.event.start, eventEnd: event.event.end, totalHeight: eventPreviewZoneHeight),
                                              zoneHeight: eventPreviewZoneHeight,
                                              top: calculateEventTop(eventStart: event.event.start, eventEnd: event.event.end, date: days[index], totalHeight: eventPreviewZoneHeight),
                                              theme: widget.theme,
                                              updateUi: widget.controller.updateUi,
                                              model: event,
                                              highlightedEventID: widget.controller.highlightedEventID,
                                              resetHighligthedEvent: widget.controller.resetHighligthedEvent,
                                            );
                                          })
                                        ],
                                      )
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Time indicator
                        if (datesContainsToday(days))
                          AnimatedBuilder(
                            animation: timeUpdater,
                            builder: (context, child) {
                              return Positioned(
                                top: calculateEventTop(eventStart: DateTime.now(), eventEnd: DateTime.now(), date: DateTime.now(), totalHeight: eventPreviewZoneHeight) - 10, // Remove half the bar height to align on real hour
                                width: widget.controller.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // First blue bar
                                    Container(
                                      width: 10,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: widget.theme.secondary
                                      ),
                                    ),
                                    // Time box with hour indicated
                                    Container(
                                      width: timeTextMaxWidth,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: widget.theme.secondary,
                                        borderRadius: BorderRadius.circular(9)
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${AppDate.padIfNecessary(DateTime.now().hour)}:${AppDate.padIfNecessary(DateTime.now().minute)}',
                                          style: widget.theme.titleMedium
                                            .copyWith(
                                              fontSize: 14,
                                              color: widget.theme.onSecondary
                                            ),
                                        ),
                                      ),
                                    ),
                                    // Second blue bar
                                    Container(
                                      width: 10,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: widget.theme.secondary
                                      ),
                                    ),
                                    // Long bar
                                    SizedBox(
                                      width: eventPreviewZoneWidth * 7 + 35 + 10,
                                      height: 30,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: eventPreviewZoneWidth * 7 + 35 + 10,
                                            height: 2,
                                            decoration: BoxDecoration(
                                              color: widget.theme.secondary.withValues(alpha: 0.2)
                                            ),
                                          ),
                                          Positioned(
                                            left: 15 + (days.indexWhere((day) => datesContainsToday([day]))) * (eventPreviewZoneWidth + 5),
                                            width: eventPreviewZoneWidth - 5,
                                            child: Stack(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                // Thick bar
                                                Container(
                                                  width: eventPreviewZoneWidth - 5,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    color: widget.theme.secondary,
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                ),
                                                // Circle
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    color: widget.theme.secondary,
                                                    border: Border.all(
                                                      color: widget.theme.primaryContainer, 
                                                      width: 0.5
                                                    ),
                                                    borderRadius: BorderRadius.circular(6)
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }
        );
      }
    );
  }
}