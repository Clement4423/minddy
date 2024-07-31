import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_bar.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_donut.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_element_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';
import 'package:minddy/ui/components/custom_components/dashed_line.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class _CustomChartHoverController extends ChangeNotifier {
  notify() {
    notifyListeners();
  }
}

class CustomChart extends StatefulWidget {
  const CustomChart({super.key, required this.controller});

  final CustomChartController controller;

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {

  bool isHovering = false;
  final _CustomChartHoverController _hoverController = _CustomChartHoverController();

  double getBarWidth() {
    double width = (widget.controller.width / widget.controller.allNumbers.length) / 1.2;
    double maxWidth = widget.controller.width / 5;

    if (width > maxWidth) {
      return maxWidth;
    } else {
      return width;
    }
  }

  double getPadding() {
    double totalBarWidth = getBarWidth() * widget.controller.allNumbers.length;
    double remainingSpace = widget.controller.width - totalBarWidth;
    double padding = (remainingSpace / (widget.controller.allNumbers.length * 2)) / 2;
    return padding > remainingSpace ? 0.0 : padding;
  }

  double getHeight(num data) {
    if (widget.controller.needToBeHorizontalBars()) {
      return getBarWidth();
    } else {
      return widget.controller.getSizeFor(data) ?? 0;
    }
  }

  double getWidth(num data) {
    if (widget.controller.needToBeHorizontalBars()) {
      return widget.controller.getSizeFor(data) ?? 0;
    } else {
      return getBarWidth();
    }
  }

  List<Widget> buildBarsAsStacked(StylesGetters theme) {
    List<CustomChartDataMultiple> content = widget.controller.getDataAsMultiples();

    List<Widget> columns = [];

    for (CustomChartDataMultiple part in content) {
      num total = sum(part.values.map((e) => e.value as num).toList());

      part.values.sort((x, y) {
        num a = x.value as num;
        num b = y.value as num;

        return a.compareTo(b);
      });

      List<Widget> data = part.values.reversed.map((data) {
        return CustomChartBar(
          color: widget.controller.colorPalette[part.values.indexOf(data)],
          theme: theme, 
          unit: widget.controller.getUnit(),
          secondaryValueForTooltip: total,
          height: getHeight(data.value),
          width: getWidth(data.value),
          isHorizontal: widget.controller.needToBeHorizontalBars(),
          name: data.title,
          shouldOffsetUp: widget.controller.containsNegativeValue,
          value: data.value,
          borderRadius: 
            part.values.indexOf(data) == 0 
            ? BorderRadius.only(
              bottomLeft: Radius.circular(getBarWidth() / 5), 
              bottomRight: Radius.circular(getBarWidth() / 5)
            )
            : part.values.indexOf(data) == part.values.length - 1
              ? BorderRadius.only(
                topLeft: Radius.circular(getBarWidth() / 5),
                topRight: Radius.circular(getBarWidth() / 5)
            )
            : BorderRadius.zero,
        );
      }).toList();

      columns.add(
        widget.controller.needToBeHorizontalBars() 
        ? Row(
          crossAxisAlignment: widget.controller.containsNegativeValue 
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: data
        )
        : Column(
          crossAxisAlignment: widget.controller.containsNegativeValue 
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: data
        )
      );
    }
    return columns;
  }

  List<Widget> buildBarsAsMultiples(StylesGetters theme) {
    List<CustomChartDataMultiple> content = widget.controller.getDataAsMultiples();

    List<Widget> rows = [];

    for (CustomChartDataMultiple part in content) {
      List<Widget> data = part.values.map((data) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.controller.needToBeHorizontalBars() 
              ? 0
              : part.values.length > 1 
                ? getPadding()
                : 0,
            vertical: widget.controller.needToBeHorizontalBars() 
              ? part.values.length > 1 
                ? getPadding()
                : 0
              : 0,
          ),
          child: CustomChartBar(
            color: widget.controller.colorPalette[part.values.indexOf(data)],
            theme: theme,
            unit: widget.controller.getUnit(),
            isHorizontal: widget.controller.needToBeHorizontalBars(), 
            shouldOffsetUp: widget.controller.containsNegativeValue,
            height: getHeight(data.value),
            width: getWidth(data.value),
            name: data.title,
            value: data.value
          ),
        );
      }).toList();

      rows.add(
        widget.controller.needToBeHorizontalBars() 
        ? Column(
          crossAxisAlignment: widget.controller.containsNegativeValue 
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: data
        )
        : Row(
          crossAxisAlignment: widget.controller.containsNegativeValue 
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: data
        )
      );
    }
    return rows;
  }

  List<CustomChartBar> buildBarsAsUniques(StylesGetters theme) {
    List<CustomChartData> content = widget.controller.getDataAsUnique();

    List<CustomChartBar> bars = [];

    for (CustomChartData data in content) {
      bars.add(
        CustomChartBar(
          color: DefaultAppColors.blue.color, 
          theme: theme, 
          unit: widget.controller.getUnit(),
          name: data.title,
          isHorizontal: widget.controller.needToBeHorizontalBars(),
          shouldOffsetUp: widget.controller.containsNegativeValue,
          height: getHeight(data.value),
          width: getWidth(data.value),
          value: data.value
        )
      );
    } 

    return bars;
  }

  List<Widget> getTitlesAsStacked(StylesGetters theme) {
    List<CustomChartDataMultiple> content = widget.controller.getDataAsMultiples();

    List<Widget> titles = [];

    for (CustomChartDataMultiple data in content) {
      titles.add(
        SizedBox(
          width: widget.controller.needToBeHorizontalBars()
            ? null
            : getBarWidth(),
          height: widget.controller.needToBeHorizontalBars()
            ? getBarWidth()
            : null,
          child: CustomTooltip(
            message: data.title ?? '',
            child: Text(
              data.title ?? S.current.projects_module_spreadsheet_value_unnamed,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: widget.controller.needToBeHorizontalBars()
                ? 1
                : 2, 
              style: theme.bodyMedium.copyWith(color: theme.onPrimary, fontSize: getBarWidth() > 14 ? 14 : getBarWidth())
            ),
          )
        )
      );

    }
    return titles;
  }

  List<Widget> getTitlesAsMultiples(StylesGetters theme) {
    List<CustomChartDataMultiple> content = widget.controller.getDataAsMultiples();

    List<Widget> rows = [];

    for (CustomChartDataMultiple part in content) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.controller.needToBeHorizontalBars() 
                ? null
                : (getBarWidth() * part.values.length) + (part.values.length > 1 ? getPadding() * part.values.length : 0),
              height: widget.controller.needToBeHorizontalBars() 
                ? (getBarWidth() * part.values.length) + (part.values.length > 1 ? getPadding() * part.values.length : 0)
                : null,
              child: Center(
                child: CustomTooltip(
                  message: part.title ?? '',
                  child: Text(
                    part.title ?? S.current.projects_module_spreadsheet_value_unnamed,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: widget.controller.needToBeHorizontalBars()
                      ? 1
                      : 2, 
                    style: theme.bodyMedium.copyWith(color: theme.onPrimary, fontSize: getBarWidth() > 14 ? 14 : getBarWidth())
                  ),
                ),
              ),
            )
          ],
        )
      );
    }
    return rows;
  }

  List<Widget> getTitlesAsUniques(StylesGetters theme) {
    List<CustomChartData> content = widget.controller.getDataAsUnique();

    List<Widget> titles = [];

    for (CustomChartData data in content) {
      titles.add(
        SizedBox(
          width: widget.controller.needToBeHorizontalBars()
            ? null
            : getBarWidth(),
          height: widget.controller.needToBeHorizontalBars()
            ? getBarWidth()
            : null,
          child: CustomTooltip(
            message: data.title ?? '',
            child: Text(
              data.title ?? S.current.projects_module_spreadsheet_value_unnamed,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: widget.controller.needToBeHorizontalBars()
                ? 1
                : 2, 
              style: theme.bodyMedium.copyWith(color: theme.onPrimary, fontSize: getBarWidth() > 14 ? 14 : getBarWidth())
            ),
          )
        )
      );

    }
    return titles;
  }

  List<Widget> buildTitles(StylesGetters theme) {
    List<Widget> titles = [];

    switch (widget.controller.type) {
      case CustomChartType.barSingle:
        titles = getTitlesAsUniques(theme);
        break;
      case CustomChartType.donut:
        titles = getTitlesAsUniques(theme);
        break;
      case CustomChartType.barMultiples:
        titles = getTitlesAsMultiples(theme);
        break;
      case CustomChartType.barStacked:
        titles = getTitlesAsStacked(theme);
        break;
    }
    return titles;
  }

  Widget buildBars(StylesGetters theme) {
    if (widget.controller.needToBeHorizontalBars()) {
      return SizedBox(
        width: widget.controller.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: widget.controller.containsNegativeValue 
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: _getBars(theme)
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: widget.controller.containsNegativeValue 
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: _getBars(theme),
      );
    }
    
  }

  List<Widget> _getBars(StylesGetters theme) {
    switch (widget.controller.type) {
      case CustomChartType.barSingle:
        return buildBarsAsUniques(theme);
      case CustomChartType.donut:
        return buildBarsAsUniques(theme);
      case CustomChartType.barMultiples:
        return buildBarsAsMultiples(theme);
      case CustomChartType.barStacked:
        return buildBarsAsStacked(theme);
    }
  }

  List<Widget> buildIndicators() {
  num lowestNegativeValue = widget.controller.getLowestNegativeValue() ?? 0;
  num midPoint = widget.controller.getMidPoint() ?? 0;
  num topPoint = widget.controller.containsNegativeValue 
    ? flipSign(widget.controller.getLowestNegativeValue() ?? 0)
    : widget.controller.getTopPoint() ?? 0;

  num secondValue = midPoint == 0 
    ? lowestNegativeValue / 2
    : midPoint / 2;
  num fourthValue = midPoint == 0 
    ? topPoint / 2
    : topPoint - (midPoint / 2);

  List<num> values = [
    lowestNegativeValue,
    secondValue,
    midPoint,
    fourthValue,
    topPoint
  ];

  return List.generate(5, (index)  {
    String value = formatCalculation('${values[index].toString().replaceAll('.', ',')}${widget.controller.getUnit() ?? ''}');
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: widget.controller.needToBeHorizontalBars() ? 0 : 10),
          child: Text(
            value.replaceAll(' ', '').length > 10 
              ? formatCalculation(value.replaceAll(' ', '').substring(0, 7).padRight(10, '.'))
              : value,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }).reversed.toList();
}

  Widget buildVerticalGrid(StylesGetters theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(5, (index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashedLine(
              color: theme.onPrimary.withOpacity(0.5),
              dashWidth: widget.controller.width / (widget.controller.height / 10), 
              dashSpace: (widget.controller.width / (widget.controller.height / 10)) / 2, 
              lineHeight: widget.controller.height,
            ),
          ],
        ))
      ],
    );
  }

  Widget buildHoriziontalGrid(StylesGetters theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(5, (index) => Row(
          children: [
            DashedLine(
              color: widget.controller.gridColor ?? theme.onPrimary.withOpacity(0.3),
              dashWidth: widget.controller.width / (widget.controller.height / 10), 
              dashSpace: (widget.controller.width / (widget.controller.height / 10)) / 2, 
              lineWidth: widget.controller.width
            )
          ],
        ))
      ],
    );
  }

  Widget buildGrid(StylesGetters theme) {
    if (widget.controller.needToBeHorizontalBars()) {
      return buildVerticalGrid(theme);
    } else {
      return buildHoriziontalGrid(theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Row(
      children: widget.controller.type == CustomChartType.donut 
      ? [
        DonutChart(
          values: widget.controller.getDataAsUnique(),
          colorPalette: widget.controller.colorPalette,
          unit: widget.controller.getUnit(),
          innerRadiusRatio: 0.8,
          innerCircleColor: theme.surface,
          width: widget.controller.width,
          height: widget.controller.height
        )
      ]
      : [
        // Grid container
        SizedBox(
          height: widget.controller.height + 40,
          child: Row(
            children: [
              // Values indicators
              Container(
                height: widget.controller.height,
                margin: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [            
                    if (widget.controller.needToBeHorizontalBars()) ...buildTitles(theme) else ...buildIndicators()
                  ],
                ),
              ),
              Column(
                children: [
                  MouseRegion(
                    onEnter: (event) {
                      isHovering = true;
                      _hoverController.notify();
                    },
                    onExit: (event) {
                      isHovering = false;
                      _hoverController.notify();
                    },
                    child: SizedBox(
                      width: widget.controller.width,
                      height: widget.controller.height,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          // Grid
                          buildGrid(theme),
                          
                          // Data
                          SizedBox(
                            height: widget.controller.height,
                            width: widget.controller.width,
                            child: buildBars(theme),
                          ),
                          // Scale up button
                          AnimatedBuilder(
                            animation: _hoverController,
                            builder: (context, child) {
                              if (isHovering && widget.controller.canBeExtended) {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: TweenAnimationBuilder(
                                    tween: Tween<double>(
                                      begin: isHovering ? 0.8 : 0.9,
                                      end: isHovering ? 0.9 : 0.8,
                                    ),
                                    duration: const Duration(milliseconds: 100),
                                    builder: (context, size, child) {
                                      return Transform.scale(
                                        scale: size,
                                        child: IconButton(
                                          onPressed: () {
                                            double screenWidth = MediaQuery.of(context).size.width;
                                            double screenHeight = MediaQuery.of(context).size.height;
                                            showSubMenu(
                                              context, ClipRRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                                                  child: Container(
                                                    width: screenWidth * 0.8,
                                                    height: screenHeight * 0.8,
                                                    decoration: BoxDecoration(
                                                      color: theme.primaryContainer,
                                                      borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    child: ListView(
                                                      scrollDirection: Axis.horizontal,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                            child: CustomChart(
                                                            controller: CustomChartController(
                                                              width: screenWidth * 0.7, 
                                                              height: screenHeight * 0.7, 
                                                              type: widget.controller.type, 
                                                              content: widget.controller.content,
                                                              canBeExtended: false,
                                                              unit: widget.controller.unit,
                                                              gridColor: widget.controller.gridColor
                                                            )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            );
                                          },
                                          tooltip: S.of(context).custom_chart_grid_extend_chart,
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                                          ),
                                          icon: Icon(CupertinoIcons.arrow_up_left_arrow_down_right, color: widget.controller.gridColor != null ? widget.controller.gridColor!.withOpacity(1) : theme.onPrimary)
                                          ),
                                      );
                                    }
                                  )
                                  );
                              } else {
                                return const SizedBox();
                              }
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                  // Bottom with titles
                  SizedBox(
                    height: 40,
                    width: widget.controller.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.controller.needToBeHorizontalBars()) ...buildIndicators().reversed else ...buildTitles(theme)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
