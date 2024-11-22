class CustomDatePickerResult {
  final List<DateTime> selectedDates;

  CustomDatePickerResult(this.selectedDates);

  @override
  String toString() {
    return selectedDates.map((date) => date.toIso8601String()).toString();
  }
}

