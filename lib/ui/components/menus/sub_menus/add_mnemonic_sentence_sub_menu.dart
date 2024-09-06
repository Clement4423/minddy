import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/secure_storage.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';

class MnemonicSentenceSubMenu extends StatefulWidget {
  const MnemonicSentenceSubMenu({super.key});

  @override
  State<MnemonicSentenceSubMenu> createState() => _MnemonicSentenceSubMenuState();
}

class _MnemonicSentenceSubMenuState extends State<MnemonicSentenceSubMenu> {

  String _sentence = "";

  @override
  void initState() {
    SecuredStorage.read("minddy_mnemonic_sentence").then((value) => setState(() {
      _sentence = value ?? "";
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: theme.onPrimary.withOpacity(theme.brightness == Brightness.light ? 1 : 0.2),
          width: 0.5
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Text(
              S.of(context).submenu_welcome_password_mnemonic_sentence_title, 
              style: theme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).submenu_welcome_password_mnemonic_sentence_subtitle, 
                      style: theme.bodySmall.
                      copyWith(color: theme.onPrimary),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField (
                      onChanged: (value) => {
                        _sentence = value
                      },
                      controller: TextEditingController(text: _sentence),
                      style: theme.bodyMedium.
                      copyWith(color: theme.onSurface),
                      cursorColor: theme.onSurface,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: S.of(context).submenu_welcome_password_mnemonic_sentence_hint,
                        hintStyle: theme.bodyMedium.copyWith(color: Colors.grey),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      S.of(context).submenu_welcome_password_mnemonic_sentence_instructs,
                      style: theme.bodyMedium.copyWith(color: theme.onSurface),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 350,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextButton(
                  S.of(context).submenu_artilces_image_description_button, 
                  () async {
                    await SecuredStorage.write("minddy_mnemonic_sentence", _sentence);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  false, 
                  false
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}