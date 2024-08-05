class CustomChartData {
  num value;

  /// The title of the value 
  /// 
  /// If null, it will be replaced by the value itself
  String? title;

  CustomChartData({
    required this.value,
    this.title
  }) {
    if (title != null && title!.isEmpty) {
      title == null;
    }
  }
}

class CustomChartDataMultiple {
  List<CustomChartData> values;
  String? title;

  CustomChartDataMultiple({
    required this.values,
    this.title
  }) {
    if (title != null && title!.isEmpty) {
      title == null;
    }
  }
}