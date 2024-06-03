import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/initialize.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool appIsInitialized = await initializeApp();
  if (appIsInitialized) {
    if (Platform.isWindows || Platform.isLinux) {
      setWindowTitle('minddy');
      setWindowMinSize(const Size(900, 600));
    }
    ThemeMode themeMode = await AppTheme.getCurrentThemeMode();
    final String routeName = await getFirstPageRouteName();
    Locale locale = await getCurrentLocale();
    runApp(MainApp(routeName, locale, themeMode));
  }
}

class MainApp extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final Locale currentLocale;
  final String routeName;
  const MainApp(this.routeName, this. currentLocale, this.currentThemeMode, {super.key});
  // TODO : Documenter tout le code
  // TODO : Ajouter tous les articles de base
  // TODO : Gérer les raccourcis clavier
  // TODO : Faire thème high contrast et l'ajouter au main
  // TODO : Terminer les paramètres
  // TODO : Voir comment gérer les données des différents modules + Comment les dupliquer
  // TODO : Tools note rapide ?
  // TODO : Commencer la page des projets
  // TODO : Faire le module des tâches
  // TODO : Faire calcul du nombre de module dans chaque container
  // TODO : Faire fonction de calcul du nombre de containers

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: currentLocale,
      themeMode: currentThemeMode,
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
      initialRoute: routeName,
      home: const LoadingScreen(),
    );
  }
}

// This serves as initializing the context. If it's not here, it breaks.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Loading"),
    );
  }
}