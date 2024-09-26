import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/defaults_articles/default_articles_list.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/plugin_info.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_menu_button.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewmodel;
  const HomeView(this._viewmodel, {super.key});

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
                    icon: Icons.date_range_rounded, 
                    semanticText: "Test",
                    isPrimary: false, 
                    action: () async {
                      Size size = MediaQuery.of(context).size;
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return Container(
                            color: theme.primary,
                          width: size.width,
                          height: size.height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: CustomSelectionMenu(
                                  buttonStyle: ButtonThemes.primaryButtonStyle(context),
                                  theme: theme,
                                  enableSearch: true,
                                  items: [
                                    CustomSelectionMenuItem(
                                      label: "See more", 
                                      icon: Icons.brush_rounded,
                                      items: [
                                        CustomSelectionMenuItem(
                                          label: 'Option 1', 
                                          icon: Icons.filter_1_rounded, 
                                          onTap: () {

                                          }
                                        ),
                                        CustomSelectionMenuItem(
                                          label: 'Option 2', 
                                          icon: null, 
                                          items: [
                                            CustomSelectionMenuItem(
                                              label: "Set ...", 
                                              icon: Icons.access_alarm_rounded, 
                                              onTap: () {

                                              }
                                            )
                                          ],
                                          onTap: () {
                                            
                                          }
                                        )
                                      ], 
                                      onTap: () {
                                
                                      }
                                    ),
                                    CustomSelectionMenuItem(
                                      label: "Duplicate", 
                                      icon: Icons.copy_rounded, 
                                      onTap: () {
                                
                                      }
                                    ),
                                    CustomSelectionMenuItem(
                                      label: "Delete", 
                                      icon: Icons.delete_outline_rounded,
                                      foregroundColor: theme.error, 
                                      onTap: () {
                                
                                      }
                                    )
                                  ],
                                  child: Text("Click"),
                                ),
                              ),
                            ],
                          )
                        );
                        },
                        
                      );
                    }
                  ),
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
                    action: () async {_viewmodel.showNewProjectMenu(context, _viewmodel.initializeProjectCards);}
                  )
                ] 
            )
        ),
        body: AnimatedBuilder(
          animation: _viewmodel,
          builder: (context, child) {
            if (_viewmodel.checkIfNeedToUnlock()) {
              _viewmodel.showUnlockMenu(context, function: _viewmodel.initializeProjectCards);
            }
            return Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [                              
                            Padding(
                              padding: const EdgeInsets.only(top: 50, bottom: 30),
                              child: Text(
                                _viewmodel.greetingText,
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
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: _viewmodel.projectCards
                                            ),
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
                                        children: DefaultArticlesList.list,
                                      ),
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
                  const ArticlesMenuButton()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
