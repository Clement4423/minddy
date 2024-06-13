import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/new_project_submenu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class NewProjectSubMenu extends StatelessWidget {
  final NewProjectSubMenuController _controller;
  const NewProjectSubMenu(this._controller, {super.key});

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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Text(
                  S.of(context).submenu_new_project_title, 
                  style: theme.titleLarge
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
                          S.of(context).submenu_new_project_subtitle, 
                          style: theme.bodySmall.
                          copyWith(color: theme.onBackground),
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
                          onChanged: (value) => {_controller.nameChanged(value)},
                          maxLength: 20,
                          style: theme.bodyMedium.
                          copyWith(color: theme.onSurface),
                          cursorColor: theme.onSurface,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: S.of(context).submenu_new_project_hint,
                            hintStyle: theme.bodyMedium.copyWith(color: Colors.grey),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Text(
                        _controller.errorMessage,
                        style: theme.bodySmall.
                        copyWith(color: theme.error),
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
                    _controller.validateName, 
                    true, 
                    false
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
