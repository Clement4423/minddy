import 'package:flutter/material.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_colors.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';

class CustomChartController extends ChangeNotifier {
  final double width;
  final double height;
  final CustomChartType type;

  final List<List<CustomChartData>> content;

  List<num> allNumbers = [];

  List<num> negativeNumbers = [];
  bool containsNegativeValue = false;
  
  num topPoint = 0;
  double sizeRatio = 0;

  final Color? gridColor;
  final String? unit;

  final List<Color>? colors;

  late final List<Color> colorPalette;

  final bool canBeExtended;

  CustomChartController({
    required this.width,
    required this.height,
    required this.type,
    required this.content,
    this.canBeExtended = true,
    this.colors,
    this.gridColor,
    this.unit
  }) {
    allNumbers = _getAllNumbersFromContent();

    topPoint = getTopPoint() ?? 0;

    num totalHighestNumbers = topPoint;

    containsNegativeValue = _isListContainingNegativeValue();
    if (containsNegativeValue) {
      totalHighestNumbers += flipSign(getLowestNegativeValue() ?? 0);
    }

    colorPalette = colors ?? _getColorPalette();

    if (totalHighestNumbers != 0) {
      if (needToBeHorizontalBars()) {
        sizeRatio = width/totalHighestNumbers;
      } else {
        sizeRatio = height/totalHighestNumbers;
      }
    }
  }

  List<Color> _getColorPalette() {
    switch (type) {
      case CustomChartType.donut:
        return generateCategoricalPalette(allNumbers.length);
      case CustomChartType.barMultiples:
        return generateSequentialPalette(getDataAsMultiples().first.values.length);
      case CustomChartType.barStacked:
        return generateSequentialPalette(getDataAsMultiples().first.values.length);
      default: 
        return [];
    }
  }

  bool needToBeHorizontalBars() {
    if (width / allNumbers.length < 20) {
      return true;
    }
    return false;
  }

  String? getUnit() {
    if (unit == null) {
      return null;
    }

    if (unit == '%') {
      return '%';
    } else {
      RegExp currencyRegex = RegExp(r'^(\$|£|€|¥)|(\$|£|€|¥)$');
      Match? currencyMatch = currencyRegex.firstMatch(unit!);
      String? currency = currencyMatch?.group(1) ?? currencyMatch?.group(2);
      
      return currency;
    }
  }

  bool _isListContainingNegativeValue() {
    for (num number in allNumbers) {
      if (number.isNegative) {
        negativeNumbers.add(number);
      }
    }
    
    return negativeNumbers.isNotEmpty;
  }

  double? getSizeFor(num data) {
    if (sizeRatio != 0) {
      double size = data * sizeRatio;
      if (size.isNegative) {
        size = flipSign(size).toDouble();
      }
      return size;
    } else {
      return null;
    }
  }

  List<num> _getAllNumbersFromContent() {
    List<num> numbers = [];
    for (List<CustomChartData> dataList in content) {
      if (type == CustomChartType.barStacked) {      
        numbers.add(sum(_getAllNumbersFromList(dataList)));
      } else {
        numbers.addAll(_getAllNumbersFromList(dataList));
      }
    }

    return numbers;
  }

  List<CustomChartData> getDataAsUnique() {
    List<CustomChartData> data = [];
    for (List<CustomChartData> dataList in content) {      
      data.addAll(dataList);
    }
    return data;
  }

  List<CustomChartDataMultiple> getDataAsMultiples() {
    List<CustomChartDataMultiple> data = [];
    for (List<CustomChartData> dataList in content) {
      data.add(CustomChartDataMultiple(values: dataList));
    }
    return data;
  }  

  double getPercentageOf(num data) {
    num total = sum(allNumbers);

    if (total != 0) {
      return data/total;
    } else {
      return 0;
    }
  }

  List<num> _getAllNumbersFromList(List<CustomChartData> dataList) {
    List<num> numbers = [];
    for (CustomChartData data in dataList) {
      if (data.value is num) {
        numbers.add(data.value);
      }
    }
    return numbers;
  }


  int? getMidPoint() {
    if (containsNegativeValue) {
      return 0;
    }
    int max = getTopPoint() ?? 0;
    if (max != 0) {
      return (max / 2).round();
    } else {
      return null;
    }
  }

  int? getTopPoint() {
    num max = maximum(allNumbers);
    if (max != 0) {
      return roundToCompleteInteger((max * 1.8).round());
    } else {
      return null;
    }
  }

  int? getLowestNegativeValue() {
    if (!containsNegativeValue) {
      return null;
    }
    num min = minimum(negativeNumbers);

    if (min != 0) {
      return roundToCompleteInteger((min * 2).round());
    } else {
      return null;
    }
  }

  int roundToCompleteInteger(int number) {
    int magnitude = 1;

    while (number ~/ magnitude >= 10 || number ~/ magnitude <= -10) {
        magnitude *= 10;
    }

    int remainder = number.abs() % magnitude;
    int roundedNumber = number - remainder;

    return roundedNumber;
  }
}