import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/plugin_ui_components/plugn_ui_components_add_menu_models.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/plugin_editor_show_ui_component_add_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class PluginEditorUiViewSidePanelLayerElement extends StatefulWidget {
  const PluginEditorUiViewSidePanelLayerElement({
    super.key,
    required this.theme,
    required this.component,
    required this.width,
    required this.selectedComponentId,
    required this.setSelectedComponent,
    required this.deleteComponent,
    required this.addChild
  });

  final StylesGetters theme;
  final IPluginUiComponent component;
  final int? selectedComponentId;
  final Function(int?) setSelectedComponent;
  final double width;
  final Function(IPluginUiComponent) deleteComponent;
  final Function(IPluginUiComponent, int) addChild;

  @override
  State<PluginEditorUiViewSidePanelLayerElement> createState() => _PluginEditorUiViewSidePanelLayerElementState();
}

class _PluginEditorUiViewSidePanelLayerElementState extends State<PluginEditorUiViewSidePanelLayerElement> {

  late Color backgroundColor; 
  late Color foregroundColor;

  bool showChild = true;

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
                                    showChild = !showChild;
                                  });
                                },
                                child: Tooltip(
                                  message: showChild // TODO : Animer le showChild
                                    ? S.of(context).plugin_editor_ui_side_panel_layers_hide_child(widget.component.child.length)
                                    : S.of(context).plugin_editor_ui_side_panel_layers_show_child(widget.component.child.length),
                                  child: AnimatedRotation(
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeInOut,
                                    turns: showChild 
                                    ? 0.5
                                    : 0.25,
                                    child: Icon(Icons.keyboard_arrow_up_rounded,
                                        color: foregroundColor, 
                                        size: 24,
                                        semanticLabel: showChild
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
                        if (IPluginUiComponent.canHaveMultipleChilren(widget.component) || widget.component.child.isEmpty)
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
                                        widget.addChild(newComponent, widget.component.id);
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
                                  label: S.of(context).snackbar_delete_button,  
                                  foregroundColor: widget.theme.error,
                                  icon: Icons.delete_outline_rounded, 
                                  onTap: () {
                                    widget.deleteComponent(widget.component);
                                  }
                                )
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
          if (widget.component.child.isNotEmpty && showChild)
            ...widget.component.child.map((child) {
              return PluginEditorUiViewSidePanelLayerElement(
                theme: widget.theme, 
                component: child, 
                width: (widget.width - 10).clamp(60, 280), 
                selectedComponentId: widget.selectedComponentId, 
                setSelectedComponent: widget.setSelectedComponent, 
                deleteComponent: widget.deleteComponent, 
                addChild: widget.addChild
              );
            })
        ],
      ),
    );
  }
}