import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/settings/settings_components/settings_page_top_bar.dart';
import 'package:minddy/ui/components/settings/settings_pages_controllers/settings_account_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class AccountView extends StatelessWidget {
  final AccountViewController _controller;

  const AccountView(this._controller, {super.key});
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      children: [
        SettingsPagebar(S.of(context).settings_account_title),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
                child: ListView(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.of(context).settings_username_subtitle,
                        style: theme.bodySmall.copyWith(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextSelectionTheme(
                            data: TextSelectionThemeData(
                              selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary
                            ),
                            child: TextField(
                              onChanged: (newValue) {
                                _controller.usernameChanged(newValue);
                              },
                              controller: TextEditingController(text: _controller.username),
                              cursorColor: theme.onPrimary,
                              textAlign: TextAlign.start,
                              style: theme.bodyMedium.copyWith(color: theme.onSurface),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        S.of(context).settings_reset_subtitle,
                        style: theme.bodySmall.copyWith(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: CustomTextButton(
                        S.of(context).settings_reset_button, 
                        _controller.resetSettings, 
                        true, 
                        false,
                        isCritic: true,
                      ),
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}