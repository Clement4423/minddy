import 'package:flutter/material.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/plugin_info.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/router/animated_route_builder.dart';
import 'package:minddy/ui/view_models/create_password_viewmodel.dart';
import 'package:minddy/ui/view_models/home_viewmodel.dart';
import 'package:minddy/ui/view_models/plugin_editor_view_model.dart';
import 'package:minddy/ui/view_models/project_viewmodel.dart';
import 'package:minddy/ui/view_models/welcome_viewmodel.dart';
import 'package:minddy/ui/views/create_password_view.dart';
import 'package:minddy/ui/views/home_view.dart';
import 'package:minddy/ui/views/plugin_editor_view.dart';
import 'package:minddy/ui/views/project_view.dart';
import 'package:minddy/ui/views/welcome_view.dart';

class AppRouter {
  static AppRouter router = AppRouter._();

  AppRouter._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// [/] to go to the welcome page
  ///
  /// [/welcome] to go to the welcome page
  /// 
  /// [/create_password] to go to the create password page
  /// 
  /// [/home] to go home
  final Map<String, WidgetBuilder> routes = {
    '/':(context) => WelcomeView(WelcomeViewModel()),
    '/welcome': (context) => WelcomeView(WelcomeViewModel()),
    '/create_password': (context) => CreatePasswordView(CreatePasswordViewModel()),
    '/home': (context) => HomeView(HomeViewModel()),
  };

  Future<dynamic> navigateTo(String routeName, {BuildContext? context}) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> showProject(BuildContext context, ProjectInfo projectInfo) {
    StaticVariables.currentProjectInfo = projectInfo;
    return Navigator.of(context).push(
      AnimatedRouteBuilder(
        page: ProjectView(ProjectViewModel(projectInfo: projectInfo)),
      ),
    );
  }

  Future<dynamic> showPlugin(BuildContext context, PluginInfo pluginInfo) {
    return Navigator.of(context).push(
      AnimatedRouteBuilder(
        page: PluginEditorView(viewModel: PluginEditorViewModel(pluginInfo: pluginInfo)),
      ),
    );
  }

  Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}