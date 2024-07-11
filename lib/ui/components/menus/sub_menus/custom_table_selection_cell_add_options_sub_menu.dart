import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/cards/custom_table_selection_cell_option_card.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/custom_table_selection_cell_add_options_sub_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableSelectionCellAddOptionsSubMenu extends StatefulWidget {
  const CustomTableSelectionCellAddOptionsSubMenu({super.key, required this.options, required this.onCompleted});

  final List<CustomTableSelectionCellOptionModel> options;

  final Function(List<CustomTableSelectionCellOptionModel> newOptionsList) onCompleted;

  @override
  State<CustomTableSelectionCellAddOptionsSubMenu> createState() => _CustomTableSelectionCellAddOptionsSubMenuState();
}

class _CustomTableSelectionCellAddOptionsSubMenuState extends State<CustomTableSelectionCellAddOptionsSubMenu> {

  final CustomTableSelectionCellAddOptionsSubMenuController _controller = CustomTableSelectionCellAddOptionsSubMenuController();

  List<CustomTableSelectionCellOptionCard> _buildOptionCard(List<CustomTableSelectionCellOptionModel> options, StylesGetters theme) {
    List<CustomTableSelectionCellOptionCard> optionsWidgets = [];
    for (CustomTableSelectionCellOptionModel option in options) {
      optionsWidgets.add(
        CustomTableSelectionCellOptionCard(option: option, theme: theme, controller: _controller)
      );
    }
    return optionsWidgets;
  }

  @override
  void initState() {
    _controller.options = widget.options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
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
                  S.of(context).projects_module_spreadsheet_selection_cell_add_options, 
                  style: theme.titleLarge
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  _controller.errorMessage,
                  style: theme.bodySmall.
                  copyWith(color: theme.error),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).projects_module_spreadsheet_selection_cell_all_options,
                            style: theme.bodySmall.
                            copyWith(color: theme.onBackground),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView(
                            children: [
                              ..._buildOptionCard(_controller.options, theme),
                              Container(
                                width: 200,
                                height: 40,
                                margin: const EdgeInsets.all(10),
                                child: IconButton(
                                  icon: Icon(Icons.add_rounded, color: theme.onPrimary),
                                  onPressed: () {
                                    _controller.addOption();
                                  },
                                  tooltip: S.of(context).projects_module_spreadsheet_selection_cell_add_an_option,
                                  style: ButtonThemes.secondaryButtonStyle(context),
                                ),
                              )
                            ]
                          ),
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
                        bool isOk = await _controller.vertifyOptions(widget.onCompleted);
                        if (isOk && context.mounted) {
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
          );
        }
      ),
    );
  }
}
