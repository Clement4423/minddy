import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/calendar/calendar_event_detailed_preview.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarEventPreview extends StatefulWidget {
  const CalendarEventPreview({
    super.key,
    required this.event, 
    required this.calendar,
    required this.calendars,
    required this.showPrivateEvents,
    required this.updateShowPrivateEvents,
    required this.updateUi,
    required this.formatDate,
    required this.useUsDateFormat,
    required this.theme,
    this.onClick
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
  final Function? onClick;

  @override
  State<CalendarEventPreview> createState() => _CalendarEventPreviewState();
}

class _CalendarEventPreviewState extends State<CalendarEventPreview> {

  late bool isPrivate = false;

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
        if (widget.onClick != null) {
          widget.onClick!();
          return;
        }
        if (!isPrivate) {
          showSubMenu(context, CalendarEventDetailedPreview(
            event: widget.event,
            eventCalendar: widget.calendar,
            useUsDateFormat: widget.useUsDateFormat,
            formatDate: formatDateRange,
            theme: widget.theme,
          ));
        }
      },
      child: Container(
        width: 310,
        height: 110,
        decoration: BoxDecoration(
          color: isPrivate 
            ? widget.theme.primary.withValues(alpha: 0.6)
            : widget.theme.primary,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPrivate)
                ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          CupertinoIcons.eye_slash,
                          color: widget.theme.onPrimary,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: SizedBox(
                          width: 225,
                          child: Text(
                            S.current.calendar_button_event_preview_private_event,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: widget.theme.bodyMedium
                              .copyWith(color: widget.theme.onPrimary),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox.shrink(),
                      SizedBox(
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
                      )
                    ],
                  )
                ]
              else 
              // Title and options
              ...[
                SizedBox(
                  width: 290,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.event.title.replaceAll(' ', '').isEmpty 
                            ? S.of(context).articles_card_untitled 
                            : widget.event.title,
                          style: widget.theme.titleMedium
                            .copyWith(
                              color: widget.theme.onPrimary,
                              fontSize: widget.theme.titleMedium.fontSize! + 3
                            ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        )
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
                                    showSubMenu(context, NewCalendarEventSubMenu(
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
                                    showSubMenu(context, NewCalendarEventSubMenu(
                                      event: event, 
                                      onSelected: (e) async {
                                        await AppCalendar.deleteEvent(widget.event.originalEvent ?? widget.event);
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
                                showSubMenu(context, NewCalendarEventSubMenu(
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
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 290,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTooltip(
                        message: widget.calendar.name,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: widget.calendar.color,
                            border: Border.all(
                              width: 0.5,
                              color: widget.theme.onPrimary.withValues(alpha: 0.5)
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      // Date
                      Row(
                        children: [
                          Text(
                            formatDateRange(widget.event.start, widget.event.end, widget.useUsDateFormat),
                            style: widget.theme.bodyMedium
                              .copyWith(color: widget.theme.onPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.event.recurrence != null) 
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 3),
                              child: Tooltip(
                                message: widget.event.recurrence!.generateRecurenceText().typeAndInterval,
                                child: Icon(
                                  CupertinoIcons.repeat, 
                                  size: 18,
                                  color: widget.theme.onPrimary
                                )
                              ),
                            )
                        ],
                      ),
                    ],
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