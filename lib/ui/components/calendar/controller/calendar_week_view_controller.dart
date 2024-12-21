import 'package:flutter/cupertino.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/calendar/calendar_bottom_menu_controller.dart';

class CalendarWeekViewController extends ChangeNotifier {
  late CalendarBottomMenuController calendarBottomMenuController = CalendarBottomMenuController(calendarWeekViewController: this);

  CalendarWeekViewController({this.selectedWeek = 1, this.selectedYear = 2024}) {
    if (selectedWeek == 1 && selectedYear == 2024) {
      setActualWeekAndYear();
    }
  }

  int selectedWeek = 1;
  int selectedYear = 2024;

  CalendarEvent? selectedEvent;
  GlobalKey bottomMenuKey = GlobalKey();

  setActualWeekAndYear() {
   DateTime now = DateTime.now();
   selectedWeek = _getWeekOfYear(now);
   selectedYear = now.year;
  }

  int _getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(firstDayOfYear).inDays;
    return ((daysSinceStartOfYear + firstDayOfYear.weekday) / 7).ceil();
  }

  update() {
    notifyListeners();
  }

  void selectNewWeek(int newWeek, int newYear) {
    selectedWeek = newWeek;
    selectedYear = newYear;
    notifyListeners();
  }
}