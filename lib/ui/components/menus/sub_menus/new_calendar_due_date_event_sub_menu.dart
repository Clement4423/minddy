import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/calendar/custom_happens_on_picker.dart';
import 'package:minddy/ui/components/calendar/custom_rec_interval_picker.dart';
import 'package:minddy/ui/components/custom_components/custom_checkbox.dart';
import 'package:minddy/ui/components/custom_components/custom_date_input.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_calendar_event_sub_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class NewCalendarDueDateSubMenu extends StatefulWidget {
  const NewCalendarDueDateSubMenu({
    super.key,
    required this.onSelected,
    required this.theme, 
    this.event,
    this.showCalendarOption = true,
    this.showRecurrenceOption = true
  });

  final StylesGetters theme;
  final CalendarEvent? event;
  final Function(CalendarEvent) onSelected;
  final bool showCalendarOption;
  final bool showRecurrenceOption;

  @override
  State<NewCalendarDueDateSubMenu> createState() => _NewCalendarDueDateSubMenuState();
}

class _NewCalendarDueDateSubMenuState extends State<NewCalendarDueDateSubMenu> {

  bool isWholeDay = false;

  CalendarEvent event = CalendarEvent(
    title: '', 
    description: '', 
    start: DateTime.now().copyWith(minute: 00), 
    end: DateTime.now().add(const Duration(hours: 1)).copyWith(minute: 00), 
    calendarId: 0, 
    eventId: createUniqueId(),
    recurrence: null, 
    isDueDate: true,
    dueDateInfo: DueDateInfo(
      isCompleted: false, 
      completedOn: null, 
      completedBy: null
    )
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
          color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: Text(
                widget.event != null 
                  ? S.of(context).calendar_modify_due_date_title 
                  : S.of(context).calendar_new_due_date_title, 
                style: widget.theme.titleLarge,
                textAlign: TextAlign.center,
              ),
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
                      if (widget.event != null)
                        ...[
                          // Completed
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).calendar_new_due_date_event_completion_state_subtitle,
                              style: widget.theme.bodySmall.
                              copyWith(color: widget.theme.onPrimary),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 45,
                            margin: const EdgeInsets.only(top: 5, bottom: 20),
                            decoration: BoxDecoration(
                              color: widget.theme.surface,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: CustomCheckbox(
                                    value: widget.event!.dueDateInfo?.isCompleted ?? false, 
                                    onChanged: (value) async {
                                      if (value == true) {
                                        event.dueDateInfo = DueDateInfo(
                                          isCompleted: true, 
                                          completedOn: DateTime.now(), 
                                          completedBy: await AppConfig.getConfigValue('username') ?? S.current.welcome_pass_default_username
                                        );
                                      } else {
                                        event.dueDateInfo = DueDateInfo(
                                          isCompleted: false, 
                                          completedOn: null, 
                                          completedBy: null
                                        );
                                      }
                                    }, 
                                    theme: widget.theme
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Text(
                                    S.of(context).calendar_new_due_date_event_completion_state,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: widget.theme.bodyMedium
                                      .copyWith(color: widget.theme.onSurface),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.of(context).submenu_artilces_image_description_title, 
                          style: widget.theme.bodySmall.
                          copyWith(color: widget.theme.onPrimary),
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
                        margin: const EdgeInsets.only(top: 5),
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
                      // Date
                      Container(
                        width: 350,
                        height: 45,
                        margin: const EdgeInsets.only(top: 5),
                        child: CustomDateInput(
                          key: UniqueKey(),
                          theme: widget.theme, 
                          title: S.of(context).projects_module_spreadsheet_data_type_date,
                          date: event.start,
                          mode: CustomDatePickerMode.single,
                          useTime: true,
                          onSelected: (dates) {
                            event.start = dates.first;
                            event.end = dates.first.add(const Duration(hours: 1));
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
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomDropdownButton(
                            width: 350, 
                            menuMaxHeight: 250,
                            menuTitle: S.of(context).calendar_new_event_recurence_type_subtitle, 
                            enableSearch: true,
                            selectedOptionTitle: calendarEventRecurenceTypeTranslation[event.recurrence?.type] ?? S.current.calendar_new_event_recurrence_type_never,
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
                        )
                      ],
                      if (event.recurrence != null && widget.showRecurrenceOption)
                        ...[
                          // Interval selector
                          Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: widget.theme.surface,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).calendar_new_event_recurence_every_subtitle,
                                  style: widget.theme.bodyMedium,
                                ),
                                CustomRecIntervalPicker(
                                  key: UniqueKey(),
                                  theme: widget.theme,
                                  onSelected: (interval) {
                                    setState(() {
                                      event.recurrence!.interval = interval;  
                                    });
                                  },
                                  value: event.recurrence!.interval,
                                  recurenceType: event.recurrence!.type,
                                )
                              ],
                            ),
                          ),
                          // Happens on selector
                          if (event.recurrence!.type != CalendarEventRecurenceType.daily)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomHappensOnPicker(
                                key: UniqueKey(),
                                theme: widget.theme,
                                recurenceType: event.recurrence!.type,
                                onSelected: (list) {
                                  event.recurrence!.happensOn = list;
                                },
                                happensOn: event.recurrence!.happensOn,
                              ),
                            ),
                            // Recurence end date
                            Container(
                              width: 350,
                              height: 50,
                              margin: const EdgeInsets.only(top: 10),
                              child: CustomDropdownButton(
                                width: 350, 
                                menuMaxHeight: 250,
                                menuTitle: S.of(context).calendar_new_event_recurence_end_date, 
                                enableSearch: true,
                                selectedOptionTitle: event.recurrence!.endDate != null 
                                  ? S.of(context).calendar_new_event_recurence_end_date_option_the
                                  : S.current.node_editor_add_sub_menu_none_input_output,
                                items: [
                                  CustomSelectionMenuItem(
                                    label: S.current.node_editor_add_sub_menu_none_input_output, 
                                    foregroundColor: event.recurrence?.endDate == null 
                                      ? widget.theme.secondary
                                      : null,
                                    icon: null, 
                                    onTap: () {
                                      setState(() {
                                        event.recurrence!.endDate = null;
                                      });
                                    }
                                  ),
                                  CustomSelectionMenuItem(
                                    label: S.of(context).calendar_new_event_recurence_end_date_option_the, 
                                    foregroundColor: event.recurrence?.endDate != null 
                                      ? widget.theme.secondary
                                      : null,
                                    icon: null, 
                                    onTap: () {
                                      setState(() {
                                        event.recurrence!.endDate = event.end.add(const Duration(days: 1)).copyWith(hour: 23, minute: 59);
                                      });
                                    }
                                  ),
                                ], 
                                theme: widget.theme
                              )
                            ),
                            if (event.recurrence!.endDate != null)
                              Container(
                                width: 350,
                                height: 45,
                                margin: const EdgeInsets.only(top: 10),
                                child: CustomDateInput(
                                  key: UniqueKey(),
                                  theme: widget.theme, 
                                  title: S.of(context).calendar_new_event_recurence_end_date,
                                  date: event.recurrence!.endDate,
                                  mode: CustomDatePickerMode.single,
                                  useTime: false,
                                  onSelected: (dates) {
                                    event.recurrence!.endDate = dates.first.copyWith(hour: 23, minute: 59);
                                  }
                                )
                              ),
                        ],
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
                          padding: const EdgeInsets.only(top: 5),
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
                                      iconReplacelemntWidth: 20,
                                      iconReplacement: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: calendar.color,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
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