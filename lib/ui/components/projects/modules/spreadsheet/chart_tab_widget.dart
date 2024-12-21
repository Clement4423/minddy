import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';
import 'package:minddy/ui/theme/theme.dart';

class ChartTabWidget extends StatefulWidget {
  const ChartTabWidget({
    super.key, 
    required this.tabId,
    required this.chartType,
    required this.isSelected,
    required this.navigateToTab,
    required this.canBeDeleted,
    required this.renameTab,
    required this.deleteTab,
    required this.theme,
    this.tabTitle
  });

  final int tabId;
  final CustomChartType chartType;
  final bool isSelected;
  final String? tabTitle;
  final Function(int) navigateToTab;
  final bool canBeDeleted;
  final Function(int, String) renameTab;
  final StylesGetters theme;
  final Function(int) deleteTab;

  @override
  State<ChartTabWidget> createState() => __ChartTabWidgetState();
}

class __ChartTabWidgetState extends State<ChartTabWidget> {

  bool isHovering = false;
  bool isInEditMode = false;
  FocusNode focusNode = FocusNode();
  String title = '';

  @override
  void initState() {
    title = widget.tabTitle ?? '';
    super.initState();
  }

  IconData _getIcon() {
    if (widget.chartType == CustomChartType.donut) {
      return CupertinoIcons.chart_pie;
    } else {
      return CupertinoIcons.chart_bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await widget.navigateToTab(widget.tabId);
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 40,
          width: 150,
          padding: const EdgeInsets.only(left: 10, right: 5),
          decoration: BoxDecoration(
            color: widget.isSelected 
              ? widget.theme.secondary 
              : isHovering 
                ? widget.theme.primary.withValues(alpha: 0.8)
                : widget.theme.primary,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  _getIcon(), 
                  color: widget.isSelected 
                    ? widget.theme.onSecondary 
                    : widget.theme.onPrimary
                  ),
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      isInEditMode = true;
                      focusNode.requestFocus();
                    });
                  },
                  onTapDown: (details) async {
                    await widget.navigateToTab(widget.tabId);
                  },
                  child: TextField(
                    controller: TextEditingController(text: widget.tabTitle),
                    onChanged: (value) {
                      title = value;
                    },
                    onEditingComplete: () async {
                      await widget.renameTab(widget.tabId, title);
                      setState(() {
                        isInEditMode = false;
                      });
                    },
                    mouseCursor: isInEditMode 
                      ? SystemMouseCursors.text
                      : SystemMouseCursors.click,
                    cursorColor: widget.isSelected 
                      ? widget.theme.onSecondary 
                      : widget.theme.onPrimary,
                    focusNode: focusNode,
                    style: widget.theme.bodyMedium
                    .copyWith(
                      color: widget.isSelected 
                        ? widget.theme.onSecondary 
                        : widget.theme.onPrimary, 
                    ),
                    onTapOutside: (event) async {
                      await widget.renameTab(widget.tabId, title);
                      focusNode.unfocus();
                      setState(() {
                        isInEditMode = false;
                      });
                    },
                    readOnly: !isInEditMode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 6),
                      hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                      hintStyle: widget.theme.bodyMedium
                      .copyWith(
                        color: widget.isSelected 
                          ? widget.theme.onSecondary 
                          : widget.theme.onPrimary, 
                      ),
                    ),
                  )
                )
              ),
              if (isHovering && widget.canBeDeleted)
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    onPressed: () async {
                      await widget.deleteTab(widget.tabId);
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStatePropertyAll(widget.theme.primaryContainer)
                    ),
                    tooltip: S.of(context).snackbar_delete_button,
                    icon: Center(
                      child: Icon(
                        CupertinoIcons.xmark, 
                        color: widget.isSelected 
                          ? widget.theme.onSecondary 
                          : widget.theme.onPrimary, 
                        size: 16
                      )
                    )
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

// TODO : Gérer le unfocus au hover