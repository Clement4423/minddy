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
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/defaults_articles/default_articles_list.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/plugin_info.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_menu_button.dart';
import 'package:minddy/ui/components/calendar/calendar_button.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel _viewmodel;
  const HomeView(this._viewmodel, {super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    widget._viewmodel.initializeGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primary,
        image: DecorationImage(
         image: AssetImage(
          AppTheme.isUsingBWMode 
            ? theme.brightness == Brightness.light 
              ? "assets/background/background_home_grey.png"
              : "assets/background/background_home_dark.png"
            : "assets/background/background_home_blue.png"
         ),
         fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          CustomAppBarController(
            S.of(context).home_appbar,
            false,
                [
                  CustomAppBarButtonModel(
                    icon: Icons.star_border_rounded, 
                    semanticText: "Node editor",
                    isPrimary: false, 
                    action: () async {AppRouter.router.showPlugin(context, PluginInfo(version: '0', relativePath: 'shared/plugins/0/plugin.json', name: "Plugin test", creator: "Minddy"));}
                  ),
                  CustomAppBarButtonModel(
                    icon: Icons.settings_rounded, 
                    semanticText: S.of(context).settings_title,
                    isPrimary: false, 
                    action: () async {await showSettings(context);}
                  ),
                  CustomAppBarButtonModel(
                    icon: Icons.add_rounded, 
                    semanticText: S.of(context).submenu_new_project_title,
                    isPrimary: true, 
                    action: () async {widget._viewmodel.showNewProjectMenu(context, () {widget._viewmodel.initializeProjectCards(true);});}
                  )
                ] 
            )
        ),
        body: AnimatedBuilder(
          animation: widget._viewmodel,
          builder: (context, child) {
            if (widget._viewmodel.checkIfNeedToUnlock()) {
              widget._viewmodel.showUnlockMenu(context, function: () {widget._viewmodel.initializeProjectCards(true);});
            }
            return Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [                              
                            Padding(
                              padding: const EdgeInsets.only(top: 50, bottom: 30),
                              child: Text(
                                widget._viewmodel.greetingText,
                                  style: theme.headlineLarge.
                                  copyWith(color: theme.onPrimary)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                                      child: Text(
                                        S.of(context).home_pick_up, 
                                        style: theme.bodyMedium.
                                        copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    StreamBuilder<bool>(
                                      stream: LoginState.unlockedStream,
                                      initialData: LoginState.isUnlocked,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData && snapshot.data == true) {
                                          return FutureBuilder(
                                            future: widget._viewmodel.initializeProjectCards(),
                                            builder: (context, future) {
                                              if (future.connectionState == ConnectionState.done) {
                                                return SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: widget._viewmodel.projectCards
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            }
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                                      child: Text(
                                        S.of(context).home_discover, 
                                        style: theme.bodyMedium.
                                        copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: DefaultArticlesList.list.map((widget) => Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: widget,
                                        )).toList()),
                                      ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: ArticlesMenuButton(),
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: LoginState.unlockedStream,
                    initialData: LoginState.isUnlocked,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return Positioned(
                          bottom: 0,
                          right: 0,
                          child: CalendarButton(useUsDateFormat: AppConfig.data.preferUsDateFormat)
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}