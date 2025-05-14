import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_icon.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_padding.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_row.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_text.dart';
import 'package:minddy/system/plugin_ui_components/plugn_ui_components_add_menu_models.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_editor_show_ui_component_add_menu.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_controller.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_side_panel_layer_element.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_column_properties.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_container_propeties.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_icon_properties.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_padding_properties.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_row_properties.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/get_properties/get_text_properties.dart';
import 'package:minddy/ui/theme/theme.dart';

final PageStorageBucket _propetiesPageStorageBucket = PageStorageBucket();
final PageStorageBucket _layersPageStorageBucket = PageStorageBucket();

class PluginEditorUiViewSidePanelPropertiesElementList {
  String groupName;
  List<Widget> elements;

  PluginEditorUiViewSidePanelPropertiesElementList({required this.groupName, required this.elements});
}

class PluginEditorUiViewSidePanel extends StatefulWidget {
  const PluginEditorUiViewSidePanel({
    super.key,
    required this.height,
    required this.theme,
    required this.isClosedInitially,
    required this.setIsClosed,
    required this.controller
  });

  final double height;
  final StylesGetters theme;
  final bool isClosedInitially;
  final Function(bool) setIsClosed;
  final PluginEditorUiViewController controller;

  @override
  State<PluginEditorUiViewSidePanel> createState() =>
      _PluginEditorUiViewSidePanelState();
}

class _PluginEditorUiViewSidePanelState
    extends State<PluginEditorUiViewSidePanel> {
  bool isClosed = false;
  bool isFirstCreation = true;

  IPluginUiComponent? selectedComponent;

  void toggleSidePanel() {
    setState(() {
      isClosed = !isClosed;
      widget.setIsClosed(isClosed);
    });
  }

  @override
  void initState() {
    isClosed = widget.isClosedInitially;
    selectedComponent =  widget.controller.getSelectedComponent();
    super.initState();
  }

  List<PluginEditorUiViewSidePanelPropertiesElementList>? getComponentPropterties() {
    if (selectedComponent == null) {
      return null;
    }

    List<PluginEditorUiViewSidePanelPropertiesElementList> list = [];
    
    switch (selectedComponent) {
      case PluginUiComponentContainer():
        list = getContainerPropeties(selectedComponent!.properties as PluginUiComponentContainerProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
      case PluginUiComponentColumn():
        list = getColumnProperties(selectedComponent!.properties as PluginUiComponentColumnProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
      case PluginUiComponentRow():
        list = getRowProperties(selectedComponent!.properties as PluginUiComponentColumnProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
      case PluginUiComponentText():
        list = getTextProperties(selectedComponent!.properties as PluginUiComponentTextProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
      case PluginUiComponentPadding():
        list = getPaddingProperties(selectedComponent!.properties as PluginUiComponentPaddingProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
      case PluginUiComponentIcon():
        list = getIconPropeties(selectedComponent!.properties as PluginUiComponentIconProperties, widget.theme, context, widget.controller.componentViewUpdater.update, () {setState(() {});});
    }

    return list;
  }

  String? getSelectedComponentName() {
    if (selectedComponent == null) {
      return null;
    } else {
      return selectedComponent?.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastEaseInToSlowEaseOut,
      tween: Tween(
        begin: isFirstCreation
            ? widget.isClosedInitially
                ? 305.0
                : 0.0
            : isClosed
                ? 0.0
                : 305.0,
        end: isFirstCreation
            ? widget.isClosedInitially
                ? 305.0
                : 0.0
            : isClosed
                ? 305.0
                : 0.0,
      ),
      builder: (context, translate, child) {
        if (isFirstCreation) {
          isFirstCreation = false;
        }
        return Transform.translate(
          offset: Offset(translate, 0),
          child: SizedBox(
            width: 345,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Tooltip(
                      message: isClosed
                          ? S.of(context).node_editor_view_open_side_panel_tooltip
                          : S.of(context).node_editor_view_close_side_panel_tooltip,
                      preferBelow: true,
                      verticalOffset: (widget.height / 5) / 2,
                      child: Container(
                        width: 40,
                        height: widget.height / 7,
                        constraints: const BoxConstraints(minHeight: 90, maxHeight: 120),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: widget.theme.primaryContainer,
                          border: Border.all(
                            color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                            width: 0.5
                          )
                        ),
                        child: IconButton(
                          style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)))),
                          onPressed: toggleSidePanel,
                          icon: Center(
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 250),
                              turns: isClosed ? -0.5 : 0,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: widget.theme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<String>(
                  stream: widget.controller.selectedIdStream.stream,
                  builder: (context, snapshot) {
                    selectedComponent = widget.controller.getSelectedComponent();
                    return Visibility(
                      key: UniqueKey(),
                      visible: !isClosed || translate < 305,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Element properties
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                width: 300,
                                height: (widget.height / 2) - 2.5,
                                decoration: BoxDecoration(
                                  color: widget.theme.primaryContainer,
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                    color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                                    width: 0.5
                                  )
                                ),
                                child: Column(
                                  children: [
                                    // Element name
                                    SizedBox(
                                      height: 35,
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10, top: 8),
                                              child: Text(
                                                getSelectedComponentName() ?? '',
                                                style: widget.theme.titleLarge.
                                                  copyWith(
                                                    color: widget.theme.onPrimary,
                                                    fontSize: 20
                                                  ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (selectedComponent != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: SizedBox(
                                            width: 280,
                                            height: (widget.height / 2) - 2.5 - 40 - 8,
                                            child: PageStorage(
                                              bucket: _propetiesPageStorageBucket,
                                              child: ListView(
                                                key: const PageStorageKey("propeties_page_storage_bucket_key"),
                                                children: [
                                                  ...getComponentPropterties()!.map((list) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(top: 15),
                                                      child: Column(
                                                        spacing: 5,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              list.groupName,
                                                              style: widget.theme.headlineSmall
                                                                .copyWith(color: widget.theme.onPrimary.withValues(alpha: 0.7)),
                                                            ),
                                                          ),
                                                          ...list.elements
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ]
                                )
                              ),
                            ),
                          ),
                          // Layers
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                width: 300,
                                height: (widget.height / 2) - 2.5,
                                decoration: BoxDecoration(
                                  color: widget.theme.primaryContainer,
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                    color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                                    width: 0.5
                                  )
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10, top: 8),
                                              child: Text(
                                                S.of(context).plugin_editor_ui_side_panel_layers_title,
                                                style: widget.theme.titleLarge.
                                                  copyWith(
                                                    color: widget.theme.onPrimary,
                                                    fontSize: 20
                                                  ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: 280,
                                          height: (widget.height / 2) - 2.5 - 40 - 8,
                                          child: PageStorage(
                                            bucket: _layersPageStorageBucket,
                                            child: ListView(
                                              key: const PageStorageKey("layers_page_storage_bucket_key"),
                                              children: [
                                                if (widget.controller.components.isNotEmpty)
                                                  PluginEditorUiViewSidePanelLayerElement(
                                                    key: UniqueKey(),
                                                    theme: widget.theme, 
                                                    component: widget.controller.components.first, 
                                                    width: 280, 
                                                    selectedComponentId: widget.controller.selectedComponentId,
                                                    setSelectedComponent: widget.controller.setSelectedComponent,
                                                    controller: widget.controller,
                                                    updateModule: widget.controller.componentViewUpdater.update,
                                                    data: widget.controller.layersDataList.where((data) => data.componentid == widget.controller.components.first.id).first,
                                                    elementsDataList: widget.controller.layersDataList
                                                  )
                                                else 
                                                  SizedBox(
                                                    width: 280,
                                                    height: 40,
                                                    child: IconButton(
                                                      tooltip: S.of(context).plugin_editor_ui_side_panel_layers_add_button,
                                                      style: ButtonThemes.primaryButtonStyle(context),
                                                      onPressed: () {
                                                        showUiComponentAddMenu(
                                                          context,
                                                          PlugnUiComponentsAddMenuModels.asList,
                                                          widget.theme,
                                                          (component) {
                                                            if (component != null) {
                                                              widget.controller.addComponent(component);
                                                            }
                                                          },
                                                          true,
                                                          700,
                                                          420
                                                        );
                                                      }, 
                                                      icon: Icon(
                                                        Icons.add_rounded,
                                                        color: widget.theme.onSecondary
                                                      )
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String getSelectedBorderAlignmentTitle(List<int> sides, Map<int, String> map) {
  if (sides.isEmpty) {
    return S.current.node_editor_add_sub_menu_none_input_output;
  } else if (sides.length == 1) {
    return map[sides.first]!;
  } else if (sides.length == 4) {
    return S.current.plugin_editor_ui_side_panel_properties_style_alignment_all;
  } else {
    return S.current.plugin_editor_ui_side_panel_properties_style_alignment_multiples;
  }
}

Map<int, String> borderRadiusAligmentTitles = {
  1: S.current.plugin_editor_ui_side_panel_properties_style_alignment_top_left,
  2: S.current.plugin_editor_ui_side_panel_properties_style_alignment_top_right,
  3: S.current.plugin_editor_ui_side_panel_properties_style_alignment_bottom_right,
  4: S.current.plugin_editor_ui_side_panel_properties_style_alignment_bottom_left
};

Map<int, Widget> borderRadiusAligmentIcons = {
  1: Transform.scale(scaleX: -1, child: const Icon(Icons.rounded_corner_rounded)),
  2: const Icon(Icons.rounded_corner_rounded),
  3: Transform.scale(scaleY: -1, child: const Icon(Icons.rounded_corner_rounded)),
  4: Transform.scale(scaleX: -1, scaleY: -1, child: const Icon(Icons.rounded_corner_rounded)),
};

Map<int, String> borderAligmentTitles = {
  1: S.current.plugin_editor_ui_side_panel_properties_style_alignment_top,
  2: S.current.plugin_editor_ui_side_panel_properties_style_alignment_right,
  3: S.current.plugin_editor_ui_side_panel_properties_style_alignment_bottom,
  4: S.current.plugin_editor_ui_side_panel_properties_style_alignment_left
};

Map<int, Widget> borderAligmentIcons = {
  1: const Icon(Icons.border_top_rounded),
  2: const Icon(Icons.border_right_rounded),
  3: const Icon(Icons.border_bottom_rounded),
  4: const Icon(Icons.border_left_rounded)
};
