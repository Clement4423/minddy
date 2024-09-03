import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/secure_storage.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_password_text_field.dart';
import 'package:minddy/ui/components/custom_components/custom_underlined_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/add_mnemonic_sentence_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/create_password_viewmodel.dart';

class CreatePasswordView extends StatelessWidget {
  final CreatePasswordViewModel _viewmodel;
  const CreatePasswordView(this._viewmodel, {super.key});

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
                  Text(S.of(context).welcome_password_creation_title, style: theme.titleLarge, textAlign: TextAlign.left),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(S.of(context).welcome_password_creation_description, style: theme.bodyMedium, textAlign: TextAlign.left),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  CustomPasswordTextField(
                    hintText: S.of(context).welcome_password_creation_hint, 
                    onChanged: (value) {
                      _viewmodel.password = value;
                    },
                    contentBottomPadding: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18), 
                    width: 500,
                    height: 70,
                    margin: const EdgeInsets.only(top: 20),
                    borderRadius: BorderRadius.circular(20),
                    style: theme.titleLarge.copyWith(color: theme.onSurface),
                  ),
                  CustomPasswordTextField(
                    hintText: S.of(context).welcome_password_creation_confirm_hint,
                    onChanged: (value) {
                      _viewmodel.confirmedPassword = value;
                    }, 
                    contentBottomPadding: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18), 
                    width: 500,
                    height: 70,
                    margin: const EdgeInsets.only(top: 20),
                    borderRadius: BorderRadius.circular(20),
                    style: theme.titleLarge.copyWith(color: theme.onSurface),
                  ),
                  CustomUnderlinedTextButton(
                    text: S.of(context).welcome_password_creation_remember, 
                    action: () {
                      showSubMenu(context, const MnemonicSentenceSubMenu());
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnimatedBuilder(
                      animation: _viewmodel,
                      builder: (context, child) {
                        return SizedBox(
                          width: 350,
                          child: Center(
                            child: Text(
                              _viewmodel.errorMessage, 
                              style: theme.bodySmall.
                              copyWith(color: theme.error),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      onPressed: () async {
                        _viewmodel.validatePassword();
                      },
                      icon: Icon(Icons.arrow_forward_rounded, semanticLabel: S.of(context).welcome_next_page_semantic,),
                      style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(theme.onSecondary),
                        backgroundColor: WidgetStatePropertyAll(theme.secondary),
                        iconSize: const WidgetStatePropertyAll(40),
                        elevation: const WidgetStatePropertyAll(7),
                        shadowColor: WidgetStatePropertyAll(theme.shadow),
                      ),
                    ),
                  ),
                  if (kDebugMode)
                  ElevatedButton(
                    onPressed: () async {
                      await SecuredStorage.deleteDataEncryptionKeys(context);
                    },
                    style: ButtonThemes.crititcButtonTheme(context),
                    child: const Text("DELETE OLD ENCRYPTION KEYS")
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

