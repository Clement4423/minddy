import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_password_text_field.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/custom_underlined_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/unlock_submenu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';


Future<bool> showUnlockContentSubMenu(BuildContext context) async {
  Completer<bool> completer = Completer<bool>();

  showSubMenu(
    context, 
    UnlockContentSubmenu(
      controller: UnlockSubMenuController(), 
      isUnlockedFunction: (bool value) {
        completer.complete(value);
        if (value == false) {
          Navigator.pop(context);
        }
      }
    )
  );

  return completer.future;
}


class UnlockContentSubmenu extends StatefulWidget {
  const UnlockContentSubmenu({super.key, required this.controller, required this.isUnlockedFunction});

  final UnlockSubMenuController controller;

  final Function(bool) isUnlockedFunction;

  @override
  State<UnlockContentSubmenu> createState() => _UnlockContentSubmenuState();
}

class _UnlockContentSubmenuState extends State<UnlockContentSubmenu> {

  String _mnemonicSentence = "";
  bool _showMnemonic = false;

  String _password = "";

  @override
    void initState() {
      widget.controller.getMnemonicSentence().then((value) => setState(() {
        _mnemonicSentence = value;
      }));
      super.initState();
    }

    Future<void> _checkUnlockState(BuildContext context) async {
      bool isUnlocked = await widget.controller.checkPassword(_password);
      await widget.isUnlockedFunction(isUnlocked);
      if (isUnlocked && context.mounted) {
        Navigator.pop(context);
      }
    } 

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 650,
      height: 430,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      // Main column
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          S.of(context).submenu_unlock_content_title,
                          style: theme.titleLarge.copyWith(color: theme.onPrimary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset("assets/logo/Logo.svg", width: 35, height: 35,),
                      )
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5, top: 20),
                  child: Text(
                    S.of(context).submenu_unlock_subtitle_text,
                    style: theme.headlineSmall.copyWith(fontSize: 14, color: theme.onPrimary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: CallbackShortcuts(
                    bindings: {
                      const SingleActivator(LogicalKeyboardKey.enter): () async {
                        await _checkUnlockState(context);
                      }
                    },
                    child: Focus(
                      child: CustomPasswordTextField(
                        hintText: S.of(context).submenu_unlock_subtitle_text, 
                        onChanged: (value) {
                          _password = value;
                        }, 
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), 
                        width: 300, 
                        height: 50, 
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        borderRadius: BorderRadius.circular(10), 
                        style: theme.bodyMedium.copyWith(color: theme.onSurface)
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: widget.controller, 
                  builder: (context, child) {
                    return Visibility(
                      visible: widget.controller.errorMessage.isEmpty 
                        ? false 
                        : true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Text(
                          widget.controller.errorMessage,
                          style: theme.bodyMedium.copyWith(color: theme.error),
                        ),
                      ),
                    );
                  }
                ),
                Visibility(
                  visible: _mnemonicSentence.isEmpty 
                    ? false 
                    : true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomUnderlinedTextButton(
                          text: _showMnemonic 
                            ? S.of(context).submenu_unlock_hide_mnemonic
                            : S.of(context).submenu_unlock_show_mnemonic, 
                            action: () {
                              setState(() {
                                _showMnemonic = !_showMnemonic;
                              });
                          }
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _showMnemonic,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: Container(
                      width: 300,
                      height: 90,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              _mnemonicSentence,
                              style: theme.bodyMedium.copyWith(color: theme.onSurface),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 60,
              child: CustomTextButton(
                S.of(context).submenu_artilces_image_description_button, 
                () async {
                  await _checkUnlockState(context);
                }, 
                false, 
                false
              ),
            ),
          )
        ],
      ),
    );
  }
}