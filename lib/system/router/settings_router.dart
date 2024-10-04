import 'package:flutter/material.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interfaces/router_interface.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_account_controller.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_personalize_controller.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_project_controller.dart';
import 'package:minddy/ui/components/settings/setttings_pages/settings_account_view.dart';
import 'package:minddy/ui/components/settings/setttings_pages/settings_personalize_view.dart';
import 'package:minddy/ui/components/settings/setttings_pages/settings_project_view.dart';

class SettingsRouter implements IRouter {
  
  @override
  final Map<String, dynamic> routes = {
    "/" : PersonalizeView(PersonalizeViewController()),
    "/personalize" : PersonalizeView(PersonalizeViewController()),
    "/project": ProjectSettingsView(ProjectSettingsViewModel(StaticVariables.currentProjectInfo ?? ProjectInfo('', ''), () {})),
    "/account" : AccountView(AccountViewController())
  };

  @override
  Widget navigateTo(String route, {BuildContext? context}) {
    return routes[route];
  }

  @override
  Widget navigateToCustomPage(String route, dynamic argument) {
    Widget page;
    if (route == "/project") {
      page = ProjectSettingsView(ProjectSettingsViewModel(argument['info'] ?? ProjectInfo('', ''), argument['function'] ?? () {}));
    } else {
      page = PersonalizeView(PersonalizeViewController());
    }
    return page;
  }
}