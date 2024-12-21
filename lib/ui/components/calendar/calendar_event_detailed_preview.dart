import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalendarEventDetailedPreview extends StatefulWidget {
  const CalendarEventDetailedPreview({
    super.key, 
    required this.theme, 
    required this.eventCalendar, 
    required this.event,
    required this.useUsDateFormat,
    required this.formatDate
  });

  final StylesGetters theme;
  final Calendar eventCalendar;
  final CalendarEvent event;
  final bool useUsDateFormat;
  final String Function(DateTime, DateTime, bool) formatDate;

  @override
  State<CalendarEventDetailedPreview> createState() => _CalendarEventDetailedPreviewState();
}

class _CalendarEventDetailedPreviewState extends State<CalendarEventDetailedPreview> {

  bool showNotes = false;
  bool showRecurrence = false;
  bool showNotCompleted = false;
  bool showCompleted = false;

  double height = 210.0;

  void _calculateHeight() {
    if (showNotes) {
      height += 110.0;
    }

    if (showRecurrence) {
      height += 50.0;
    }

    if (showNotCompleted) {
      height += 50.0;
    }
    
    if (showCompleted) {
      height += 50.0;
    }
  }

  @override
  void initState() {
    if (widget.event.description.replaceAll(' ', '').isNotEmpty) {
      showNotes = true;
    }
    if (widget.event.isRecurrence || widget.event.recurrence != null) {
      showRecurrence = true;
    }

    if (widget.event.isDueDate && widget.event.dueDateInfo != null && widget.event.dueDateInfo!.isCompleted == false) {
      showNotCompleted = true;
    }

    if (widget.event.isDueDate && widget.event.dueDateInfo != null && widget.event.dueDateInfo!.isCompleted == true) {
      showCompleted = true;
    }

    _calculateHeight();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: height,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: widget.theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  width: 283,
                  height: 60,
                  child: Text(
                    widget.event.title.replaceAll(' ', '').isEmpty 
                      ? S.of(context).articles_card_untitled
                      : widget.event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: widget.theme.titleLarge
                      .copyWith(color: widget.theme.onPrimary),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }, 
                tooltip: S.of(context).snacbar_close_button,
                style: ButtonThemes.secondaryButtonStyle(context),
                icon: Icon(Icons.close_rounded, color: widget.theme.onPrimary)
              )
            ],
          ),
          SizedBox(
            width: 330,
            height: 50,
            child: Text(
              widget.formatDate(widget.event.start, widget.event.end, widget.useUsDateFormat),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: widget.theme.titleMedium
                .copyWith(color: widget.theme.onPrimary, fontWeight: FontWeight.w600),
            ),
          ),
          if (showNotCompleted)
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      CupertinoIcons.clear_thick,
                      color: widget.theme.onSurface,
                      size: 24,
                    ),
                  ),
                  Text(
                    S.of(context).calendar_event_detailed_preview_not_completed_yet,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onPrimary),
                  ),
                ],
              ),
            ),
          if (showCompleted)
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      CupertinoIcons.checkmark_alt,
                      color: widget.theme.onSurface,
                      size: 24,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).calendar_event_detailed_preview_completed_by(widget.event.dueDateInfo?.completedBy ?? S.of(context).welcome_pass_default_username),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodyMedium
                          .copyWith(color: widget.theme.onPrimary),
                      ),
                      Text(
                        widget.formatDate(widget.event.dueDateInfo!.completedOn!, widget.event.start, widget.useUsDateFormat),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodySmall
                          .copyWith(
                            color: widget.theme.onPrimary.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w400
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (showNotes)
            Container(
              width: 330,
              height: 110,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(15)
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.description,
                      maxLines: null,
                      style: widget.theme.bodyMedium
                        .copyWith(color: widget.theme.onPrimary),
                    )
                  ],
                ),
              ),
            ),
          if (showRecurrence) 
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      CupertinoIcons.repeat,
                      color: widget.theme.onSurface,
                      size: 24,
                    ),
                  ),
                  Text(
                    calendarEventRecurenceTypeTranslation[widget.event.recurrence?.type ?? CalendarEventRecurenceType.daily]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onPrimary),
                  ),
                ],
              ),
            ),
          Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: widget.eventCalendar.color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Text(
                    widget.eventCalendar.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onPrimary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}