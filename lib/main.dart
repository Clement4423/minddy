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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/app_state.dart';
import 'package:minddy/system/initialize/initialize.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/router/animated_route_builder.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/components/notifications/notifications_builder.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/views/loading_screen.dart';
import 'package:window_size/window_size.dart';

late ThemeMode _currentThemeMode;
late Locale _currentLocale;
late String _routeName;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

Future<bool> initializeState() async {
  bool appIsInitialized = await initializeApp();
  if (appIsInitialized) {
    if (Platform.isWindows || Platform.isLinux) {
      setWindowTitle('minddy');
      setWindowMinSize(const Size(900, 630));
    }
    _currentThemeMode = AppTheme.getCurrentThemeMode();
    _routeName = await getFirstPageRouteName();
    _currentLocale = await getCurrentLocale();
  }
  return appIsInitialized;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

// TODO: Document all code
// TODO: Run tests
// TODO: Start the launch website
// TODO: Add a double-right-click enabled menu on tasks
// TODO: Tools, quick note?
// TODO: Add all basic articles
// TODO: Create 'help' articles for modules
// TODO: Implement a search feature within an article to search for a keyword
// TODO: Redesign the article system
// TODO: Create the error screen on launch
// TODO: Create a high-contrast theme and add it to main
// TODO: Complete the settings
// TODO: Complete the projects page
// TODO: Be able to change the icon for note categories
// TODO: Add a function to save the project before closing the app
// TODO: Add page repositioning and module movement
// TODO: Make the module add menu cleaner
// TODO: Add legends below the graphs on the table module + Fix bugs
// TODO: Create a 'notifications' tab to see recent notifications.
// TODO: Find a replacement for the FilePicker addon
// TODO: Restore encryption on addons
// TODO: See which dates on the DatePickerInput aren't displaying
// TODO: Complete the addon system
// TODO: Change the variable save location
// TODO: Tie the nodes for lists
// TODO: Add protection to the first UI component, which can only be a container
// TODO: Create all the PluginUIComponents
// TODO: Create the menu for text translations
// TODO: Translate all texts


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: AppState.streamController.stream,
      builder: (context, streamSnapshot) {
        return FutureBuilder(
          future: initializeState(),
          builder: (context, initSnapshot) {
            return Stack(
              alignment: Alignment.topLeft,
              children: [
                // Main app
                Builder(
                  builder: (context) {
                    if (initSnapshot.hasError) {
                      return const ErrorScreen();
                    }
            
                    if (initSnapshot.hasData) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: const [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        locale: _currentLocale,
                        themeMode: _currentThemeMode,
                        theme: AppTheme.getLightTheme,
                        darkTheme: AppTheme.getDarkTheme,
                        highContrastTheme: AppTheme.getBWLightTheme,
                        highContrastDarkTheme: AppTheme.getBWDarkThemeData,
                        title: "minddy",
                        initialRoute: _routeName,
                        navigatorKey: AppRouter.router.navigatorKey,
                        onGenerateRoute: (settings) {
                          final builder = AppRouter.router.routes[settings.name];
                          if (builder == null) {
                            return AnimatedRouteBuilder(page: LoadingScreen(routeName: _routeName));
                          }
                          return AnimatedRouteBuilder(page: builder(context));
                        },
                        home: Container(
                          color: Colors.transparent,
                        )
                      );
                    }
            
                    return const ErrorScreen();
                  }
                ),
                // Notification builder
                StreamBuilder(
                  stream: NotificationHandler.notifications,
                  initialData: const <NotificationState>[],
                  builder: (context, notificationSnapshot) {
                    if (initSnapshot.hasData && notificationSnapshot.hasData) {
                      ThemeMode themeMode = ThemeMode.system;
                      return Theme(
                        data: themeMode == ThemeMode.dark 
                          ? AppTheme.getDarkTheme 
                          : AppTheme.getLightTheme,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: NotificationsBuilder(
                            notifications: notificationSnapshot.data as List<NotificationState>
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.transparent,
                      );
                    }
                  }
                ),
              ],
            );
          }
        );
      }
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.getLightTheme,
      darkTheme: AppTheme.getDarkTheme,
      home: const LoadingScreen(routeName: '', redirect: false),
    );
  }
}
