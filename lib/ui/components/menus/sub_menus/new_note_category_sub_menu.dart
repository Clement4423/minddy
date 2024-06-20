import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/theme/theme.dart';

class NewNoteCategorySubMenu extends StatefulWidget {
  const NewNoteCategorySubMenu({super.key, required this.onCompleted});

  final Function onCompleted;

  @override
  State<NewNoteCategorySubMenu> createState() => _NewNoteCategorySubMenuState();
}

class _NewNoteCategorySubMenuState extends State<NewNoteCategorySubMenu> {
  String _name = '';
  bool isPrivate = false;

  String _errorMessage = '';

  bool _verifyName() {
    if (_name.isEmpty) {
      setState(() {
        _errorMessage = 'Please, name the category';
      });
      return false;
    } else {
      return true;
    }
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Text("New category", style: theme.titleLarge),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Category name', style: theme.bodySmall.copyWith(color: theme.onBackground)),
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
                    child: TextField(
                      onChanged: (value) => {_name = value},
                      maxLength: 15,
                      style: theme.bodyMedium.copyWith(color: theme.onSurface),
                      cursorColor: theme.onSurface,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Enter the category name',
                        hintStyle: theme.bodyMedium.copyWith(color: Colors.grey),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Text(
                    _errorMessage,
                    style: theme.bodySmall.copyWith(color: theme.error),
                  ),
                  SwitchTile(
                    false, 
                    "Private category", 
                    (value) {
                      isPrivate = value;
                    }, 
                    false
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
              child: CustomTextButton(
                S.of(context).submenu_new_project_button,
                () async {
                  bool isNameOk = _verifyName();
                  if (isNameOk) {
                    await AppNotes.newCategory(_name, isPrivate);
                    await widget.onCompleted();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                false,
                false
              ),
            ),
          )
        ],
      )
    );
  }
}