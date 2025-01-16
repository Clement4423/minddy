import 'package:flutter/cupertino.dart';
import 'package:minddy/system/calendar/app_calendar.dart';
import 'package:minddy/system/model/calendar.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/calendar/calendar_bottom_menu_controller.dart';
import 'package:week_of_year/date_week_extensions.dart';

class CalendarWeekViewController extends ChangeNotifier {
  late CalendarBottomMenuController calendarBottomMenuController = CalendarBottomMenuController(calendarWeekViewController: this);

  List<Calendar> calendars = [];
  List<CalendarEvent> events = [];

  int? highlightedEventID;

  void resetHighligthedEvent() {
    highlightedEventID = null;
  }

  Future<void> getCalendarsAndEvents() async {
    calendars.clear();
    events.clear();

    calendars = await AppCalendar.getCalendars();
    
    for (Calendar calendar in calendars) {
      events.addAll(calendar.events);
    }
  }

  CalendarWeekViewController({this.selectedWeek = 1, this.selectedYear = 2024}) {
    if (selectedWeek == 1 && selectedYear == 2024) {
      setActualWeekAndYear();
    }
  }

  int selectedWeek = 1;
  int selectedYear = 2024;

  CalendarEvent? selectedEvent;
  GlobalKey bottomMenuKey = GlobalKey();

  bool isBottomMenuClosed = true;

  void setIsBottomMenuClosed(bool value) {
    isBottomMenuClosed = value;
  } 

  setActualWeekAndYear() {
   DateTime now = DateTime.now();
   selectedWeek = getWeekNumber(now);
   selectedYear = getISOYear(now);
  }

  int getWeekNumber(DateTime date) {
    return date.weekOfYear;
  }

  int getISOYear(DateTime date) {
    int weekNumber = date.weekOfYear;

    if (date.month == 1 && weekNumber > 50) {
      return date.year - 1;
    }
    else if (date.month == 12 && weekNumber == 1) {
      return date.year + 1;
    }
    else {
      return date.year;
    }
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