import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/custom_components/custom_color_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/theme/theme.dart';

class NewCalendarSubMenu extends StatefulWidget {
  const NewCalendarSubMenu({
    super.key, 
    required this.theme, 
    this.calendar, 
    required this.onSelected
  });

  final StylesGetters theme;
  final Calendar? calendar;
  final Function(Calendar) onSelected;

  @override
  State<NewCalendarSubMenu> createState() => _NewCalendarSubMenuState();
}

class _NewCalendarSubMenuState extends State<NewCalendarSubMenu> {

  Calendar calendar = Calendar(
    name: '', 
    id: createUniqueId(), 
    color: DefaultAppColors.blue.color,
    events: [], 
    isPrivate: false
  );

  DefaultAppColor? findDefaultColor(Color color) {
    return DefaultAppColors.asList.where((c) => c.color == color).firstOrNull;
  }

  @override
  void initState() {
    if (widget.calendar != null) {
      calendar = widget.calendar!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
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
                  widget.calendar != null 
                    ? S.of(context).calendar_button_manage_calendars_sub_menu_modify_calendar 
                    : S.of(context).calendar_button_manage_calendars_sub_menu_add_calendar, 
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
                                S.of(context).calendar_button_new_calendar_calendar_subtitle_name,
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
                              controller: TextEditingController(text: calendar.name),
                              onChanged: (value) => calendar.name = value,
                              style: widget.theme.bodyMedium.
                              copyWith(color: widget.theme.onSurface),
                              cursorColor: widget.theme.onSurface,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                                hintStyle: widget.theme.bodyMedium.copyWith(color: Colors.grey),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          // Color
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).node_editor_view_side_panel_variables_variable_type_color, 
                                style: widget.theme.bodySmall.
                                copyWith(color: widget.theme.onPrimary),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomSelectionMenu(
                              buttonStyle: const ButtonStyle(
                                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                elevation: WidgetStatePropertyAll(0)
                              ),
                              theme: widget.theme, 
                              menuMaxHeight: 350,
                              enableSearch: true,
                              items: [
                                ...DefaultAppColors.asList.map((color) => CustomSelectionMenuItem(
                                  label: color.colorName, 
                                  icon: null,
                                  foregroundColor: calendar.color == color.color 
                                    ? widget.theme.secondary
                                    : widget.theme.onPrimary,
                                  iconReplacelemntWidth: 25,
                                  iconReplacement: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: color.color,
                                      borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ), 
                                  onTap: () {
                                    setState(() {
                                      calendar.color = color.color;
                                    });
                                  }
                                )),
                                CustomSelectionMenuItem(
                                  label: S.of(context).calendar_button_new_calendar_personalized_color, 
                                  foregroundColor: findDefaultColor(calendar.color) == null 
                                    ? widget.theme.secondary
                                    : widget.theme.onPrimary,
                                  icon: Icons.brush_rounded, 
                                  onTap: () {
                                    setState(() {
                                      calendar.color = Colors.white;
                                    });
                                  }
                                )
                              ], 
                              child: Container(
                                width: 350,
                                height: 45,
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
                                          width: 25,
                                          height: 25,
                                          margin: const EdgeInsets.only(left: 10, right: 8.0),
                                          decoration: BoxDecoration(
                                            color: calendar.color,
                                            borderRadius: BorderRadius.circular(8.0)
                                          ),
                                        ),
                                        Text(
                                          findDefaultColor(calendar.color)?.colorName ?? S.of(context).calendar_button_new_calendar_personalized_color,
                                          style: widget.theme.bodyMedium
                                            .copyWith(color: widget.theme.onSurface),
                                        )
                                      ],
                                    ), 
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: widget.theme.onSurface,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          ),
                          if (findDefaultColor(calendar.color) == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomColorInput(
                                theme: widget.theme, 
                                color: calendar.color,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    calendar.color = color;
                                  });
                                },
                                useOpacity: false,
                              ),
                            ),
                          // Is private
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).settings_project_privacy_subtitle, 
                                style: widget.theme.bodySmall.
                                copyWith(color: widget.theme.onPrimary),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Tooltip(
                              message: S.of(context).calendar_button_new_calendar_private_calendar_explanation,
                              child: SizedBox(
                                width: 350,
                                height: 60,
                                child: SwitchTile(
                                  calendar.isPrivate, 
                                  S.of(context).calendar_button_new_calendar_private_calendar_title, 
                                  (value) async {
                                    if (widget.calendar != null) {
                                      if (widget.calendar!.isPrivate) {
                                        bool isUnlocked = await showUnlockContentSubMenu(context);
                                        if (!isUnlocked) {
                                          return;
                                        }
                                      }
                                    }
                                    setState(() {
                                      calendar.isPrivate = value;  
                                    });
                                  }, 
                                  false
                                ),
                              ),
                            ),
                          ),
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
                      widget.calendar != null 
                        ? S.of(context).projects_module_notes_modify_category
                        : S.of(context).submenu_new_project_button, 
                      () async {
                        await widget.onSelected(calendar);
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
        ),
      ),
    );
  }
}