/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

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

  String get greetingText => _greetingText;

  void showNewProjectMenu(BuildContext context, Function controllerAction) {
    showSubMenu(context, NewProjectSubMenu(NewProjectSubMenuController(specialAction: controllerAction)));
    notifyListeners();
  }

  void initializeGreeting() {
    _username = AppConfig.data.username;
    _greetingText = HomeViewModel.getGreetingText(_username);
  }

  static String getGreetingText(String username) {
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

  Future<void> initializeProjectCards([bool notify = false]) async {
    _projectsList = await getProjects();
    _projectsList.sort((a, b) {
      return a.lastChanged.isBefore(b.lastChanged) ? 1 : 0;
    });
    _projectCards = _buildProjectCards();
    if (notify) {
      notifyListeners();
    }
  }

  List<Widget> get projectCards => _projectCards;

  List<ProjectCard> _buildProjectCards() {
    List<ProjectCard> cards = [];
    for (var project in _projectsList) {
      ProjectCard card = ProjectCard(
        projectInfo: project,
        function: () {initializeProjectCards(true);},
      );
      cards.add(card);
    }
    return cards;
  }
}
