import 'package:flutter/material.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_colors.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';

class CustomChartController extends ChangeNotifier {
  /// Prepare 80 more pixels in space for values indicators
  final double width;
  /// Prepare 40 more pixels in space for value titles
  final double height;
  final CustomChartType type;

  final List<CustomChartDataMultiple> content;

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

    num totalHighestNumbers = getExtremeValue();

    colorPalette = colors != null ? colors! : isChartEmpty() ? [] : _getColorPalette();

    if (totalHighestNumbers != 0) {
      if (needToBeHorizontalBars()) {
        sizeRatio = (width - 80) / totalHighestNumbers;
      } else {
        sizeRatio = (height - 40) / totalHighestNumbers;
      }
    }
  }

  List<Color> _getColorPalette() {
    switch (type) {
      case CustomChartType.donut:
        return generateCategoricalPalette(allNumbers.length);
      case CustomChartType.barMultiples:
        return generateSequentialPalette(getDataAsMultiples().first.values.length, Colors.blue[100]!, Colors.blue[800]!);
      case CustomChartType.barStacked:
        return generateSequentialPalette(getDataAsMultiples().first.values.length, Colors.blue[100]!, Colors.blue[800]!);
      default: 
        return [];
    }
  }

  Map<int, int> getOriginalIndicesMapping(List<CustomChartData> sortedList, List<CustomChartData> originalList) {
    Map<int, int> indexMapping = {};
    for (var i = 0; i < sortedList.length; i++) {
      indexMapping[i] = originalList.indexOf(sortedList[i]);
    }
    return indexMapping;
  }

  num getExtremeValue() {
    topPoint = getTopPoint() ?? 0;

    num totalHighestNumbers = topPoint;

    containsNegativeValue = _isListContainingNegativeValue();
    if (containsNegativeValue) {
      totalHighestNumbers = flipSign(getLowestNegativeValue() ?? 0);
      if (totalHighestNumbers < topPoint) {
        totalHighestNumbers = topPoint;
      }
    }

    return totalHighestNumbers;
  }

  bool isChartEmpty() {
    if (content.isEmpty) {
      return true;
    } else {
      for (CustomChartDataMultiple part in content) {
        if (part.values.isNotEmpty) {
          return false;
        }
      }
    } 

    return true;
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
      double size = (data * sizeRatio);
      if (size.isNegative) {
        size = flipSign(size).toDouble();
      }
      return containsNegativeValue ? size / 2 : size;
    } else {
      return null;
    }
  }

  List<num> _getAllNumbersFromContent() {
    List<num> numbers = [];
    for (CustomChartDataMultiple dataList in content) {
      if (type == CustomChartType.barStacked) {      
        numbers.add(sum(_getAllNumbersFromList(dataList.values)));
      } else {
        numbers.addAll(_getAllNumbersFromList(dataList.values));
      }
    }

    return numbers;
  }

  List<CustomChartData> getDataAsUnique() {
    List<CustomChartData> data = [];
    for (CustomChartDataMultiple dataList in content) { 
      data.addAll(dataList.values);
    }

    data = sortDataList(data);

    return data;
  }

  List<CustomChartDataMultiple> getDataAsMultiples() {
    return content;
  } 

  List<CustomChartData> sortDataList(List<CustomChartData> list) {
    list.sort((a, b) {
      return a.value.compareTo(b.value);
    });

    return list;
  }

  List<num> _getAllNumbersFromList(List<CustomChartData> dataList) {
    List<num> numbers = [];
    for (CustomChartData data in dataList) {
      numbers.add(data.value);
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
      int maxRounded = roundToCompleteInteger((max * 1.8).round());
      if (maxRounded < max) {
        return roundToCompleteInteger((max * 2).round());
      }
      return maxRounded;
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