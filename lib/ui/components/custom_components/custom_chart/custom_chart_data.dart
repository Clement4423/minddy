class CustomChartData {
  dynamic value;

  /// The title of the value 
  /// 
  /// If null, it will be replaced by the value itself
  String? title;

  CustomChartData({
    required this.value,
    this.title
  });
}

class CustomChartDataMultiple {
  List<CustomChartData> values;
  String? title;

  CustomChartDataMultiple({
    required this.values,
    this.title
  });
}