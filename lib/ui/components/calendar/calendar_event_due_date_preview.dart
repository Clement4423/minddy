import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/calendar/calendar_event_detailed_preview.dart';
import 'package:minddy/ui/components/custom_components/custom_checkbox.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_due_date_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarEventDueDatePreview extends StatefulWidget {
  const CalendarEventDueDatePreview({
    super.key,
    required this.event, 
    required this.calendar,
    required this.calendars,
    required this.showPrivateEvents,
    required this.updateShowPrivateEvents,
    required this.updateUi,
    required this.formatDate,
    required this.useUsDateFormat,
    required this.theme
  });

  final CalendarEvent event;
  final Calendar calendar;
  final List<Calendar> calendars;
  final bool showPrivateEvents;
  final Function(bool) updateShowPrivateEvents;
  final Function updateUi;
  final Function(DateTime, bool) formatDate;
  final bool useUsDateFormat;
  final StylesGetters theme;

  @override
  State<CalendarEventDueDatePreview> createState() => _CalendarEventDueDatePreviewState();
}

class _CalendarEventDueDatePreviewState extends State<CalendarEventDueDatePreview> {

  late bool isPrivate = false;

  Future<void> _checkDueDate(bool value) async {
    String username = await _getUsername();
    if (widget.event.isRecurrence && widget.event.recurrence != null || widget.event.recurrence != null) {
      widget.event.dueDateInfo = DueDateInfo(
        isCompleted: true, 
        completedOn: DateTime.now(), 
        completedBy: username
      );
      widget.event.recurrence = CalendarEventRecurence(
        type: (widget.event.originalEvent ?? widget.event).recurrence!.type, 
        interval: (widget.event.originalEvent ?? widget.event).recurrence!.interval, 
        happensOn: (widget.event.originalEvent ?? widget.event).recurrence!.happensOn, 
        modifiedDates: List.empty(growable: true),
        endDate: (widget.event.originalEvent ?? widget.event).recurrence!.endDate
      );
      DateTime? start = (widget.event.originalEvent ?? widget.event).recurrence!.modifiedDates.where((e) => e.replacementEvent.start == widget.event.start).firstOrNull?.calculatedDate;
      (widget.event.originalEvent ?? widget.event).recurrence!.modifiedDates.add(
        CalendarEventRecurrenceReplacement(
          calculatedDate: start ?? widget.event.start, 
          replacementEvent: widget.event
        )
      );
      await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
      await AppCalendar.addEvent(widget.event.originalEvent ?? widget.event);
      await widget.updateUi();
      NotificationHandler.addNotification(
        NotificationModel(
          content: S.current.calendar_button_due_date_has_been_complete(widget.event.title, username), 
          action: () async {
            widget.event.dueDateInfo = DueDateInfo(
              isCompleted: false, 
              completedOn: null, 
              completedBy: null
            );
            (widget.event.originalEvent ?? widget.event).recurrence?.modifiedDates.removeWhere(
              (e) => e.calculatedDate.isAtSameMomentAs(start ?? widget.event.start)
            );
            await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
            await AppCalendar.addEvent(widget.event.originalEvent ?? widget.event);
            await widget.updateUi();
          }, 
          actionLabel: S.current.calendar_button_due_date_cancel_complete, 
          duration: NotificationDuration.long
        )
      );
    } else {
      widget.event.dueDateInfo = DueDateInfo(
        isCompleted: true, 
        completedOn: DateTime.now(), 
        completedBy: username
      );
      await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
      await AppCalendar.addEvent(widget.event.originalEvent ?? widget.event);
      await widget.updateUi();
      NotificationHandler.addNotification(
        NotificationModel(
          content: S.current.calendar_button_due_date_has_been_complete(widget.event.title, username), 
          action: () async {
            widget.event.dueDateInfo = DueDateInfo(
              isCompleted: false, 
              completedOn: null, 
              completedBy: null
            );
            await AppCalendar.deleteEvent(widget.event);
            await AppCalendar.addEvent(widget.event);
            await widget.updateUi();
          }, 
          actionLabel: S.current.calendar_button_due_date_cancel_complete, 
          duration: NotificationDuration.long
        )
      );
    }
  }

  Future<String> _getUsername() async {
    return await AppConfig.getConfigValue('username') ?? S.current.welcome_pass_default_username;
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

  bool _isDatePassed() {
    DateTime now = DateTime.now();

    return widget.event.start.isBefore(now);
  }

  @override
  void initState() {
    if (widget.showPrivateEvents) {
      isPrivate = false;
    } else {
      isPrivate = widget.calendars.where((c) => c.id == widget.event.calendarId).first.isPrivate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isPrivate) {
          showSubMenu(context, CalendarEventDetailedPreview(
            event: widget.event,
            eventCalendar: widget.calendar,
            useUsDateFormat: widget.useUsDateFormat,
            formatDate: (DateTime date, DateTime dateTwo, bool useUsDateFormat) {
              return formatSingleDate(date, useUsDateFormat);
            },
            theme: widget.theme,
          ));
        }
      },
      child: Container(
        width: 310,
        height: 70,
        decoration: BoxDecoration(
          color: isPrivate 
            ? widget.theme.primary.withValues(alpha: 0.6)
            : widget.theme.primary,
          borderRadius: BorderRadius.circular(15),
          border: _isDatePassed() 
            ? Border.all(
              color: widget.theme.error,
              width: 1
            )
            : null
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPrivate)
                ...[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            CupertinoIcons.eye_slash,
                            color: widget.theme.onPrimary,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: SizedBox(
                            width: 80,
                            height: 30,
                            child: CustomTextButton(
                              S.of(context).calendar_button_event_preview_see_button, 
                              () async {
                                bool isUnlocked = await showUnlockContentSubMenu(context);
                                await widget.updateShowPrivateEvents(isUnlocked);
                              }, 
                              isSecondary: true,
                              false, 
                              false
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]
              else 
              // Title and options
              ...[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: widget.theme.shadow.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 5)
                      )
                    ]
                  ),
                  child: CustomCheckbox(
                    key: UniqueKey(),
                    scale: 1.5,
                    value: widget.event.dueDateInfo?.isCompleted ?? false, 
                    onChanged: (value) async {
                      await _checkDueDate(value);
                    }, 
                    side: widget.theme.brightness == Brightness.dark 
                      ? BorderSide(color: widget.theme.onPrimary, width: 0.5)
                      : BorderSide.none,
                    theme: widget.theme
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: SizedBox(
                    width: 215,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.title.replaceAll(' ', '').isEmpty 
                            ? S.of(context).articles_card_untitled
                            : widget.event.title,
                          style: widget.theme.titleMedium
                            .copyWith(color: widget.theme.onPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 215,
                          height: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTooltip(
                                message: widget.calendar.name,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  margin: const EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                    color: widget.calendar.color,
                                    borderRadius: BorderRadius.circular(7.5)
                                  ),
                                ),
                              ),
                              if (widget.event.isRecurrence || widget.event.recurrence != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 1, right: 6),
                                  child: Tooltip(
                                    message: calendarEventRecurenceTypeTranslation[widget.event.recurrence?.type] ?? 'Recurrent event',
                                    child: Icon(
                                      CupertinoIcons.repeat, 
                                      size: 16,
                                      color: widget.theme.onPrimary
                                    )
                                  )
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Text(
                                    formatSingleDate(widget.event.start, widget.useUsDateFormat),
                                    style: widget.theme.bodyMedium
                                      .copyWith(color: widget.theme.onPrimary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CustomSelectionMenu(
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(widget.theme.primary),
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      elevation: const WidgetStatePropertyAll(0)
                    ),
                    theme: widget.theme, 
                    items: [
                      // Modify
                      CustomSelectionMenuItem(
                        label: S.of(context).projects_module_notes_modify_category, 
                        icon: Icons.brush_rounded, 
                        items: widget.event.recurrence != null ? [
                          CustomSelectionMenuItem(
                            label: S.of(context).calendar_button_event_selection_menu_only_this_event, 
                            icon: null, 
                            onTap: () async {
                              showSubMenu(context, NewCalendarDueDateSubMenu(
                                event: widget.event, 
                                showCalendarOption: false,
                                showRecurrenceOption: false,
                                onSelected: (e) async {
                                  e.recurrence = CalendarEventRecurence(
                                    type: (widget.event.originalEvent ?? widget.event).recurrence!.type, 
                                    interval: (widget.event.originalEvent ?? widget.event).recurrence!.interval, 
                                    happensOn: (widget.event.originalEvent ?? widget.event).recurrence!.happensOn, 
                                    modifiedDates: List.empty(growable: true),
                                    endDate: (widget.event.originalEvent ?? widget.event).recurrence!.endDate
                                  );
                                  DateTime? start = (widget.event.originalEvent ?? widget.event).recurrence?.modifiedDates.where((e) => e.replacementEvent.start == widget.event.start).firstOrNull?.calculatedDate;
                                  (widget.event.originalEvent ?? widget.event).recurrence!.modifiedDates.add(
                                    CalendarEventRecurrenceReplacement(
                                      calculatedDate: start ?? widget.event.start, 
                                      replacementEvent: e
                                    )
                                  );
                                  await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
                                  await AppCalendar.addEvent(widget.event.originalEvent ?? widget.event);
                                  await widget.updateUi();  
                                }, 
                                theme: widget.theme
                              ));
                            }
                          ),
                          CustomSelectionMenuItem(
                            label: S.of(context).calendar_button_event_selection_menu_all_occurence, 
                            icon: null, 
                            onTap: () async {
                              CalendarEvent event = (widget.event.originalEvent ?? widget.event).copy();
                              showSubMenu(context, NewCalendarDueDateSubMenu(
                                event: event, 
                                onSelected: (e) async {
                                  await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
                                  e.recurrence!.modifiedDates.map((a) => a.replacementEvent.calendarId = e.calendarId).toList();
                                  await AppCalendar.addEvent(e);
                                  await widget.updateUi();  
                                }, 
                                theme: widget.theme
                              ));
                            }
                          )
                        ] 
                        : [],
                        onTap: () async {
                          CalendarEvent event = (widget.event.originalEvent ?? widget.event).copy();
                          showSubMenu(context, NewCalendarDueDateSubMenu(
                            event: event, 
                            onSelected: (e) async {
                              await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
                              await AppCalendar.addEvent(e);
                              await widget.updateUi();  
                            }, 
                            theme: widget.theme
                          ));
                        }
                      ),
                      // Delete
                      CustomSelectionMenuItem(
                        label: S.of(context).snackbar_delete_button, 
                        foregroundColor: widget.theme.error,
                        items: widget.event.isRecurrence ? [
                          CustomSelectionMenuItem(
                            label: S.of(context).calendar_button_event_selection_menu_only_this_event, 
                            foregroundColor: widget.theme.error,
                            icon: null, 
                            onTap: () async {
                              widget.event.originalEvent ??= widget.event; // If event has recurrence but no original event, it means it's the original event itself.
                              DateTime? start = widget.event.originalEvent!.recurrence?.modifiedDates.where((e) => e.replacementEvent.start == widget.event.start).firstOrNull?.calculatedDate;
                              widget.event.originalEvent!.recurrence!.exludedDates.add(start ?? widget.event.start);
                              await AppCalendar.deleteEvent(widget.event.originalEvent!);
                              await AppCalendar.addEvent(widget.event.originalEvent!);
                              await widget.updateUi();
                            }
                          ),
                          CustomSelectionMenuItem(
                            label: S.of(context).calendar_button_event_selection_menu_all_occurence, 
                            foregroundColor: widget.theme.error,
                            icon: null, 
                            onTap: () async {
                              await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
                              await widget.updateUi();
                            }
                          )
                        ] 
                        : [],
                        icon: Icons.delete_outline_rounded, 
                        onTap: () async {
                          await AppCalendar.deleteEvent(widget.event);
                          await widget.updateUi();
                        }
                      )
                    ], 
                    child: Icon(
                      Icons.more_horiz_rounded, 
                      color: widget.theme.onPrimary
                    )
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}