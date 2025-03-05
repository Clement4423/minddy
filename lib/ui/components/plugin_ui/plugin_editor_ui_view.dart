import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/plugin_ui_components/plugin_ui_component_container.dart';
import 'package:minddy/ui/components/plugin_ui/plugin_editor_ui_view_controller.dart';
import 'package:minddy/ui/components/plugin_ui/side_panel/plugin_editor_ui_view_side_panel.dart';
import 'package:minddy/ui/theme/theme.dart';

class PluginEditorUiView extends StatefulWidget {
  const PluginEditorUiView(
      {super.key, required this.theme, required this.controller});

  final StylesGetters theme;
  final PluginEditorUiViewController controller;

  @override
  State<PluginEditorUiView> createState() => _PluginEditorUiViewState();
}

class _PluginEditorUiViewState extends State<PluginEditorUiView> {
  @override
  Widget build(BuildContext context) {
    Size appWindowSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        widget.controller.setSelectedComponent(null);
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: widget.controller.componentViewUpdater,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ...widget.controller.components.map((c) {
                      return _HoverComponentWidget(
                        key: UniqueKey(),
                        theme: widget.theme, 
                        component: c, 
                        components: widget.controller.components,
                        selectedComponentId: widget.controller.selectedComponentId,
                        findParent: widget.controller.findParent,
                        onClick: (c) {},
                        delete: widget.controller.deleteComponent,
                        setSelectedComponent: widget.controller.setSelectedComponent
                      );
                    }),
                    
                  ],
                );
              }
            ),
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  // This onTap is here to avoid deselecting the ui component by clicking the menu.
                },
                child: PluginEditorUiViewSidePanel(
                  controller: widget.controller,
                  height: (appWindowSize.height / 1.2) - 5,
                  theme: widget.theme,
                  isClosedInitially: widget.controller.isSidePanelClosed,
                  setIsClosed: widget.controller.setIsSidePanelClosed
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class _HoverComponentWidget extends StatefulWidget {
  const _HoverComponentWidget({
    super.key,
    required this.theme, 
    required this.component, 
    required this.selectedComponentId,
    required this.components,
    required this.onClick,
    required this.findParent,
    required this.delete,
    required this.setSelectedComponent
  });

  final StylesGetters theme;
  final IPluginUiComponent component;
  final List<IPluginUiComponent> components;
  final int? selectedComponentId;
  final Function(IPluginUiComponent) onClick;
  final Function(IPluginUiComponent) delete;
  final Function(int, [IPluginUiComponent]) findParent;
  final Function(int) setSelectedComponent;

  @override
  State<_HoverComponentWidget> createState() => __HoverComponentWidgetState();
}

class __HoverComponentWidgetState extends State<_HoverComponentWidget> {

  bool isSelected = false;

  late Size widgetSize;

  void verifySize() {
    IPluginUiComponent? parent = widget.findParent(widget.component.id);

    if (parent == null) {
      return;
    } else {
      Size parentSize = IPluginUiComponent.getSize(parent);
      Size newSize = widgetSize;
      if (widgetSize.width > parentSize.width) {
        newSize = Size(parentSize.width, newSize.height);
      } 
      if (widgetSize.height > parentSize.height) {
        newSize = Size(newSize.width, parentSize.height);
      }
      IPluginUiComponent.modifySize(newSize, widget.component);
      widgetSize = newSize;
    }
  }

  @override
  void initState() {
    isSelected = widget.component.id == widget.selectedComponentId;
    widgetSize = IPluginUiComponent.getSize(widget.component);
    count += 1;
    verifySize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: widgetSize.width,
          height: widgetSize.height,
          decoration: BoxDecoration(
            borderRadius: getBorderRadiusFromProperties(
              IPluginUiComponent.getRadius(widget.component),
              IPluginUiComponent.getRadiusAlignment(widget.component)
            ),
            border: isSelected 
              ? Border.all(
                  width: 2, 
                  color: DefaultAppColors.blue.color
                )
              : null
          ),
          child: GestureDetector(
            onTap: () {
              widget.setSelectedComponent(widget.component.id);
            },
            child: widget.component.preview(
              widget.component.child.map((child) => _HoverComponentWidget(
                key: UniqueKey(),
                theme: widget.theme,
                component: child,
                components: widget.components,
                selectedComponentId: widget.selectedComponentId,
                findParent: widget.findParent,
                onClick: (c) {},
                delete: widget.delete,
                setSelectedComponent: widget.setSelectedComponent
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}


int count = 1;