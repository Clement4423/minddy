import 'package:flutter/material.dart';
import 'package:minddy/ui/components/calendar/calendar_week_view_bottom_menu_search_event_view.dart';
import 'package:minddy/ui/components/calendar/controller/calendar_week_view_controller.dart';
import 'package:minddy/ui/components/calendar/week_selector_date_picker.dart';

class CalendarBottomMenuController extends ChangeNotifier {
  static late Widget _currentPage;
  final CalendarWeekViewController calendarWeekViewController;

  late Map<String, Widget> _pages;

  bool isClosed = true;

  CalendarBottomMenuController({required this.calendarWeekViewController}) {
    isClosed = calendarWeekViewController.isBottomMenuClosed;
    _pages = {
      "/week": WeekSelectorDatePicker(
        onWeekSelected: calendarWeekViewController.selectNewWeek, 
        selectedWeek: calendarWeekViewController.selectedWeek, 
        selectedYear: calendarWeekViewController.selectedYear,
        controller: calendarWeekViewController,
        events: calendarWeekViewController.events,
        calendars: calendarWeekViewController.calendars
      ),
      "/search": CalendarWeekViewBottomMenuSearchEventView(
        events: calendarWeekViewController.events, 
        calendars: calendarWeekViewController.calendars, 
        updateUi: calendarWeekViewController.update,
        setWeek: (event) {
          int weekNumber = calendarWeekViewController.getWeekNumber(event.start);
          int year = calendarWeekViewController.getISOYear(event.start);

          calendarWeekViewController.highlightedEventID = event.eventId;

          calendarWeekViewController.selectNewWeek(weekNumber, year);
        },
        useUsDateFormat: false
      )
    };
    _currentPage = _pages.values.toList()[_currentSelected];
  }

  static int _currentSelected = 0;
  

  Widget get currentPage => _currentPage;

  setCurrentPage(String routeName) {
    isClosed = false;
    _currentPage = _pages[routeName] ?? const SizedBox();
  }

  setCurrentSelected(int newSelected) {
    isClosed = false;
    _currentSelected = newSelected;
  } 

  void updateMenu() {
    calendarWeekViewController.setIsBottomMenuClosed(isClosed);
    notifyListeners();
  }

  bool getActive(int index) {
   return _currentSelected == index;
  }
}
