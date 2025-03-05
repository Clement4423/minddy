import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_component_properties_interface.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/ui/components/custom_components/custom_color_input.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_icon_input.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_theme_color_items.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/plugin_editor_ui_view_side_panel.dart';
import 'package:minddy/ui/theme/theme.dart';

List<PluginEditorUiViewSidePanelPropertiesElementList> getContainerPropeties(PluginUiComponentContainerProperties properties, StylesGetters theme, BuildContext context, Function onPropertiesChanged, Function updateSidePanel) {
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
        hint: S.current.plugin_editor_ui_side_panel_properties_style_border_radius,
        maxLength: 2,
        initialValue: properties.borderRadius.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.rounded_corner_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.borderRadius = (double.tryParse(value) ?? properties.borderRadius).clamp(0, 99);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomDropdownButton(
        width: 280,
        menuTitle: S.current.plugin_editor_ui_side_panel_properties_style_alignment,
        enableSearch: true,
        isMultipleSelectionMenu: true,
        onMenuClosed: updateSidePanel,
        selectedOptionTitle: getSelectedBorderAlignmentTitle(properties.borderRadiusAlignment.sides, borderRadiusAligmentTitles), 
        items: [
          CustomSelectionMenuItem(
            label: 'All', // TODO : Traduire
            icon: Icons.crop_square_rounded, 
            isSelected: properties.borderRadiusAlignment.sides.length == 4,
            closeMenuAfterSelected: true,
            onTap: () {
              if (properties.borderRadiusAlignment.sides.length == 4) {
                properties.borderRadiusAlignment.sides = [];
              } else {
                properties.borderRadiusAlignment.sides = [1, 2, 3, 4];
              }
              onPropertiesChanged();
            }
          ),
          ...List.generate(4, (index) {
            int realIndex = index + 1;
            return CustomSelectionMenuItem(
              label: borderRadiusAligmentTitles[realIndex]!, 
              icon: null,
              iconReplacement: borderRadiusAligmentIcons[realIndex], 
              iconReplacelemntWidth: 20,
              isSelected: properties.borderRadiusAlignment.sides.contains(realIndex),
              onTap: () {
                if (properties.borderRadiusAlignment.sides.contains(realIndex)) {
                  properties.borderRadiusAlignment.sides.remove(realIndex);
                } else {
                  properties.borderRadiusAlignment.sides.add(realIndex);
                }
                onPropertiesChanged();
              }
            );
          })
        ],
        theme: theme
      )
    ]
  );
  
  list.add(style);

  PluginEditorUiViewSidePanelPropertiesElementList border = PluginEditorUiViewSidePanelPropertiesElementList(
    groupName: S.current.plugin_editor_ui_side_panel_properties_border_subtitle, 
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
                color: IPluginUiComponentProperties.colorFromText(properties.borderColor), 
                onColorChanged: (newColor) {
                  properties.borderColor = IPluginUiComponentProperties.colorToText(newColor);
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
                buttonStyle: properties.borderColor.length >= 6 
                  ? ButtonThemes.secondaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))))
                  : ButtonThemes.primaryButtonStyle(context).copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                items: getThemeColorItems((text) {properties.borderColor = text;}, properties.borderColor, theme, onPropertiesChanged),
                child: Icon(
                  Icons.palette_outlined, 
                  color: properties.borderColor.length >= 6 
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
        hint: S.current.plugin_editor_ui_side_panel_properties_style_border_thickness,
        maxLength: 2,
        initialValue: properties.borderThickness.toStringAsFixed(0),
        inputFormatter: FilteringTextInputFormatter.digitsOnly,
        icon: Icon(
          Icons.line_weight_rounded,
          color: theme.onSurface
        ),
        onChanged: (value) {
          properties.borderThickness = (double.tryParse(value) ?? properties.borderThickness).clamp(0, 99);
        },
        onEditingComplete: (p0) {
          onPropertiesChanged();
        }
      ),
      CustomDropdownButton(
        width: 280,
        menuTitle: S.current.plugin_editor_ui_side_panel_properties_style_alignment,
        enableSearch: true,
        isMultipleSelectionMenu: true,
        onMenuClosed: updateSidePanel,
        selectedOptionTitle: getSelectedBorderAlignmentTitle(properties.borderAlignment.sides, borderAligmentTitles), 
        items: [
          CustomSelectionMenuItem(
            label: 'All', 
            icon: Icons.crop_square_rounded, 
            isSelected: properties.borderAlignment.sides.length == 4,
            closeMenuAfterSelected: true,
            onTap: () {
              if (properties.borderAlignment.sides.length == 4) {
                properties.borderAlignment.sides = [];
              } else {
                properties.borderAlignment.sides = [1, 2, 3, 4];
              }
              onPropertiesChanged();
            }
          ),
          ...List.generate(4, (index) {
            int realIndex = index + 1;
            return CustomSelectionMenuItem(
              label: borderAligmentTitles[realIndex]!, 
              icon: null,
              iconReplacement: borderAligmentIcons[realIndex], 
              iconReplacelemntWidth: 20,
              isSelected: properties.borderAlignment.sides.contains(realIndex),
              onTap: () {
                if (properties.borderAlignment.sides.contains(realIndex)) {
                  properties.borderAlignment.sides.remove(realIndex);
                } else {
                  properties.borderAlignment.sides.add(realIndex);
                }
                onPropertiesChanged();
              }
            );
          })
        ],
        theme: theme
      )
    ]
  );
  
  list.add(border);
  return list;
}
