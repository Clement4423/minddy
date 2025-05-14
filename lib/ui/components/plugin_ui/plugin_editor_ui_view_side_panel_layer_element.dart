import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_column.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_padding.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_row.dart';
import 'package:minddy/system/plugin_ui_components/plugn_ui_components_add_menu_models.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_editor_show_ui_component_add_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class PluginEditorUiViewSidePanelLayerElementData {
  bool showChild;
  int componentid;

  PluginEditorUiViewSidePanelLayerElementData({required this.showChild, required this.componentid});

  String toJson() {
    return jsonEncode({
      'show_child': showChild,
      'id': componentid
    });
  }

  factory PluginEditorUiViewSidePanelLayerElementData.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);

    return PluginEditorUiViewSidePanelLayerElementData(
      showChild: map['show_child'],
      componentid: map['id']
    );
  }
}

class PluginEditorUiViewSidePanelLayerElement extends StatefulWidget {
  const PluginEditorUiViewSidePanelLayerElement({
    super.key,
    required this.theme,
    required this.component,
    required this.width,
    required this.selectedComponentId,
    required this.setSelectedComponent,
    required this.controller,
    required this.updateModule,
    required this.data,
    required this.elementsDataList
  });

  final StylesGetters theme;
  final IPluginUiComponent component;
  final int? selectedComponentId;
  final Function(int?) setSelectedComponent;
  final double width;
  final PluginEditorUiViewController controller;
  final Function() updateModule;
  final PluginEditorUiViewSidePanelLayerElementData data;
  final List<PluginEditorUiViewSidePanelLayerElementData> elementsDataList;

  @override
  State<PluginEditorUiViewSidePanelLayerElement> createState() => _PluginEditorUiViewSidePanelLayerElementState();
}

class _PluginEditorUiViewSidePanelLayerElementState extends State<PluginEditorUiViewSidePanelLayerElement> {

  late Color backgroundColor; 
  late Color foregroundColor;

  Size get componentSize => IPluginUiComponent.getSize(widget.component);

  @override
  void initState() {
    if (widget.component.id == widget.selectedComponentId) {
      backgroundColor = widget.theme.secondary;
      foregroundColor = widget.theme.onSecondary;
    } else {
      backgroundColor = widget.theme.surface;
      foregroundColor = widget.theme.onSurface;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 5,
        children: [
          // Component
          GestureDetector(
            onTap: () {
              widget.setSelectedComponent(widget.component.id);
            },
            child: Container(
              height: 40,
              width: widget.width,
              padding: const EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Expanded(
                      child: Row(
                        spacing: 10,
                        children: [
                          if (widget.component.child.isNotEmpty)
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.data.showChild = !widget.data.showChild;
                                  });
                                },
                                child: Tooltip(
                                  message: widget.data.showChild
                                    ? S.of(context).plugin_editor_ui_side_panel_layers_hide_child(widget.component.child.length)
                                    : S.of(context).plugin_editor_ui_side_panel_layers_show_child(widget.component.child.length),
                                  child: AnimatedRotation(
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeInOut,
                                    turns: widget.data.showChild 
                                    ? 0.5
                                    : 0.25,
                                    child: Icon(Icons.keyboard_arrow_up_rounded,
                                        color: foregroundColor, 
                                        size: 24,
                                        semanticLabel: widget.data.showChild
                                          ? S.of(context).plugin_editor_ui_side_panel_layers_hide_child(widget.component.child.length)
                                          : S.of(context).plugin_editor_ui_side_panel_layers_show_child(widget.component.child.length)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Text(
                            widget.component.name,
                            style: widget.theme.titleMedium
                              .copyWith(color: foregroundColor)
                          )
                        ],
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        if (IPluginUiComponent.canHaveChildren(widget.component) && (IPluginUiComponent.canHaveMultipleChilren(widget.component) || widget.component.child.isEmpty))
                          Tooltip(
                            message: S.of(context).plugin_editor_ui_side_panel_layers_add_child,
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: IconButton(
                                onPressed: () {
                                  showUiComponentAddMenu(
                                    context,
                                    PlugnUiComponentsAddMenuModels.asList,
                                    widget.theme,
                                    (newComponent) {
                                      if (newComponent != null) {
                                        widget.controller.addChild(newComponent, widget.component.id);
                                      }
                                    },
                                    true,
                                    componentSize.width,
                                    componentSize.height
                                  );
                                }, 
                                style: ButtonThemes.secondaryButtonStyle(context),
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: widget.theme.onPrimary,
                                  size: 15,
                                )
                              ),
                            ),
                          ),
                        Tooltip(
                          message: 'More',
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CustomSelectionMenu(
                              theme: widget.theme,
                              buttonStyle: ButtonThemes.secondaryButtonStyle(context),
                              type: CustomSelectionMenuButttonType.icon,
                              items: [
                                CustomSelectionMenuItem(
                                  label: "Wrap",
                                  icon: Icons.wrap_text_rounded, 
                                  onTap: () {
                                    bool isParentPadding = widget.controller.findParent(widget.component.id) is PluginUiComponentPadding;
                                    showUiComponentAddMenu(
                                      context,
                                      PlugnUiComponentsAddMenuModels.asList.where((element) { // TODO : Modifier pour utiliser le S
                                        if (element.name == 'Padding' && (widget.component is PluginUiComponentPadding || isParentPadding)) {
                                          return false;
                                        }
                                        return element.canHaveChildren;
                                      }).toList(),
                                      widget.theme,
                                      (newComponent) {
                                        if (newComponent != null) {
                                          IPluginUiComponent? parent = widget.controller.findParent(widget.component.id);
                                          if (parent != null) {
                                            widget.controller.deleteComponent(widget.component, false);
                                            widget.controller.addChild(newComponent, parent.id, false);  
                                            widget.controller.addChild(widget.component, newComponent.id);
                                          }
                                        }
                                      },
                                      true,
                                      componentSize.width,
                                      componentSize.height
                                    );
                                  }
                                ),
                                CustomSelectionMenuItem(
                                  label: S.of(context).settings_project_rename_button,
                                  icon: Icons.drive_file_rename_outline, 
                                  onTap: () {
                                    showSubMenu(
                                      context, 
                                      RenameSubMenu(
                                        initialName: widget.component.name, 
                                        theme: widget.theme, 
                                        onValidate: (newName) {
                                          if (newName.replaceAll(' ', '').isEmpty) {
                                            NotificationHandler.addNotification(
                                              NotificationModel(
                                                content: 'Component\'s name cannot be empty', 
                                                action: null, 
                                                actionLabel: S.of(context).snackbar_close_button, 
                                                duration: NotificationDuration.long
                                              )
                                            );
                                          } else {
                                            widget.component.name = newName;
                                            widget.controller.componentViewUpdater.update();
                                            setState(() {});
                                          }
                                        }
                                      )
                                    );
                                  }
                                ),
                                if (widget.component.child.isNotEmpty)
                                  CustomSelectionMenuItem(
                                    label: S.of(context).snackbar_delete_button,  
                                    foregroundColor: widget.theme.error,
                                    icon: Icons.delete_outline_rounded, 
                                    items: [
                                      CustomSelectionMenuItem(
                                        label: "Delete children",  
                                        foregroundColor: widget.theme.error,
                                        icon: Icons.delete_outline_rounded, 
                                        onTap: () {
                                          widget.controller.deleteComponent(widget.component);
                                        }
                                      ),
                                      CustomSelectionMenuItem(
                                        label: "Keep children",  
                                        tooltip: widget.component.properties is PluginUiComponentColumnProperties && widget.component.child.length > 1 
                                          ? CustomSelectionMenuItemTooltip(
                                            title: "Warning",
                                            text: "Only the first child will be kept",
                                            border: Border.all(
                                              color: widget.theme.error.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.4),
                                              width: 0.5,
                                              strokeAlign: BorderSide.strokeAlignInside
                                            ),
                                            backgroundColor: widget.theme.error.withValues(alpha: 0.5),
                                            foregroundColor: widget.theme.onError
                                          )
                                          : null,
                                        foregroundColor: widget.theme.error,
                                        icon: Icons.delete_outline_rounded, 
                                        onTap: () {
                                          IPluginUiComponent? child = widget.component.child.firstOrNull;
                                          IPluginUiComponent? parent = widget.controller.findParent(widget.component.id);
                                          if (child != null && parent != null) {
                                            widget.controller.deleteComponent(widget.component, false);
                                            widget.controller.addChild(child, parent.id);
                                          }
                                        }
                                      ),
                                  ],
                                  onTap: () {}
                                )
                                else 
                                  CustomSelectionMenuItem(
                                    label: S.of(context).snackbar_delete_button,  
                                    foregroundColor: widget.theme.error,
                                    icon: Icons.delete_outline_rounded, 
                                    onTap: () {
                                      widget.controller.deleteComponent(widget.component);
                                    }
                                  ),
                              ], 
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: widget.theme.onPrimary,
                                size: 15
                              )
                            )
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          // Childs
          if ((widget.component is PluginUiComponentColumn || widget.component is PluginUiComponentRow) && widget.data.showChild) 
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = widget.component.child.removeAt(oldIndex);
                  widget.component.child.insert(newIndex, item);
                  widget.updateModule();
                });
              },
              proxyDecorator: (Widget child, int index, Animation<double> animation) {
                return Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withAlpha(99),
                  child: child,
                );
              },
              children: [
                for (int i = 0; i < widget.component.child.length; i++)
                  Padding(
                    key: UniqueKey(),
                    padding: EdgeInsets.only(bottom: i < widget.component.child.length - 1 ? 5 : 0),
                    child: ReorderableDragStartListener(
                      key: UniqueKey(),
                      index: i,
                      child: PluginEditorUiViewSidePanelLayerElement(
                        theme: widget.theme, 
                        component: widget.component.child[i], 
                        width: (widget.width - 10).clamp(60, 280), 
                        selectedComponentId: widget.selectedComponentId, 
                        setSelectedComponent: widget.setSelectedComponent, 
                        controller: widget.controller,
                        updateModule: widget.updateModule,
                        data: widget.elementsDataList.where((data) => data.componentid == widget.component.child[i].id).first,
                        elementsDataList: widget.elementsDataList
                      ),
                    ),
                  ),
              ],
            )
          else if (widget.component.child.isNotEmpty && widget.data.showChild)
            ...widget.component.child.map((child) {
              return PluginEditorUiViewSidePanelLayerElement(
                theme: widget.theme, 
                component: child, 
                width: (widget.width - 10).clamp(60, 280), 
                selectedComponentId: widget.selectedComponentId, 
                setSelectedComponent: widget.setSelectedComponent, 
                controller: widget.controller,
                updateModule: widget.updateModule,
                data: widget.elementsDataList.where((data) => data.componentid == child.id).first,
                elementsDataList: widget.elementsDataList
              );
            })
        ],
      ),
    );
  }
}

class RenameSubMenu extends StatefulWidget {
  const RenameSubMenu({
    super.key,
    this.initialName,
    required this.onValidate,
    required this.theme
  });

  final String? initialName;
  final Function(String) onValidate;
  final StylesGetters theme;

  @override
  State<RenameSubMenu> createState() => _RenameSubMenuState();
}

class _RenameSubMenuState extends State<RenameSubMenu> {

  String text = '';

  @override
  void initState() {
    if (widget.initialName != null) {
      text = widget.initialName!;
    }
    super.initState();
  }

  void _validate() {
    widget.onValidate(text); 
    if (context.mounted) {
      Navigator.pop(context);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 161,
      decoration: BoxDecoration(
        color: widget.theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.4),
          width: 0.5,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(10).copyWith(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: 280,
                height: 30,
                child: Text(
                  S.of(context).settings_project_rename_button,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.theme.titleLarge
                )
              ),
            ),
            Container(
              width: 280,
              height: 50,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.theme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                autofocus: true,
                controller: TextEditingController(text: text),
                onChanged: (value) => text = value,
                onEditingComplete: _validate,
                style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface, fontSize: 18),
                cursorColor: widget.theme.onSurface,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter a new name...",
                  hintStyle: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 135,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (context.mounted) {
                          Navigator.pop(context);
                        } 
                      }, 
                      style: ButtonThemes.secondaryButtonStyle(context),
                      child: Text(
                        S.of(context).calendar_button_due_date_cancel_complete,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodyMedium.copyWith(fontSize: 17, color: widget.theme.onSecondary) 
                      )
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _validate,
                      style: ButtonThemes.primaryButtonStyle(context),
                      child: Text(
                        S.of(context).submenu_artilces_image_description_button,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodyMedium.copyWith(fontSize: 17, color: widget.theme.onSecondary) 
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}