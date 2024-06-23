import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/projects/get_projects.dart';
import 'package:minddy/ui/components/cards/projects_card.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_project_submenu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_submenu.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/new_project_submenu_controller.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/unlock_submenu_controller.dart';

class HomeViewModel extends ChangeNotifier {
  String _greetingText = '';
  String _username = '';
  List<ProjectInfo> _projectsList = [];
  List<Widget> _projectCards = [];

  static bool isUnlockMenuShown = false;

  HomeViewModel() {
    _initializeGreeting();
    initializeProjectCards();
  }

  String get greetingText => _greetingText;

  void showNewProjectMenu(BuildContext context, Function controllerAction) {
    showSubMenu(context, NewProjectSubMenu(NewProjectSubMenuController(specialAction: controllerAction)));
    notifyListeners();
  }

  Future<void> _initializeGreeting() async {
    _username = await _getUsername();
    _greetingText = await HomeViewModel.getGreetingText(_username);
    notifyListeners();
  }

  static Future<String> getGreetingText(String username) async {
    if (username == S.current.welcome_pass_default_username) {
      username = "";
    }
    DateTime dateTime = DateTime.now();
    String formattedHour = DateFormat('HH').format(dateTime);
    int actualHour = int.parse(formattedHour);
    if (actualHour >= 14 && actualHour < 18) {
      return S.current.greeting_afternoon(username);
    } else if (actualHour >= 18 || actualHour < 6) {
      return S.current.greeting_evening(username);
    } else {
      return S.current.greeting_morning(username);
    }
  }

  bool checkIfNeedToUnlock() {
    if (LoginState.isUnlocked) {
      return false;
    } else {
      return true;
    }
  }

  void showUnlockMenu(BuildContext context, {Function? function}) {
    if (!isUnlockMenuShown) {
      isUnlockMenuShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSubMenu(context, UnlockSubMenu(controller: UnlockSubMenuController(function: function)),isDismissible: false);
      });
    }
  }

  Future<String> _getUsername() async {
    return await AppConfig.getConfigValue("username");
  }

  Future<void> initializeProjectCards() async {
    _projectsList = await getProjects();
    _projectCards = _buildProjectCards();
    notifyListeners();
  }

  List<Widget> get projectCards => _projectCards;

  List<Widget> _buildProjectCards() {
    List<Widget> cards = [];
    for (var project in _projectsList) {
      Widget card = ProjectCard(
        projectInfo: project,
        background: Colors.blue,
        function: initializeProjectCards,
      );
      cards.add(card);
    }
    return cards;
  }
}
