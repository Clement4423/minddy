import 'package:flutter/material.dart';
import 'package:minddy/system/interface/rooter_interface.dart';

class SidebarNavigationController extends ChangeNotifier{

  final IRouter _rooter;
  late Widget _currentPage;


  SidebarNavigationController(this._rooter) {
    _currentPage = _rooter.navigateTo("/");
  }

  int _currentSelected = 1;
  

  Widget get currentPage => _currentPage;

  setCurrentCustomPageNoRefresh(String routeName, dynamic argument) {
    _currentPage = _rooter.navigateToCustomPage(routeName, argument);
  }

  setCurrentCustomPage(String routeName, dynamic argument) {
    _currentPage = _rooter.navigateToCustomPage(routeName, argument);
    notifyListeners();
  }

  setCurrentPageNoRefresh(String routeName) {
    _currentPage = _rooter.navigateTo(routeName);
  }

  setCurrentPage(String routeName) {
    _currentPage = _rooter.navigateTo(routeName);
    notifyListeners();
  }

  setCurrentSelected(int newSelected) {
    _currentSelected = newSelected;
    notifyListeners();
  } 

  bool getActive(int index) {
   return _currentSelected == index;
  }
}