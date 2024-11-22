import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/custom_components/custom_date_input.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/theme/theme.dart';

class NewCalendarEventSubMenu extends StatefulWidget {
  const NewCalendarEventSubMenu({
    super.key,
    required this.onSelected,
    required this.theme, 
    this.event,
    this.showCalendarOption = true,
    this.showRecurrenceOption = true,
    this.datePickerMode
  });

  final StylesGetters theme;
  final CalendarEvent? event;
  final Function(CalendarEvent) onSelected;
  final bool showCalendarOption;
  final bool showRecurrenceOption;
  final CustomDatePickerMode? datePickerMode;

  @override
  State<NewCalendarEventSubMenu> createState() => _NewCalendarEventSubMenuState();
}

class _NewCalendarEventSubMenuState extends State<NewCalendarEventSubMenu> {

  bool isWholeDay = false;

  CalendarEvent event = CalendarEvent(
    title: '', 
    description: '', 
    start: DateTime.now().copyWith(minute: 00), 
    end: DateTime.now().add(const Duration(hours: 1)).copyWith(minute: 00), 
    calendarId: 0, 
    eventId: createUniqueId(),
    recurrence: null, 
    isDueDate: false,
    dueDateInfo: null
  );

  Calendar _getSelectedCalendar(List<Calendar> calendars) {
    if (event.calendarId == 0) {
      event.calendarId = calendars.first.id;
    } 
    return calendars.where((calendar) => event.calendarId == calendar.id).first;
  }

  CalendarEventRecurence? _getRecurence(CalendarEventRecurenceType? type) {
    switch (type) {
      case null:
        return null;
      case CalendarEventRecurenceType.daily:
        return CalendarEventRecurence(
          type: type, 
          interval: 1, 
          happensOn: [], 
          endDate: null
        );
      case CalendarEventRecurenceType.weekly:
        return CalendarEventRecurence(
          type: type, 
          interval: 1, 
          happensOn: [event.start.weekday], 
          endDate: null
        );
      case CalendarEventRecurenceType.monthly:
        return CalendarEventRecurence(
          type: type, 
          interval: 1, 
          happensOn: [event.start.day], 
          endDate: null
        );
      case CalendarEventRecurenceType.yearly:
        return CalendarEventRecurence(
          type: type, 
          interval: 1, 
          happensOn: [event.start.month], 
          endDate: null
        );
    }
  }

  @override
  void initState() {
    if (widget.event != null) {
      event = widget.event!;
    }

    if (widget.event != null) {
      isWholeDay = widget.event!.start.year == widget.event!.end.year 
        && widget.event!.start.month == widget.event!.end.month 
        && widget.event!.start.day == widget.event!.end.day 
        && widget.event!.start.hour == 00
        && widget.event!.start.minute == 00
        && widget.event!.end.hour == 23 
        && widget.event!.end.minute == 59;
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        color: widget.theme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: widget.theme.onPrimary.withOpacity(widget.theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Text(
              widget.event != null 
                ? S.of(context).calendar_modify_event_title 
                : S.of(context).calendar_new_event_title, 
              style: widget.theme.titleLarge
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).submenu_artilces_image_description_title, 
                            style: widget.theme.bodySmall.
                            copyWith(color: widget.theme.onPrimary),
                          ),
                        ),
                      ),
                      // Title
                      Container(
                        width: 350,
                        height: 45,
                        decoration: BoxDecoration(
                          color: widget.theme.surface,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        child: TextField (
                          controller: TextEditingController(text: event.title),
                          onChanged: (value) => event.title = value,
                          style: widget.theme.bodyMedium.
                          copyWith(color: widget.theme.onSurface),
                          cursorColor: widget.theme.onSurface,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: S.of(context).articles_card_untitled,
                            hintStyle: widget.theme.bodyMedium.copyWith(color: Colors.grey),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Notes
                      Container(
                        width: 350,
                        height: 100,
                        decoration: BoxDecoration(
                          color: widget.theme.surface,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: TextField(
                          controller: TextEditingController(text: event.description),
                          onChanged: (value) => event.description = value,
                          style: widget.theme.bodyMedium.
                          copyWith(color: widget.theme.onSurface),
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          cursorColor: widget.theme.onSurface,
                          decoration: InputDecoration(
                            hintText: '${S.of(context).projects_module_notes_title}...',
                            hintStyle: widget.theme.bodyMedium.copyWith(color: Colors.grey),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).projects_module_spreadsheet_data_type_date, 
                            style: widget.theme.bodySmall.
                            copyWith(color: widget.theme.onPrimary),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: SwitchTile(
                          isWholeDay, 
                          S.of(context).calendar_new_event_whole_day, 
                          (value) {
                            isWholeDay = value;
                            if (value == true) {
                              event.start = DateTime(event.start.year, event.start.month, event.start.day, 00, 00);
                              event.end = DateTime(event.start.year, event.start.month, event.start.day, 23, 59);
                            } else {
                              DateTime now = DateTime.now();
                              event.start = DateTime(event.start.year, event.start.month, event.start.day, now.hour, 00);
                              event.end = DateTime(event.start.year, event.start.month, event.start.day, now.hour + 1, 00);
                            }
                            setState(() {
                              isWholeDay = value;  
                            });
                          }, 
                          false
                        ),
                      ),
                      // Date
                      Container(
                        width: 350,
                        height: widget.datePickerMode == CustomDatePickerMode.single 
                          ? 45 
                          : isWholeDay 
                            ? 45 
                            : 80,
                        margin: const EdgeInsets.only(top: 5),
                        child: CustomDateInput(
                          key: UniqueKey(),
                          theme: widget.theme, 
                          title: S.of(context).node_widgets_start_text,
                          endTitle: S.of(context).node_widgets_end_text,
                          date: event.start,
                          endDate: isWholeDay 
                            ? null
                            : event.end,
                          mode: widget.datePickerMode ?? (isWholeDay 
                            ? CustomDatePickerMode.single
                            : CustomDatePickerMode.range),
                          useTime: !isWholeDay,
                          onSelected: (dates) {
                            event.start = dates.first;
                            event.end = dates.length > 1 
                              ? dates.last
                              : dates.first.add(const Duration(hours: 1));
                            if (isWholeDay) {
                              event.start = event.start.copyWith(hour: 00, minute: 00);
                              event.end = event.end.copyWith(hour: 23, minute: 59);
                            }
                          }
                        )
                      ),
                      if (widget.showRecurrenceOption)
                        ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).calendar_new_event_recurrence_subtitle, 
                              style: widget.theme.bodySmall.
                              copyWith(color: widget.theme.onPrimary),
                            ),
                          ),
                        ),
                        // Recurrence
                        Container(
                          width: 350,
                          height: 50,
                          margin: const EdgeInsets.only(top: 10),
                          child: CustomDropdownButton(
                            width: 350, 
                            menuMaxHeight: 250,
                            menuTitle: S.of(context).calendar_new_event_recurrence_subtitle, 
                            enableSearch: true,
                            selectedOptionTitle: calendarEventRecurenceTypeTranslation[event.recurrence?.type] ?? S.current.projects_module_spreadsheet_number_operation_none,
                            items: [
                              CustomSelectionMenuItem(
                                label: S.current.calendar_new_event_recurrence_type_never, 
                                foregroundColor: event.recurrence?.type == null 
                                  ? widget.theme.secondary
                                  : null,
                                icon: null, 
                                onTap: () {
                                  setState(() {
                                    event.recurrence = null;
                                  });
                                }
                              ),
                              ...CalendarEventRecurenceType.values.map((type) {
                                return CustomSelectionMenuItem(
                                  label: calendarEventRecurenceTypeTranslation[type] ?? '', 
                                  foregroundColor: event.recurrence?.type == type 
                                    ? widget.theme.secondary
                                    : null,
                                  icon: null, 
                                  onTap: () {
                                    setState(() {
                                      event.recurrence = _getRecurence(type);
                                    });
                                  }
                                );
                              })
                            ], 
                            theme: widget.theme
                          )
                        )],
                      if (widget.showCalendarOption)
                        ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).calendar_button_calendar_title, 
                              style: widget.theme.bodySmall.
                              copyWith(color: widget.theme.onPrimary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: FutureBuilder(
                            future: AppCalendar.getCalendars(), 
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Calendar selectedCalendar = _getSelectedCalendar(snapshot.data!);
                                return CustomDropdownButton(
                                  width: 350, 
                                  menuTitle: S.of(context).calendar_button_calendar_title, 
                                  selectedOptionTitle: selectedCalendar.name, 
                                  items: [
                                    CustomSelectionMenuItem(
                                      label: S.of(context).calendar_new_event_recurrence_select_calendar, 
                                      labelStyle: widget.theme.titleMedium,
                                      enabled: false,
                                      icon: null, 
                                      onTap: () {}
                                    ),
                                    ...snapshot.data!.map((calendar) => CustomSelectionMenuItem(
                                      label: calendar.name, 
                                      foregroundColor: calendar.id == selectedCalendar.id 
                                        ? widget.theme.secondary
                                        : widget.theme.onPrimary,
                                      icon: null, 
                                      onTap: () {
                                        setState(() {
                                          event.calendarId = calendar.id;
                                        });
                                      }
                                    ))
                                  ], 
                                  theme: widget.theme
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }
                          ),
                        )]
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 5, left: 5, top: 0),
            child: SizedBox(
              width: 350,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextButton(
                  widget.event != null 
                    ? S.of(context).projects_module_notes_modify_category
                    : S.of(context).submenu_new_project_button, 
                  () async {
                    await widget.onSelected(event);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  false, 
                  false
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

Map<CalendarEventRecurenceType, String> calendarEventRecurenceTypeTranslation = {
  CalendarEventRecurenceType.daily: S.current.calendar_new_event_recurrence_type_everyday,
  CalendarEventRecurenceType.weekly: S.current.calendar_new_event_recurrence_type_everyweek,
  CalendarEventRecurenceType.monthly: S.current.calendar_new_event_recurrence_type_everymonth,
  CalendarEventRecurenceType.yearly: S.current.calendar_new_event_recurrence_type_everyyear
};