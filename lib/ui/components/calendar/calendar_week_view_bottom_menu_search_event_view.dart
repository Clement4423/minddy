import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/components/calendar/calendar_event_due_date_preview.dart';
import 'package:minddy/ui/components/calendar/calendar_event_preview.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/utils/ui_updater.dart';
import 'package:intl/intl.dart' as intl;

final PageStorageBucket _calendarWeekViewBottomMenuSearchEventViewPageBucket = PageStorageBucket();

class CalendarWeekViewBottomMenuSearchEventView extends StatefulWidget {
  const CalendarWeekViewBottomMenuSearchEventView({
    super.key,
    required this.events,
    required this.calendars,
    required this.useUsDateFormat,
    required this.updateUi,
    required this.setWeek
  });

  final List<CalendarEvent> events;
  final List<Calendar> calendars;
  final bool useUsDateFormat;
  final Function updateUi;
  final Function(CalendarEvent event) setWeek;

  @override
  State<CalendarWeekViewBottomMenuSearchEventView> createState() => _CalendarWeekViewBottomMenuSearchEventViewState();
}

class _CalendarWeekViewBottomMenuSearchEventViewState extends State<CalendarWeekViewBottomMenuSearchEventView> {

  List<CalendarEvent> searched = [];

  List<CalendarEvent> _search(String query) {
    String transformedQuery = SearchTextFormatter.format(query);
    
    List<CalendarEvent> list = widget.events.where((event) {
      return SearchTextFormatter.format(event.title.replaceAll(' ', '').isEmpty ? S.of(context).articles_card_untitled : event.title).contains(transformedQuery) ||
        SearchTextFormatter.format(event.description).contains(transformedQuery);
    }).toList();

    return _sortEventsByDates(list);
  }

  UiUpdater uiUpdater = UiUpdater();

  @override
  void initState() {
    searched = _sortEventsByDates(widget.events);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SizedBox(
      width: 340,
      height: 340,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: PageStorage(
            bucket: _calendarWeekViewBottomMenuSearchEventViewPageBucket,
            child: ListView(
              key: const PageStorageKey('calendar_week_view_bottom_menu_search_event_view_page_storage_key'),
              children: [
                Container(
                  width: 190,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: theme.onPrimary, width: 1)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (text) {
                            searched = _search(text);
                            uiUpdater.update();
                          },
                          style: theme.bodyMedium
                            .copyWith(color: theme.onPrimary),
                          cursorColor: theme.onPrimary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 10, bottom: 4),
                            hintText: '${S.of(context).articles_search}...',
                            hintStyle: theme.bodyMedium
                            .copyWith(color: theme.onPrimary.withValues(alpha: 0.5)),
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.search_rounded, color: theme.onPrimary),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AnimatedBuilder(
                    animation: uiUpdater,
                    builder: (context, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          ...searched.map((event) {
                            if (event.isDueDate && event.dueDateInfo != null) {
                              return CalendarEventDueDatePreview(
                                onClick: () {
                                  widget.setWeek(event);
                                },
                                key: UniqueKey(),
                                event: event, 
                                calendar: widget.calendars.where((calendar) => calendar.id == event.calendarId).first,
                                calendars: widget.calendars, 
                                showPrivateEvents: true, 
                                updateShowPrivateEvents: (value) {}, 
                                updateUi: widget.updateUi,
                                formatDate: _formatSingleDate, 
                                useUsDateFormat: widget.useUsDateFormat, 
                                theme: theme
                              );
                            } else {
                              return CalendarEventPreview(
                                onClick: () {
                                  widget.setWeek(event);
                                },
                                key: UniqueKey(),
                                event: event, 
                                calendar: widget.calendars.where((calendar) => calendar.id == event.calendarId).first, 
                                calendars: widget.calendars, 
                                showPrivateEvents: true, 
                                updateShowPrivateEvents: (value) {}, 
                                updateUi: widget.updateUi, 
                                formatDate: _getDateText, 
                                useUsDateFormat: widget.useUsDateFormat, 
                                theme: theme
                              );
                            }
                          })
                        ],
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatSingleDate(DateTime date, bool useUsFormat) {
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

String _getDateText(DateTime date, bool useUsFormat) {

  String dateFormat = useUsFormat ? 'EEEE MMMM dd, yyyy' : 'EEEE dd MMMM yyyy';

  String formattedDate = intl.DateFormat(dateFormat).format(date);

  formattedDate = formattedDate.split(' ').map((word) {
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');

  return formattedDate;
}

List<CalendarEvent> _sortEventsByDates(List<CalendarEvent> events) {
  List<CalendarEvent> sortedEvents = List.from(events);
  if (sortedEvents.length >= 2) {
    sortedEvents.sort((a, b) {
      return a.start.compareTo(b.start);
    });
  }

  for (CalendarEvent event in sortedEvents) {
    if (event.recurrence != null) {
      event.isRecurrence = true;
    }
  }

  return sortedEvents;
}
