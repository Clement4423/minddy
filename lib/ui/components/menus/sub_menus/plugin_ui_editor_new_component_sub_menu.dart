import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/plugin_ui_components_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/utils/ui_updater.dart';

class PluginUiEditorNewComponentSubMenu extends StatefulWidget {
  const PluginUiEditorNewComponentSubMenu({super.key, required this.onSelected, required this.componentsToShow, required this.theme, required this.onClosed, required this.autosearch, required this.maxWidth, required this.maxHeight});

  final List<PlugnUiComponentsAddMenuModel> componentsToShow;

  final Function(IPluginUiComponent?) onSelected;
  final Function onClosed;
  final bool autosearch;
  final double maxWidth;
  final double maxHeight;

  final StylesGetters theme;

  @override
  State<PluginUiEditorNewComponentSubMenu> createState() => _PluginUiEditorNewComponentSubMenuState();
}

class _PluginUiEditorNewComponentSubMenuState extends State<PluginUiEditorNewComponentSubMenu> {

  bool isSearching = false;

  PlugnUiComponentsAddMenuModel? selectedComponent;

  void search(String query) {
    String transformedQuery = SearchTextFormatter.format(query);
    if (transformedQuery.isEmpty) {
      componentsList = widget.componentsToShow;
    } else {
      componentsList = widget.componentsToShow.where((Component) {
        String transformedName = SearchTextFormatter.format(Component.name);
        String transformedDescription = SearchTextFormatter.format(Component.description);
        String transformedCategory = SearchTextFormatter.format(_getPluginUiComponentTypeName(Component.category));

        return transformedName.contains(transformedQuery) 
          || transformedCategory.contains(transformedQuery)
          || transformedDescription.contains(transformedQuery);
      }).toList();
    }
    if (!componentsList.contains(selectedComponent) && componentsList.isNotEmpty) {
      selectedComponent = componentsList.firstOrNull;
    }
    updater.update();
  }

  List<Widget> _buildComponentCategoryList() {
    // Group Components by category
    Map<PluginUiComponentType, List<PlugnUiComponentsAddMenuModel>> categorizedComponents = {};
    for (var component in componentsList) {
      categorizedComponents.putIfAbsent(component.category, () => []).add(component);
    }

    // Build a list of Widgets
    List<Widget> componentWidgets = [];
    categorizedComponents.forEach((category, components) {
      // Add category header
      componentWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
          child: Text(
            _getPluginUiComponentTypeName(category),
            style: widget.theme.bodySmall
              .copyWith(color: widget.theme.onSurface),
          ),
        ),
      );

      // Add Components under this category
      for (var component in components) {
        componentWidgets.add(
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedComponent = component;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 4.0),
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color: component == selectedComponent ? widget.theme.secondary : widget.theme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getPluginUiComponentTypeIcon(category), 
                      color: component == selectedComponent 
                        ? widget.theme.onSecondary 
                        : widget.theme.onPrimary,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        component.name,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodyMedium
                        .copyWith(
                          color: component == selectedComponent ? widget.theme.onSecondary : widget.theme.onPrimary,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });

    if (componentWidgets.isEmpty) {
      componentWidgets.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              S.current.articles_search_empty, 
              style: widget.theme.titleMedium
                .copyWith(
                  color: widget.theme.onSurface
                )
              ),
          )
          )
      );
    }

    return componentWidgets;
  }

  List<PlugnUiComponentsAddMenuModel> componentsList = [];

  UiUpdater updater = UiUpdater();

  FocusNode searchBarFocusNode = FocusNode();

  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    componentsList = widget.componentsToShow;
    selectedComponent = componentsList.firstOrNull;
    if (widget.autosearch) {
      searchBarFocusNode.requestFocus();
    }
    super.initState();
  }

  void addFocusToSearchbar() {
    searchBarFocusNode.requestFocus();
  }

  void executeOnSelected() {
    if (selectedComponent != null) {
      widget.onSelected(selectedComponent?.create(widget.maxWidth, widget.maxHeight));
    } 
  }

  @override
  void dispose() {
    searchBarFocusNode.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.slash): addFocusToSearchbar,
            const SingleActivator(LogicalKeyboardKey.question): addFocusToSearchbar,
            const SingleActivator(LogicalKeyboardKey.colon): addFocusToSearchbar,
            const SingleActivator(LogicalKeyboardKey.enter): () {
              executeOnSelected();
              Navigator.pop(context);
            },
            const SingleActivator(LogicalKeyboardKey.numpadEnter): () {
              executeOnSelected();
              Navigator.pop(context);
            },
          },
          child: Focus(
            autofocus: true,
            child: Container(
              width: 700,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: widget.theme.primaryContainer,
                border: Border.all(
                  color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                  width: 0.5
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.theme.shadow.withValues(alpha: 0.2),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4)
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Side bar
                    Container(
                      width: 230,
                      height: 380,
                      decoration: BoxDecoration(
                        color: widget.theme.surface,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          // Search bar
                          Container(
                            width: 210,
                            height: 45,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: widget.theme.primary,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: widget.theme.onPrimary,
                                width: 1
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // / to search
                                  if (!isSearching)
                                    Container(
                                      width: 18,
                                      height: 22,
                                      margin: const EdgeInsets.only(left: 12, right: 7),
                                      decoration: BoxDecoration(
                                        color: widget.theme.brightness == Brightness.light ? Colors.white10 : Colors.white60,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: widget.theme.onPrimary.withValues(alpha: 0.2),
                                          width: 1
                                        ),
                                      ),
                                      child: Center(
                                        child: Text('/', style: widget.theme.bodyMedium.copyWith(fontSize: 15, color: Colors.black)),
                                      ),
                                    ),
                                  Expanded(
                                    child: Center(
                                      child: TextSelectionTheme(
                                        data: TextSelectionThemeData(
                                          selectionColor: DefaultAppColors.blue.color.withValues(alpha: 0.8)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: isSearching ? 12 : 0),
                                          child: TextField(
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                isSearching = true;
                                              } else {
                                                isSearching = false;
                                              }
                                              search(value);
                                              setState(() {});
                                            },
                                            autofocus: widget.autosearch,
                                            controller: searchTextController,
                                            focusNode: searchBarFocusNode,
                                            onTapOutside: (event) {
                                              searchBarFocusNode.unfocus();
                                              isSearching = false;
                                            },
                                            style: widget.theme.bodyMedium
                                              .copyWith(color: widget.theme.onPrimary),
                                            cursorColor: widget.theme.onPrimary,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.only(bottom: 7),
                                              hintText: "${S.current.articles_search}..."
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: searchTextController.text.isNotEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          searchTextController.clear();
                                          searchBarFocusNode.requestFocus();
                                          search('');
                                          setState(() {});
                                        },
                                        child: Icon(
                                          searchTextController.text.isNotEmpty 
                                            ? Icons.close_rounded 
                                            : Icons.search_rounded,
                                          color: widget.theme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Components list
                          Expanded(
                            child: AnimatedBuilder(
                              animation: updater,
                              builder: (context, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ListView(
                                      children: _buildComponentCategoryList()
                                    ),
                                  ),
                                );
                              }
                            )
                          )
                        ],
                      ),
                    ),
                    // Details view
                    Stack(
                      children: [
                        Container(
                          width: 440,
                          height: 380,
                          decoration: BoxDecoration(
                            color: widget.theme.surface,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: AnimatedBuilder(
                            animation: updater,
                            builder: (context, child) {
                              if (selectedComponent != null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header
                                    SizedBox(
                                      width: 440,
                                      height: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, top: 20, right: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Component name
                                            Text(
                                              selectedComponent!.name,
                                              style: widget.theme.titleLarge
                                              .copyWith(color: widget.theme.onSurface),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Component description
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                selectedComponent!.description,
                                                style: widget.theme.bodyMedium
                                                .copyWith(color: widget.theme.onSurface, fontWeight: FontWeight.w300),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Body with preview
                                    Center(
                                      child: selectedComponent!.canCreatePreview 
                                        ? Container(
                                          width: 420,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: widget.theme.primaryContainer
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: SizedBox(
                                                  width: 420,
                                                  height: 200,
                                                  child: GridPaper(
                                                    interval: 30,
                                                    subdivisions: 1,
                                                    divisions: 2,
                                                    color: widget.theme.onSurface.withValues(alpha: 0.05),
                                                  ),
                                                ),
                                              ),
                                              selectedComponent!.create(
                                                selectedComponent!.previewWidth, 
                                                selectedComponent!.previewHeight
                                              ).preview([])
                                            ],
                                          ),
                                        )
                                        : SizedBox(
                                          width: 200,
                                          child: Text(
                                            "This component don't have preview",
                                            style: widget.theme.bodyMedium
                                              .copyWith(color: widget.theme.onSurface),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                    ),
                                    // Bottom with button
                                    SizedBox(
                                      height: 60,
                                      width: 440,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // Add button
                                          Container(
                                            width: 110,
                                            height: 35,
                                            margin: const EdgeInsets.only(right: 10, bottom: 10),
                                            child: CustomTextButton(
                                              S.of(context).node_editor_add_sub_menu_add_button, 
                                              () {
                                                executeOnSelected();
                                                Navigator.pop(context);
                                              }, 
                                              false, 
                                              false
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                // If menu is shown with empty Components list
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(
                                      S.of(context).node_editor_add_sub_menu_no_nodes_found,
                                      style: widget.theme.titleLarge
                                      .copyWith(color: widget.theme.onSurface),
                                    ),
                                  ),
                                );
                              }
                            }
                          ),
                        ),
                        // Close menu button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Tooltip(
                                message: S.of(context).snackbar_close_button,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: widget.theme.primary,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded, 
                                    color: widget.theme.onPrimary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlugnUiComponentsAddMenuModel {
  String name;
  String description;

  IPluginUiComponent Function(double maxWidth, double maxHeight) create;

  PluginUiComponentType category;
  bool canCreatePreview;
  double previewWidth;
  double previewHeight;

  PlugnUiComponentsAddMenuModel({
    required this.name, 
    required this.description, 
    required this.create,
    required this.canCreatePreview,
    required this.previewWidth,
    required this.previewHeight,
    required this.category
  });
}

String _getPluginUiComponentTypeName(PluginUiComponentType category) {
  switch (category) {
    case PluginUiComponentType.basicComponent:
      return 'Basic';
    case PluginUiComponentType.button:
      return 'Buttons';
  }
}

IconData _getPluginUiComponentTypeIcon(PluginUiComponentType category) {
  switch (category) {
    case PluginUiComponentType.basicComponent:
      return Icons.crop_square_rounded;
    case PluginUiComponentType.button:
      return Icons.touch_app_rounded;
  }
}