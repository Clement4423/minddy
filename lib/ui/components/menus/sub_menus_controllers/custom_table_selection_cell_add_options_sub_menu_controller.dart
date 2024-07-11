import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/cards/custom_table_selection_cell_option_card.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';

class CustomTableSelectionCellAddOptionsSubMenuController extends ChangeNotifier {
  String get errorMessage => _errorMessage;
  String _errorMessage = '';

  _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }


  List<CustomTableSelectionCellOptionModel> options = [];
  List<CustomTableSelectionCellOptionCard> optionsWidgets = [];


  void deleteOption(CustomTableSelectionCellOptionModel optionToDelete) {
    options.remove(optionToDelete);
    notifyListeners();
  }

  void addOption() {
    options.add(CustomTableSelectionCellOptionModel(name: '', color: DefaultAppColors.grey.color));
    notifyListeners();
  }

  Future<bool> vertifyOptions(Function(List<CustomTableSelectionCellOptionModel>) onCompleted) async {
    List<String> usedNames = [];
    if (options.isEmpty) {
      _setErrorMessage(S.current.projects_module_spreadsheet_selection_sub_menu_error_message_no_options);
      return false;
    }

    for (CustomTableSelectionCellOptionModel option in options) {
      if (option.name.isEmpty) {
        _setErrorMessage(S.current.projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option);
        return false;
      } else if (usedNames.contains(option.name.toLowerCase())) {
        _setErrorMessage(S.current.projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(option.name));
        return false;
      } else {
        usedNames.add(option.name.toLowerCase());
      }
    }
    await onCompleted(options);
    return true;
  }
}