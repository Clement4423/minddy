import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/app_state.dart';
import 'package:minddy/system/initialize/initialize.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/theme/theme.dart';
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
      setWindowMinSize(const Size(900, 600));
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
  // TODO : Revoir la reinitialisation des paramètres pour ne pas recréer un mot de passe si il y en à déja un
  // TODO : Ajouter tous les articles de base
  // TODO : Faire les articles 'aide' pour les modules
  // TODO : Faire l'écran d'erreur
  // TODO : Faire thème high contrast et l'ajouter au main
  // TODO : Faire en sorte de pouvoir mettre un projet en privé, pour nécessiter le mot de passe pour l'ouvrir
  // TODO : Terminer les paramètres
  // TODO : Tools note rapide ?
  // TODO : Terminer la page des projets
  // TODO : Faire les fonds de projets pour le mode noir et blanc

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: AppState.streamController.stream,
      builder: (context, snapshot) {
        return FutureBuilder<bool>(
          future: initializeState(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            }

            if (snapshot.hasData) {
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
                navigatorKey: AppRouter.router.navigatorKey,
                onGenerateRoute: (settings) {
                  final builder = AppRouter.router.routes[settings.name];
                  return MaterialPageRoute(builder: (context) => builder!(context));
                },
                initialRoute: _routeName,
                home: const LoadingScreen(),
              );
            }

            return const ErrorScreen();
          },
        );
      },
    );
  }
}

// Loading Screen Widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingScreen(),
    );
  }
}
