import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_text.dart';
import 'package:minddy/ui/components/custom_components/custom_checkbox.dart';
import 'package:minddy/ui/components/custom_components/custom_color_input.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_theme_color_items.dart';
import 'package:minddy/ui/theme/theme.dart';

import '../plugin_editor_ui_view_side_panel.dart';

List<PluginEditorUiViewSidePanelPropertiesElementList> getTextProperties(PluginUiComponentTextProperties properties, StylesGetters theme, BuildContext context, Function onPropertiesChanged, Function updateSidePanel) {
  List<PluginEditorUiViewSidePanelPropertiesElementList> list = [];

  PluginEditorUiViewSidePanelPropertiesElementList size = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_size_subtitle, 
    elements: [
      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_size_width,
        initialValue: properties.width.toStringAsFixed(0),
        maxLength: 3,
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Transform.rotate(
          angle: pi / 2,
          child: Icon(
            Icons.height_rounded,
            color: theme.onSurface
          ),
        ),
        onChanged: (value) {
          properties.width = (double.tryParse(value) ?? properties.width).clamp(20, 700);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: S.current.plugin_editor_ui_side_panel_properties_size_height,
        maxLength: 3,
        initialValue: properties.height.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.height_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.height = (double.tryParse(value) ?? properties.height).clamp(20, 420);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );

  list.add(size);

  PluginEditorUiViewSidePanelPropertiesElementList text = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: "Text", 
    elements: [
      Container(
        width: 350,
        height: 120,
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(15)
        ),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: TextField(
          controller: TextEditingController(text: properties.text),
          onChanged: (value) => properties.text = value,
          style: theme.bodyMedium.
          copyWith(color: theme.onSurface),
          expands: true,
          maxLines: null,
          minLines: null,
          cursorColor: theme.onSurface,
          decoration: InputDecoration(
            hintText: S.current.articles_text_hint,
            hintStyle: theme.bodyMedium.copyWith(color: Colors.grey),
            border: InputBorder.none
          ),
        ),
      ),
      SizedBox(
        width: 350,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 137,
              height: 30,
              child: IconButton(
                style: ButtonThemes.secondaryButtonStyle(context),
                iconSize: 17,
                tooltip: "Refresh the module",
                onPressed: () {
                  onPropertiesChanged();
                }, 
                icon: const Icon(Icons.refresh_rounded)
              ),
            ),
            SizedBox(
              width: 137,
              height: 30,
              child: IconButton(
                style: ButtonThemes.secondaryButtonStyle(context),
                iconSize: 17,
                tooltip: "Add a translation",
                onPressed: () {
                  // TODO : Faire en sorte de coupler avec une traduction
                }, 
                icon: const Icon(Icons.translate_rounded)
              ),
            )
          ],
        ),
      )
    ]
  );
  
  list.add(text);

  PluginEditorUiViewSidePanelPropertiesElementList style = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_style_subtitle, 
    elements: [
      SizedBox(
        width: 280,
        height: 50,
        child: Row(
          spacing: 5,
          children: [
            SizedBox(
              width: 224,
              height: 50,
              child: CustomColorInput(
                theme: theme,
                color: IPluginUiComponentProperties.colorFromText(properties.color), 
                onColorChanged: (newColor) {
                  properties.color = IPluginUiComponentProperties.colorToText(newColor);
                  onPropertiesChanged();
                  updateSidePanel();
                }
              ),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: CustomSelectionMenu(
                theme: theme, 
                type: CustomSelectionMenuButttonType.icon, 
                enableSearch: true,
                menuMaxHeight: 300,
                onMenuClosed: updateSidePanel,
                buttonStyle: properties.color.length >= 6 
                  ? ButtonThemes.secondaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))))
                  : ButtonThemes.primaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                items: getThemeColorItems((text) {properties.color = text;}, properties.color, theme, onPropertiesChanged),
                child: Icon(
                  Icons.palette_outlined, 
                  color: properties.color.length >= 6 
                    ? theme.onPrimary
                    : theme.onSecondary
                  )
              ),
            )
          ],
        ),
      ),
      CustomIconInput(
        theme: theme,
        hint: 'Max lines',
        maxLength: 6,
        initialValue: properties.letterSpacing.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.format_list_numbered_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.maxLines = (int.tryParse(value) ?? properties.maxLines).clamp(0, 999999);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      Container(
        width: 350,
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 10),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                const Icon(Icons.format_underline_rounded),
                Text(
                  "Underline",
                  style: theme.bodyMedium
                )
              ],
            ),
            CustomCheckbox(
              value: properties.underline, 
              onChanged: (newValue) {
                properties.underline = newValue;
                onPropertiesChanged();
              }, 
              theme: theme
            )
          ],
        ),
      )
    ]
  );

  list.add(style);

  PluginEditorUiViewSidePanelPropertiesElementList font = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: "Font", 
    elements: [
      CustomDropdownButton(
        width: 280,
        menuTitle: "Font",
        enableSearch: true,
        selectedOptionTitle: getSelectedFontNameName(properties.fontName), 
        items: [
          CustomSelectionMenuItem(
            label: 'Montserrat', 
            labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: theme.onSurface
            ),
            foregroundColor: TextFontName.montserrat == properties.fontName ? theme.secondary : null,
            icon: null, 
            onTap: () {
              properties.fontName = TextFontName.montserrat;
              onPropertiesChanged();
              updateSidePanel();
            }
          )
        ],
        theme: theme
      ),
      CustomDropdownButton(
        width: 280,
        menuTitle: "Weight",
        menuMaxHeight: 350,
        enableSearch: true,
        selectedOptionTitle: getSelectedTextFontWeightName(properties.fontWeight), 
        items: [
          ...TextFontWeight.values.map((value) {
            return CustomSelectionMenuItem(
              label: getSelectedTextFontWeightName(value), 
              labelStyle: theme.bodyMedium.copyWith(fontWeight: getFontWeightForTextFontWeight(value), fontFamily: getFontFamilyFromTextFontName(properties.fontName)),
              foregroundColor: value == properties.fontWeight ? theme.secondary : null,
              icon: null, 
              onTap: () {
                properties.fontWeight = value;
                onPropertiesChanged();
                updateSidePanel();
              }
            );
          })
        ],
        theme: theme
      ),
      CustomDropdownButton(
        width: 280,
        menuMaxHeight: 350,
        menuTitle: "Alignment",
        enableSearch: true,
        selectedOptionTitle: getSelectedTextFontAligment(properties.textAlignment), 
        items: [
          ...TextAlignment.values.map((value) {
            return CustomSelectionMenuItem(
              label: getSelectedTextFontAligment(value), 
              foregroundColor: value == properties.textAlignment ? theme.secondary : null,
              icon: null, 
              onTap: () {
                properties.textAlignment = value;
                onPropertiesChanged();
                updateSidePanel();
              }
            );
          })
        ],
        theme: theme
      ),
      CustomIconInput(
        theme: theme,
        hint: 'Font size',
        maxLength: 3,
        initialValue: properties.fontSize.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.text_fields_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.fontSize = (double.tryParse(value) ?? properties.fontSize).clamp(0, 999);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );

  list.add(font);

  PluginEditorUiViewSidePanelPropertiesElementList spacing = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: "Spacing", 
    elements: [
      CustomIconInput(
        theme: theme,
        hint: 'Letter spacing',
        maxLength: 3,
        initialValue: properties.letterSpacing.toString(),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.format_color_text_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.letterSpacing = (double.tryParse(value) ?? properties.letterSpacing).clamp(0, 100);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomIconInput(
        theme: theme,
        hint: 'Word spacing',
        maxLength: 3,
        initialValue: properties.wordSpacing.toString(),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.abc_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.wordSpacing = (double.tryParse(value) ?? properties.wordSpacing).clamp(0, 100);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
    ]
  );
  
  list.add(spacing);
  return list;
}

String getSelectedFontNameName(TextFontName name) {
  switch (name) {
    case TextFontName.montserrat:
      return 'Montserrat';
  }
}

String getSelectedTextFontWeightName(TextFontWeight name) {
  switch (name) {
    case TextFontWeight.thin:
      return 'Thin';
    case TextFontWeight.extraLight:
      return 'Extra Light';
    case TextFontWeight.light:
      return 'Light';
    case TextFontWeight.regular:
      return 'Regular';
    case TextFontWeight.medium:
      return 'Medium';
    case TextFontWeight.semiBold:
      return 'Semi Bold';
    case TextFontWeight.bold:
      return 'Bold';
    case TextFontWeight.extraBold:
      return 'Extra Bold';
    case TextFontWeight.black:
      return 'Black';
  }
}

String getSelectedTextFontAligment(TextAlignment alignment) {
  switch (alignment) {
    case TextAlignment.start:
      return 'Start';
    case TextAlignment.center:
      return 'Center';
    case TextAlignment.end:
      return 'End';
    case TextAlignment.justify:
      return 'Justify';
  }
}