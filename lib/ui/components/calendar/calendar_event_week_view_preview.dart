import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/calendar/calendar_event_detailed_preview.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_panel_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_due_date_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarEventWeekViewPreview extends StatefulWidget {
  const CalendarEventWeekViewPreview({
    super.key, 
    required this.model, 
    required this.theme, 
    required this.width, 
    required this.height,
    required this.zoneHeight,
    required this.top,
    required this.updateUi,
    this.showTime = true,
    this.isWholeDay = false
  });

  final CalendarEventWeekViewPreviewModel model;
  final StylesGetters theme;
  final double width;
  final double height;
  final double zoneHeight;
  final double top;
  final bool showTime;
  final Function updateUi;
  final bool isWholeDay;

  @override
  State<CalendarEventWeekViewPreview> createState() => _CalendarEventWeekViewPreviewState();
}

class _CalendarEventWeekViewPreviewState extends State<CalendarEventWeekViewPreview> {

  String formatDateRange(DateTime firstDate, DateTime secondDate, bool useUsFormat) {
    intl.DateFormat dateFormat = useUsFormat 
        ? intl.DateFormat('MM/dd') 
        : intl.DateFormat('dd/MM');

    intl.DateFormat dateFormatWithYear = useUsFormat 
        ? intl.DateFormat('MM/dd/yyyy') 
        : intl.DateFormat('dd/MM/yyyy');

    intl.DateFormat timeFormat = intl.DateFormat('HH:mm');

    // Normalize dates to compare only year, month, and day
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime yesterday = today.subtract(const Duration(days: 1));

    DateTime normalizedFirst = DateTime(firstDate.year, firstDate.month, firstDate.day);
    DateTime normalizedSecond = DateTime(secondDate.year, secondDate.month, secondDate.day);

    bool isSameDay = normalizedFirst == normalizedSecond;
    bool isToday = normalizedFirst == today && normalizedSecond == today;
    bool isTomorrow = normalizedFirst == tomorrow && normalizedSecond == tomorrow;
    bool isYesterday = normalizedFirst == yesterday && normalizedSecond == yesterday;

    bool isWholeDay = isSameDay && firstDate.hour == 0 && firstDate.minute == 0 
                    && secondDate.hour == 23 && secondDate.minute == 59;

    String formatDate(DateTime date) {
      return date.year == now.year 
          ? dateFormat.format(date) 
          : dateFormatWithYear.format(date);
    }

    if (isToday) {
      return '${S.current.calendar_button_event_date_today}${isWholeDay ? '' : ', '}${isWholeDay ? '' : timeFormat.format(firstDate)}${isWholeDay ? '' : ' - '}${isWholeDay ? '' : timeFormat.format(secondDate)}';
    } else if (isTomorrow) {
      return '${S.current.calendar_button_event_date_tomorrow}${isWholeDay ? '' : ', '}${isWholeDay ? '' : timeFormat.format(firstDate)}${isWholeDay ? '' : ' - '}${isWholeDay ? '' : timeFormat.format(secondDate)}';
    } else if (isYesterday) {
      return '${S.current.calendar_button_event_date_yesterday}${isWholeDay ? '' : ', '}${isWholeDay ? '' : timeFormat.format(firstDate)}${isWholeDay ? '' : ' - '}${isWholeDay ? '' : timeFormat.format(secondDate)}';
    } else if (isSameDay) {
      return '${formatDate(firstDate)}${isWholeDay ? '' : ','} ${isWholeDay ? '' : timeFormat.format(firstDate)}${isWholeDay ? '' : ' - '}${isWholeDay ? '' : timeFormat.format(secondDate)}';
    } else {
      return '${formatDate(firstDate)}, ${timeFormat.format(firstDate)} - ${formatDate(secondDate)}, ${timeFormat.format(secondDate)}';
    }
  }

  double width = 0;

  String getTimeText() {
    if (widget.height == widget.zoneHeight) {
      return S.current.calendar_new_event_whole_day;
    }

    if (widget.top == 0) {
      return '00:00 - ${AppDate.padIfNecessary(widget.model.event.end.hour)}:${AppDate.padIfNecessary(widget.model.event.end.minute)}';
    }
    
    return '${AppDate.padIfNecessary(widget.model.event.start.hour)}:${AppDate.padIfNecessary(widget.model.event.start.minute)} - ${AppDate.padIfNecessary(widget.model.event.end.hour)}:${AppDate.padIfNecessary(widget.model.event.end.minute)}';
  }

  @override
  void initState() {
    width = widget.model.isOverlapping 
      ? widget.width / 2
      : widget.width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CustomSelectionMenu(
            theme: widget.theme,
            enableSearch: true,
            enableRightClick: true,
            buttonStyle: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              elevation: WidgetStatePropertyAll(0),
              overlayColor: WidgetStatePropertyAll(Color.fromARGB(0, 77, 57, 57))
            ),
            items: [
              if (widget.model.overlappingChilds.isNotEmpty) 
              ...[
                CustomSelectionMenuItem(
                  label: widget.model.event.title.replaceAll(' ', '').isEmpty 
                      ? S.of(context).articles_card_untitled
                      : widget.model.event.title,  
                  labelStyle: widget.theme.titleMedium
                    .copyWith(fontWeight: FontWeight.w600),
                  icon: null,
                  items: _getSelectionMenuItems(widget.model, widget.updateUi, widget.theme, context, formatDateRange), 
                  onTap: () {}
                ),
                ...widget.model.overlappingChilds.map((child) {
                  return CustomSelectionMenuItem(
                    label: child.event.title.replaceAll(' ', '').isEmpty 
                      ? S.of(context).articles_card_untitled
                      : child.event.title, 
                    labelStyle: widget.theme.titleMedium
                    .copyWith(fontWeight: FontWeight.w600),
                    icon: null, 
                    items: _getSelectionMenuItems(child, widget.updateUi, widget.theme, context, formatDateRange),
                    onTap: () {}
                  );
                })
              ]
              else 
                ..._getSelectionMenuItems(widget.model, widget.updateUi, widget.theme, context, formatDateRange)
            ],
            child: Container(
              width: width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.model.calendar.color.withValues(alpha: 0.2),
                border: Border(
                  left: BorderSide(color: widget.model.calendar.color, width: 8), 
                  top: BorderSide.none, 
                  right: BorderSide.none, 
                  bottom: BorderSide.none
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        constraints: BoxConstraints(
                          maxHeight: widget.isWholeDay ? widget.height : (widget.height / 4).clamp(20, 500)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width - 30 - (widget.isWholeDay && widget.model.overlappingChilds.isNotEmpty ? 25 : 0),
                                child: Text(
                                  widget.model.event.title.replaceAll(' ', '').isEmpty 
                                  ? S.of(context).articles_card_untitled
                                  : widget.model.event.title,
                                  style: widget.theme.bodyMedium
                                    .copyWith(
                                      fontWeight: FontWeight.w600, 
                                      color: widget.model.calendar.color, 
                                      fontSize: (widget.height / 2).clamp(2, 16)
                                    ),
                                  overflow: TextOverflow.clip
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (widget.model.event.isRecurrence || widget.model.event.recurrence != null)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Icon(
                                        CupertinoIcons.repeat,
                                        size: 12,
                                        color: widget.model.calendar.color
                                      ),
                                    ),
                                  if (widget.isWholeDay && widget.model.overlappingChilds.isNotEmpty)
                                    Container(
                                      width: 25,
                                      height: widget.height,
                                      decoration: BoxDecoration(
                                        color: widget.model.calendar.color.withValues(alpha: 0.10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: Text(
                                              '+${widget.model.overlappingChilds.length}',
                                              style: widget.theme.bodySmall
                                                .copyWith(color: widget.model.calendar.color),
                                              maxLines: 1
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                  else if (widget.model.event.isDueDate && widget.model.event.dueDateInfo != null)
                                    if (widget.model.event.dueDateInfo!.isCompleted)
                                      Icon(
                                        CupertinoIcons.checkmark_alt,
                                        size: 12,
                                        color: widget.model.calendar.color
                                      )
                                    else 
                                      Icon(
                                        CupertinoIcons.xmark,
                                        size: 12,
                                        color: widget.model.calendar.color
                                      )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      if (widget.showTime && widget.height > (30 + (widget.height / 4).clamp(20, 500)) && (widget.model.overlappingChilds.isNotEmpty ? widget.height > 50 : true))
                        SizedBox(
                          width: width,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              getTimeText(),
                              style: widget.theme.bodyMedium.copyWith(color: widget.model.calendar.color),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (widget.model.overlappingChilds.isNotEmpty && widget.height > (20 + (widget.height / 4).clamp(20, 500)))
                    Container(
                      width: width,
                      height: (widget.height / 5).clamp(20, 100),
                      decoration: BoxDecoration(
                        color: widget.model.calendar.color.withValues(alpha: 0.10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              '+${widget.model.overlappingChilds.length}',
                              style: widget.theme.bodySmall
                                .copyWith(color: widget.model.calendar.color),
                              maxLines: 1
                            ),
                          ),
                        ],
                      )
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String formatSingleDate(DateTime date, bool useUsFormat) {
  intl.DateFormat dateFormat = useUsFormat 
      ? intl.DateFormat('MM/dd') 
      : intl.DateFormat('dd/MM');

  intl.DateFormat dateFormatWithYear = useUsFormat 
      ? intl.DateFormat('MM/dd/yyyy') 
      : intl.DateFormat('dd/MM/yyyy');

  intl.DateFormat timeFormat = intl.DateFormat('HH:mm');

  DateTime now = DateTime.now();
  bool isToday = date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;

  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime tomorrow = today.add(const Duration(days: 1));
  DateTime yesterday = today.subtract(const Duration(days: 1));

  bool isTomorrow = date.year == tomorrow.year &&
                    date.month == tomorrow.month &&
                    date.day == tomorrow.day;

  bool isYesterday = date.year == yesterday.year &&
                    date.month == yesterday.month &&
                    date.day == yesterday.day;

  String formatDate(DateTime date) {
    return date.year == now.year 
        ? dateFormat.format(date) 
        : dateFormatWithYear.format(date);
  }

  if (isToday) {
    return '${S.current.calendar_button_event_date_today}, ${timeFormat.format(date)}';
  } else if (isTomorrow) {
    return '${S.current.calendar_button_event_date_tomorrow}, ${timeFormat.format(date)}';
  } else if (isYesterday) {
    return '${S.current.calendar_button_event_date_yesterday}, ${timeFormat.format(date)}';
  } else {
    return '${formatDate(date)}, ${timeFormat.format(date)}';
  }
}

List<CustomSelectionMenuItem> _getSelectionMenuItems(CalendarEventWeekViewPreviewModel model, Function updateUi, StylesGetters theme, BuildContext context, String Function(DateTime, DateTime, bool) formatDateRange) {
  return [
    CustomSelectionMenuItem(
      label: "Details", 
      icon: Icons.notes_rounded, 
      onTap: () async {
        bool useUsDateFormat = await AppConfig.getConfigValue("prefer_us_date_format") ?? false;
        if (context.mounted) {
          showSubMenu(
            context, 
            CalendarEventDetailedPreview(
              theme: theme, 
              eventCalendar: model.calendar, 
              event: model.event, 
              useUsDateFormat: useUsDateFormat, 
              formatDate: (model.event.isDueDate || model.event.dueDateInfo != null) 
                ? (date1, date2, useUsDateFormat) {
                  return formatSingleDate(date1, useUsDateFormat);
                } 
                : formatDateRange
            )
          );
        }
      }
    ),
    // Modify
    CustomSelectionMenuItem(
      label: S.of(context).projects_module_notes_modify_category, 
      icon: Icons.brush_rounded, 
      items: model.event.recurrence != null ? [
        CustomSelectionMenuItem(
          label: S.of(context).calendar_button_event_selection_menu_only_this_event, 
          icon: null, 
          onTap: () async {
            if (model.event.isDueDate || model.event.dueDateInfo != null) {
              showSubMenu(context, NewCalendarDueDateSubMenu(
                event: model.event, 
                showCalendarOption: false,
                showRecurrenceOption: false,
                onSelected: (e) async {
                  e.recurrence = CalendarEventRecurence(
                    type: (model.event.originalEvent ?? model.event).recurrence!.type, 
                    interval: (model.event.originalEvent ?? model.event).recurrence!.interval, 
                    happensOn: (model.event.originalEvent ?? model.event).recurrence!.happensOn, 
                    modifiedDates: List.empty(growable: true),
                    endDate: (model.event.originalEvent ?? model.event).recurrence!.endDate
                  );
                  DateTime? start = (model.event.originalEvent ?? model.event).recurrence?.modifiedDates.where((e) => e.replacementEvent.start == model.event.start).firstOrNull?.calculatedDate;
                  (model.event.originalEvent ?? model.event).recurrence!.modifiedDates.add(
                    CalendarEventRecurrenceReplacement(
                      calculatedDate: start ?? model.event.start, 
                      replacementEvent: e
                    )
                  );
                  await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
                  await AppCalendar.addEvent(model.event.originalEvent ?? model.event);
                  await updateUi();
                }, 
                theme: theme
              ));
            } else {
              showSubMenu(context, NewCalendarEventSubMenu(
                event: model.event, 
                showCalendarOption: false,
                showRecurrenceOption: false,
                onSelected: (e) async {
                  e.recurrence = CalendarEventRecurence(
                    type: (model.event.originalEvent ?? model.event).recurrence!.type, 
                    interval: (model.event.originalEvent ?? model.event).recurrence!.interval, 
                    happensOn: (model.event.originalEvent ?? model.event).recurrence!.happensOn, 
                    modifiedDates: List.empty(growable: true),
                    endDate: (model.event.originalEvent ?? model.event).recurrence!.endDate
                  );
                  DateTime? start = (model.event.originalEvent ?? model.event).recurrence?.modifiedDates.where((e) => e.replacementEvent.start == model.event.start).firstOrNull?.calculatedDate;
                  (model.event.originalEvent ?? model.event).recurrence!.modifiedDates.add(
                    CalendarEventRecurrenceReplacement(
                      calculatedDate: start ?? model.event.start, 
                      replacementEvent: e
                    )
                  );
                  await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
                  await AppCalendar.addEvent(model.event.originalEvent ?? model.event);
                  await updateUi();
                }, 
                theme: theme
              ));
            }
          }
        ),
        CustomSelectionMenuItem(
          label: S.of(context).calendar_button_event_selection_menu_all_occurence, 
          icon: null, 
          onTap: () async {
            CalendarEvent event = (model.event.originalEvent ?? model.event).copy();
            if (model.event.isDueDate || model.event.dueDateInfo != null) {
              showSubMenu(context, NewCalendarDueDateSubMenu(
                event: event, 
                onSelected: (e) async {
                  await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
                  e.recurrence!.modifiedDates.map((a) => a.replacementEvent.calendarId = e.calendarId).toList();
                  await AppCalendar.addEvent(e);
                  await updateUi();  
                }, 
                theme: theme
              ));
            } else {
              showSubMenu(context, NewCalendarEventSubMenu(
                event: event, 
                onSelected: (e) async {
                  await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
                  e.recurrence!.modifiedDates.map((a) => a.replacementEvent.calendarId = e.calendarId).toList();
                  await AppCalendar.addEvent(e);
                  await updateUi();  
                }, 
                theme: theme
              ));
            }
            
          }
        )
      ] 
      : [],
      onTap: () async {
        CalendarEvent event = (model.event.originalEvent ?? model.event).copy();
        if (model.event.isDueDate || model.event.dueDateInfo != null) {
          showSubMenu(context, NewCalendarDueDateSubMenu(
            event: event, 
            onSelected: (e) async {
              await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
              await AppCalendar.addEvent(e);
              await updateUi();  
            }, 
            theme: theme
          ));
        } else {
          showSubMenu(context, NewCalendarEventSubMenu(
            event: event, 
            onSelected: (e) async {
              await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
              await AppCalendar.addEvent(e);
              await updateUi();  
            }, 
            theme: theme
          ));
        }
      }
    ),
    // Delete
    CustomSelectionMenuItem(
      label: S.of(context).snackbar_delete_button, 
      foregroundColor: theme.error,
      items: model.event.isRecurrence ? [
        CustomSelectionMenuItem(
          label: S.of(context).calendar_button_event_selection_menu_only_this_event, 
          foregroundColor: theme.error,
          icon: null, 
          onTap: () async {
            model.event.originalEvent ??= model.event; // If event has recurrence but no original event, it means it's the original event itself.
            DateTime? start = model.event.originalEvent!.recurrence?.modifiedDates.where((e) => e.replacementEvent.start == model.event.start).firstOrNull?.calculatedDate;
            model.event.originalEvent!.recurrence!.exludedDates.add(start ?? model.event.start);
            await AppCalendar.deleteEvent(model.event.originalEvent!);
            await AppCalendar.addEvent(model.event.originalEvent!);
            await updateUi();
          }
        ),
        CustomSelectionMenuItem(
          label: S.of(context).calendar_button_event_selection_menu_all_occurence, 
          foregroundColor: theme.error,
          icon: null, 
          onTap: () async {
            await AppCalendar.deleteEvent(model.event.originalEvent ?? model.event);
            await updateUi();
          }
        )
      ] 
      : [],
      icon: Icons.delete_outline_rounded, 
      onTap: () async {
        await AppCalendar.deleteEvent(model.event);
        await updateUi();
      }
    )
  ];
}