import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/theme/theme.dart';


// To create the appbar properly, you need to import 3 things for the constructor of the controller : 
// - The title of the page 
// - A boolean to indicate if there should be a back home button
// - A list of actions for the actions buttons, 
//   in those list elements, you need to provide : 
//    - The icon to use 
//    - a boolean to indicate if the button style is primary(blue) 
//    - and finaly a function to execute when the button is pressed


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomAppBarController _controller;
  const CustomAppBar(this._controller, {super.key});
  
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      height: 50,
      color: theme.primary,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 6),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Leading
                Row(
                  children: [
                    if (_controller.homeButton)
                      Tooltip(
                        message: S.of(context).appbar_go_home,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: () {_controller.goToHomePage(context);},
                            style: ButtonThemes.secondaryButtonStyle(context),
                            // ignore: deprecated_member_use
                            icon: SvgPicture.asset("assets/custom_icons/home_icon.svg", width: 20, height: 20, color: theme.onPrimary),
                          )
                        ),
                      ),
                    Text(_controller.title, style: theme.titleLarge),
                  ],
                ),
                // Actions
                  Row(
                    children: _controller.actionsElements.map((button) {
                      return buildButton(button.icon, button.isPrimary, button.action, button.semanticText, context);
                      }).toList(),
                  )
              ],
            );
          }
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  Widget buildButton(IconData icon, bool isPrimary, Function action, String semanticLabel, BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Tooltip(
        message: semanticLabel,
        child: IconButton(
          onPressed: () {action();},
          icon: Icon(icon, semanticLabel: semanticLabel, color: isPrimary 
            ? theme.onSecondary
            : theme.onPrimary
          ),
          style: isPrimary
            ? ButtonThemes.primaryButtonStyle(context)
            : ButtonThemes.secondaryButtonStyle(context)
        ),
      ),
    );
  }
}
