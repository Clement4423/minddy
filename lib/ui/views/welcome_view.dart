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
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_underlined_text_button.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel _viewmodel;
  const WelcomeView(this._viewmodel, {super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.primary,
        appBar: CustomAppBar(
          CustomAppBarController(
            S.of(context).welcome_appbar,
            false,
            [
              CustomAppBarButtonModel(
                icon: Icons.settings_rounded, 
                semanticText: S.of(context).settings_title,
                isPrimary: false, 
                action: () async {await showSettings(context);}
              )
            ] 
          )
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).welcome_before_creating, style: theme.titleLarge, textAlign: TextAlign.left),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(S.of(context).welcome_because, style: theme.bodyMedium, textAlign: TextAlign.left,),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextSelectionTheme(
                        data: TextSelectionThemeData(
                          selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary
                        ),
                        child: TextField(
                          onChanged: (newValue) {
                            _viewmodel.usernameChanged(newValue);
                          },
                          cursorColor: theme.onPrimary,
                          textAlign: TextAlign.center,
                          style: theme.titleLarge.copyWith(color: theme.onSurface),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).welcome_enter_name,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnimatedBuilder(
                      animation: _viewmodel,
                      builder: (context, child) {
                        return Text(
                          _viewmodel.errorMessage, 
                          style: theme.bodySmall.
                          copyWith(color: theme.error),
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      onPressed: () async {
                        await _viewmodel.validateUsername();
                      },
                      icon: Icon(Icons.arrow_forward_rounded, semanticLabel: S.of(context).welcome_next_page_semantic),
                      style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(theme.onSecondary),
                        backgroundColor: WidgetStatePropertyAll(theme.secondary),
                        iconSize: const WidgetStatePropertyAll(40),
                        elevation: const WidgetStatePropertyAll(7),
                        shadowColor: WidgetStatePropertyAll(theme.shadow),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: S.of(context).welcome_pass_tooltip(S.of(context).settings_account_title),
                    child: CustomUnderlinedTextButton(
                      text: S.of(context).welcome_pass_username, 
                      action: () async {
                        _viewmodel.skipUsername();
                      }
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            )
          ],
        ),
      ),
    ); 
  }
}