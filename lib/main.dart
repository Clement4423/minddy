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
    _currentThemeMode = await AppTheme.getCurrentThemeMode();
    _routeName = await getFirstPageRouteName();
    _currentLocale = await getCurrentLocale();
  }
  return appIsInitialized;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // TODO : Documenter tout le code
  // TODO : Faire les tests
  // TODO : Implémenter une fonctionnalitée de recherche à l'interieur d'un article pour chercher un mot clé
  // TODO : Tools note rapide ?
  // TODO : Ajouter tous les articles de base
  // TODO : Faire les articles 'aide' pour les modules
  // TODO : Refaire le systeme des articles
  // TODO : Faire l'écran d'erreur au lancement
  // TODO : Faire thème high contrast et l'ajouter au main
  // TODO : Terminer les paramètres
  // TODO : Faire en sorte de pouvoir mettre un projet en privé, pour nécessiter le mot de passe pour l'ouvrir
  // TODO : Changer le format de stockage des dates pour utiliser le format ISO8601
  // TODO : Terminer la page des projets
  // TODO : Pouvoir changer l'icone des categories de notes
  // TODO : Ajouter une fonction pour sauvagarder le projet avant de fermer l'app
  // TODO : Ajouter le déplacement des pages, ainsi que le déplacement des modules
  // TODO : Faire le menu d'ajout de module
  // TODO : AJouter les légendes en dessous des graphiques
  // TODO : Faire le système d'addon

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
                        navigatorKey: AppRouter.router.navigatorKey,
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
