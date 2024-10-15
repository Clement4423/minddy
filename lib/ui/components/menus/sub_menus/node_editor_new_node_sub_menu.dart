import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/node_widget_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/nodes/logic/node_data_models.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet_side_panel_variable_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeEditorNewNodeSubMenuNodesUpdater extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class NodeEditorNewNodeSubMenu extends StatefulWidget {
  const NodeEditorNewNodeSubMenu({super.key, required this.onSelected, required this.nodesToShow, required this.theme, required this.onClosed, required this.autosearch});

  final List<NodeEditorNewNodeSubMenuNodeModel> nodesToShow;

  final Function(INodeWidget?) onSelected;
  final Function onClosed;
  final bool autosearch;

  final StylesGetters theme;

  @override
  State<NodeEditorNewNodeSubMenu> createState() => _NodeEditorNewNodeSubMenuState();
}

class _NodeEditorNewNodeSubMenuState extends State<NodeEditorNewNodeSubMenu> {

  bool isSearching = false;

  NodeEditorNewNodeSubMenuNodeModel? selectedNode;

  void search(String query) {
    String transformedQuery = SearchTextFormatter.format(query);
    if (transformedQuery.isEmpty) {
      nodesList = widget.nodesToShow;
    } else {
      nodesList = widget.nodesToShow.where((node) {
        String transformedName = SearchTextFormatter.format(node.name);
        String transformedDescription = SearchTextFormatter.format(node.description);
        String transformedCategory = SearchTextFormatter.format(_getNodeCategoryTranslatedName(node.category));

        return transformedName.contains(transformedQuery) 
          || transformedCategory.contains(transformedQuery)
          || transformedDescription.contains(transformedQuery);
      }).toList();
    }
    if (!nodesList.contains(selectedNode) && nodesList.isNotEmpty) {
      selectedNode = nodesList.firstOrNull;
    }
    updater.notify();
  }

  List<Widget> _buildNodeCategoryList() {
    // Group nodes by category
    Map<NodeCategory, List<NodeEditorNewNodeSubMenuNodeModel>> categorizedNodes = {};
    for (var node in nodesList) {
      categorizedNodes.putIfAbsent(node.category, () => []).add(node);
    }

    // Build a list of Widgets
    List<Widget> nodeWidgets = [];
    categorizedNodes.forEach((category, nodes) {
      // Add category header
      nodeWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
          child: Text(
            _getNodeCategoryTranslatedName(category),
            style: widget.theme.bodySmall
              .copyWith(color: widget.theme.onSurface),
          ),
        ),
      );

      // Add nodes under this category
      for (var node in nodes) {
        nodeWidgets.add(
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedNode = node;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 4.0),
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color: node == selectedNode ? widget.theme.secondary : widget.theme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getNodeCategoryIcon(category), 
                      color: node == selectedNode 
                        ? widget.theme.onSecondary 
                        : widget.theme.onPrimary,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        node.name,
                        overflow: TextOverflow.ellipsis,
                        style: widget.theme.bodyMedium
                        .copyWith(
                          color: node == selectedNode ? widget.theme.onSecondary : widget.theme.onPrimary,
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

    if (nodeWidgets.isEmpty) {
      nodeWidgets.add(
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

    return nodeWidgets;
  }

  List<NodeEditorNewNodeSubMenuNodeModel> nodesList = [];

  NodeEditorNewNodeSubMenuNodesUpdater updater = NodeEditorNewNodeSubMenuNodesUpdater();

  FocusNode searchBarFocusNode = FocusNode();

  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    nodesList = widget.nodesToShow;
    selectedNode = nodesList.firstOrNull;
    if (widget.autosearch) {
      searchBarFocusNode.requestFocus();
    }
    super.initState();
  }

  void addFocusToSearchbar() {
    searchBarFocusNode.requestFocus();
  }

  void executeOnSelected() {
    if (selectedNode != null) {
      widget.onSelected(selectedNode?.create());
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
                  color: widget.theme.onPrimary.withOpacity(widget.theme.brightness == Brightness.light ? 1 : 0.2),
                  width: 0.5
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.theme.shadow.withOpacity(0.2),
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
                                          color: widget.theme.onPrimary.withOpacity(0.2),
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
                                          selectionColor: DefaultAppColors.blue.color.withOpacity(0.8)
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
                          // Nodes list
                          Expanded(
                            child: AnimatedBuilder(
                              animation: updater,
                              builder: (context, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ListView(
                                      children: _buildNodeCategoryList()
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
                              if (selectedNode != null) {
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
                                            // Node name
                                            Text(
                                              selectedNode!.name,
                                              style: widget.theme.titleLarge
                                              .copyWith(color: widget.theme.onSurface),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Node description
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                selectedNode!.description,
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
                                    // Body with inputs and outputs types
                                    SizedBox(
                                      width: 440,
                                      height: 200,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, bottom: 50),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  S.of(context).node_editor_add_sub_menu_types,
                                                  style: widget.theme.titleMedium
                                                  .copyWith(
                                                    color: widget.theme.onSurface, 
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  // Inputs
                                                  SizedBox(
                                                    width: 180,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                          Text(
                                                            S.of(context).node_editor_add_sub_menu_inputs_subtitle(selectedNode!.inputsTypes.length),
                                                            style: widget.theme.titleMedium
                                                              .copyWith(color: widget.theme.onSurface, fontWeight: FontWeight.w600,),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10),
                                                            child: Column(
                                                              children: [
                                                                if (selectedNode!.inputsTypes.isNotEmpty)
                                                                  ..._createIndexedInputsOutputsList(selectedNode!.inputsTypes, widget.theme)
                                                                else 
                                                                  Text(
                                                                    S.of(context).node_editor_add_sub_menu_none_input_output,
                                                                    style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
                                                                  )
                                                              ],
                                                            )
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  // Outputs
                                                  SizedBox(
                                                    width: 150,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                          Text(
                                                            S.of(context).node_editor_add_sub_menu_outputs_subtitle(selectedNode!.outputsTypes.length),
                                                            style: widget.theme.titleMedium
                                                              .copyWith(color: widget.theme.onSurface, fontWeight: FontWeight.w600),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10),
                                                            child: Column(
                                                              children: [
                                                                if (selectedNode!.outputsTypes.isNotEmpty)
                                                                  ..._createIndexedInputsOutputsList(selectedNode!.outputsTypes, widget.theme)
                                                                else 
                                                                  Text(
                                                                    S.of(context).node_editor_add_sub_menu_none_input_output,
                                                                    style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
                                                                  )
                                                              ],
                                                            )
                                                          )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Bottom with note and button
                                    SizedBox(
                                      height: 60,
                                      width: 440,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // Note
                                          if (selectedNode!.typesCanChange)
                                            Tooltip(
                                              message: S.of(context).node_editor_add_sub_menu_note,
                                              child: Container(
                                                padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
                                                width: 300,
                                                child: Text(
                                                  S.of(context).node_editor_add_sub_menu_note,
                                                  style: widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2
                                                ),
                                              ),
                                            ),
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
                                // If menu is shown with empty nodes list
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
                                message: S.of(context).snacbar_close_button,
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

class NodeEditorNewNodeSubMenuNodeModel {
  String name;
  String description;
  List<NodeDataType> inputsTypes;
  List<NodeDataType> outputsTypes;
  bool typesCanChange;

  NodeCategory category;

  INodeWidget Function() create;

  NodeEditorNewNodeSubMenuNodeModel({
    required this.name, 
    required this.description, 
    required this.inputsTypes, 
    required this.outputsTypes, 
    required this.category, 
    required this.create,
    required this.typesCanChange
  });
}

enum NodeCategory {
  math,
  logic,
  text,
  variable
}

String _getNodeCategoryTranslatedName(NodeCategory category) {
  switch (category) {
    case NodeCategory.math:
      return S.current.node_widgets_category_math;
    case NodeCategory.logic:
      return S.current.node_widgets_category_logic;
    case NodeCategory.text:
      return 'Text';
    case NodeCategory.variable:
      return S.current.node_widgets_category_variable;
  }
}

IconData _getNodeCategoryIcon(NodeCategory category) {
  switch (category) {
    case NodeCategory.math:
      return Icons.calculate_outlined;
    case NodeCategory.logic:
      return Icons.settings_outlined;
    case NodeCategory.text:
      return Icons.text_fields_rounded;
    case NodeCategory.variable:
      return Icons.waves_rounded;
  }
}

Color getCorrectColorBasedOnNodeDataType(NodeDataType type) {
  switch (type) {
    case NodeDataType.any:
      return DefaultAppColors.grey.color;
    case NodeDataType.number:
      return DefaultAppColors.mintGreen.color;
    case NodeDataType.string:
      return DefaultAppColors.lavender.color;
    case NodeDataType.boolean:
      return DefaultAppColors.peach.color;
    case NodeDataType.list:
      return DefaultAppColors.pink.color;
    case NodeDataType.color:
      return DefaultAppColors.lightPurple.color;
  }
}

List<Widget> _createIndexedInputsOutputsList(List<NodeDataType> types, StylesGetters theme) {
  
  return types.map((type) {    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: getCorrectColorBasedOnNodeDataType(type),
              borderRadius: BorderRadius.circular(4)
            ),
          ),
          Text(
             getCorrectNameBasedOnNodeDataType(type),
             style: theme.bodyMedium.copyWith(color: theme.onSurface),
          )
        ],
      ),
    );
  }).toList();
}