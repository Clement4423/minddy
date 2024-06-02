import 'package:flutter/material.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_bottom_menu_content_view.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_bottom_menu_notes_view.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_bottom_menu_sources_view.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';

class ArticlesBottomMenuController extends ChangeNotifier {
  static late Widget _currentPage;
  final ArticlesViewController articleController;

  late Map<String, Widget> _pages;

  ArticlesBottomMenuController({required this.articleController}) {
    _pages = {
      "/sources": ArticlesBottomMenuSourcesView(articleController: articleController),
      "/content": ArticlesBottomMenuContentView(articleController: articleController),
      "/notes": ArticlesBottomMenuNotesView(articleController: articleController,),

  };
    _currentPage = _pages.values.toList()[_currentSelected];
  }

  static int _currentSelected = 0;
  

  Widget get currentPage => _currentPage;

  setCurrentPage(String routeName) {
    _currentPage = _pages[routeName] ?? const SizedBox();
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
