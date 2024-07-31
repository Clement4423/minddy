import 'package:flutter/material.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';


// To create the appbar properly, you need to import 3 things for the constructor of the controller : 
// - The title of the page 
// - A boolean to indicate if it should be a back home button
//- A list of actions for the actions buttons, 
//   in those list elements, you need to provide : 
//    - The icon to use 
//    - a boolean to indicate if the button style is primary(blue) 
//    - and finaly a function for the action


class CustomAppBarController extends ChangeNotifier {
  late String _title;
  late bool _homeButton;
  late List<CustomAppBarButtonModel> _actionsElements;

  final Function? onHomeButtonPressed;

  CustomAppBarController (
    this._title, 
    this._homeButton,
    this._actionsElements,{
      this.onHomeButtonPressed
    }
  );

  String get title => _title;
  bool get homeButton => _homeButton;
  List<CustomAppBarButtonModel> get actionsElements => _actionsElements;

  void giveLeadingElements(String title, bool homeButton) {
    if (title != "") {
      _title = title;
      _homeButton = homeButton;
      notifyListeners();
    }
  }

  void giveActionsElements(List<CustomAppBarButtonModel> actionsList) {
    if (actionsList.isNotEmpty) {
      _actionsElements = actionsList;
      notifyListeners();
    }
  }

  void goToHomePage(BuildContext context) {
    StaticVariables.currentProjectInfo = null;
    Navigator.of(context).pop();
  }
}