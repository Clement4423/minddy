import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/plugin_ui_component_icon_icons.dart';
import 'package:minddy/system/utils/search_text_formatter.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/utils/ui_updater.dart';

class SelectIconSubMenu extends StatefulWidget {
  const SelectIconSubMenu({
    super.key, 
    required this.theme, 
    this.selectedIcon, 
    this.customList, 
    required this.onSelected
  });

  final StylesGetters theme;
  final IconInfo? selectedIcon;
  final List<IconInfo>? customList;
  final Function(IconInfo) onSelected;

  @override
  State<SelectIconSubMenu> createState() => _SelectIconSubMenuState();
}

class _SelectIconSubMenuState extends State<SelectIconSubMenu> {

  void _search() {
    String formatedQuery = SearchTextFormatter.format(query);

    if (formatedQuery.isEmpty) {
      iconsToShow = widget.customList ?? PluginUiComponentIconIcons.icons;
    } else {
      iconsToShow = (widget.customList ?? PluginUiComponentIconIcons.icons).where((icon) {
        String formatedTag = SearchTextFormatter.format(icon.tags.join(', '));
        String formatedCategory = SearchTextFormatter.format(icon.category);
        return formatedTag.contains(formatedQuery) || formatedCategory.contains(formatedQuery);
      }).toList();
    }
  }

  List<IconInfo> iconsToShow = [];

  String query = '';
  UiUpdater clearTextUpdater = UiUpdater();
  UiUpdater resultUpdater = UiUpdater();

  @override
  void initState() {
    iconsToShow = widget.customList ?? PluginUiComponentIconIcons.icons;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.theme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          SizedBox(
            width: 600,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Select an icon',
                      style: widget.theme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                    ),
                  )
                ),
                SizedBox(
                  height: 70,
                  width: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: widget.theme.onPrimary)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextSelectionTheme(
                            data: TextSelectionThemeData(
                              selectionColor: DefaultAppColors.blue.color.withValues(alpha: 0.8)
                            ),
                            child: TextField(
                              key: UniqueKey(),
                              controller: TextEditingController(text: query),
                              onChanged: (value) {
                                query = value;
                                clearTextUpdater.update();
                                _search();
                                resultUpdater.update();
                              },
                              cursorColor: widget.theme.onPrimary,
                              autofocus: true,
                              style: widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                border: InputBorder.none,
                                hintText: "${S.of(context).articles_search}..."
                              ),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: clearTextUpdater,
                          builder: (context, child) {
                            return MouseRegion(
                              key: UniqueKey(),
                              cursor: query.isNotEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
                              child: GestureDetector(
                                onTap: () {
                                  if (query.isNotEmpty) {
                                    setState(() {
                                      query = '';
                                      _search();
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    child: Icon(key: UniqueKey(), query.isNotEmpty ? Icons.close_rounded : Icons.search_rounded, color: widget.theme.onPrimary),
                                  ),
                                ),
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 600,
            height: 330,
            child: AnimatedBuilder(
              animation: resultUpdater,
              builder: (context, child) {
                Map<String, List<IconInfo>> iconsPerCategory = groupIconsByCategory(iconsToShow);
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                  ),
                  child: ListView(
                    children: createLists(context, iconsPerCategory, widget.theme, widget.selectedIcon, widget.onSelected)
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> createLists(BuildContext context, Map<String, List<IconInfo>> iconsPerCategory, StylesGetters theme, IconInfo? selectedIcon, Function(IconInfo) onSelected) {
  List<Widget> widgets = [];

  if (iconsPerCategory.isEmpty) {
    return widgets;
  } 

  for (MapEntry entry in iconsPerCategory.entries) {
    final icons = entry.value as List<IconInfo>;
    final rows = (icons.length / 8).ceil();

    Widget widget = SizedBox(
      width: 600,
      height: (rows * 70) + 20 + 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 500,
              height: 20,
              child: Text(
                entry.key,
                style: theme.bodySmall.copyWith(color: theme.onPrimary.withAlpha(120)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: icons.map((icon) {
              bool isSelected = selectedIcon != null && icon.iconId == selectedIcon.iconId;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    onSelected(icon);
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? theme.secondary.withAlpha(120) : theme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon.icon,
                        color: isSelected ? theme.onSecondary : theme.onPrimary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );

    widgets.add(widget);
  }
  return widgets;
}

Map<String, List<IconInfo>> groupIconsByCategory(List<IconInfo> icons) {
  final Map<String, List<IconInfo>> grouped = {};

  for (final icon in icons) {
    grouped.putIfAbsent(icon.category, () => []);
    grouped[icon.category]!.add(icon);
  }

  return grouped;
}