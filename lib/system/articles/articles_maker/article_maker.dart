import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/articles_maker/article_maker_create_article_file.dart';
import 'package:minddy/system/initialize/initialize.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:window_size/window_size.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  bool appIsInitialized = await initializeApp();
  if (appIsInitialized) {
    if (Platform.isWindows || Platform.isLinux) {
      setWindowTitle('Article Maker');
      setWindowMinSize(const Size(900, 600));
    }
    ThemeMode themeMode = AppTheme.getCurrentThemeMode();
    Locale locale = await getCurrentLocale();
    runApp(_ArticleMaker(themeMode, locale));
  }
}

class _ArticleMaker extends StatelessWidget {
  const _ArticleMaker(this.currentThemeMode, this.currentLocale);

  final ThemeMode currentThemeMode;
  final Locale currentLocale;

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
      title: "Article Maker",
      home: const ArticlesMakerHomeView(),
    );
  }
}

class ArticlesMakerHomeView extends StatefulWidget {
  const ArticlesMakerHomeView({super.key});

  @override
  State<ArticlesMakerHomeView> createState() => _ArticlesMakerHomeViewState();
}

class _ArticlesMakerHomeViewState extends State<ArticlesMakerHomeView> {

  String jsonContent = "";

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: theme.onPrimary),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 20),
                      child: TextField(
                        onChanged: (value) {
                          jsonContent = value;
                        },
                        cursorColor: theme.onPrimary,
                        controller: _textEditingController,
                        style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your json code"
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      child: IconButton(
                        onPressed: () async {
                          bool isArticleCreated = await ArticleMaker.createArticle(jsonContent);
                          if (isArticleCreated && context.mounted) {
                            NotificationHandler.addNotification(
                              NotificationModel(
                                content: "Article has been created", 
                                action: null, 
                                actionLabel: "Perfect", 
                                duration: NotificationDuration.long
                              )
                            );
                            setState(() {
                              _textEditingController.clear();
                            });
                          }
                        }, 
                        style: ButtonThemes.primaryButtonStyle(context),
                        icon: Icon(Icons.arrow_upward_rounded, color: theme.onPrimary)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}