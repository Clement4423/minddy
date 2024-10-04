
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/nodes/node_editor_bottom_sheet.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/plugin_editor_view_model.dart';

class PluginEditorView extends StatefulWidget {
  const PluginEditorView({super.key, required this.viewModel});

  final PluginEditorViewModel viewModel;

  @override
  State<PluginEditorView> createState() => _PluginEditorViewState();
}

class _PluginEditorViewState extends State<PluginEditorView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    Size appWindowSize = MediaQuery.of(context).size;

    Offset maxOffset = Offset(appWindowSize.width * 3, appWindowSize.height * 2);

    return Container(
      decoration: BoxDecoration(
        color: theme.primary,
        image: DecorationImage(
          image: AssetImage(
            AppTheme.isUsingBWMode
              ? theme.brightness == Brightness.light
                ? "assets/background/background_project_grey.png"
                : "assets/background/background_project_dark.png"
              : theme.brightness == Brightness.light
                ? "assets/background/background_project_blue.PNG"
                : "assets/background/background_project_blue_dark.PNG"
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          CustomAppBarController(
            widget.viewModel.pluginInfo.name,
            true,
            [
              CustomAppBarButtonModel(
                icon: Icons.settings_rounded,
                semanticText: S.of(context).settings_title,
                isPrimary: false,
                action: () async {await showSettings(context);},
              ),
              CustomAppBarButtonModel(
                icon: Icons.play_arrow_rounded,
                semanticText: "Try",
                isPrimary: true,
                action: () {},
              ),
            ],
            homeButtonIcon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary),
            onHomeButtonPressed: () async => await widget.viewModel.savePlugin()
          )
        ),
        body: FutureBuilder(
          future: widget.viewModel.initialize(maxOffset, theme),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: NodeEditorBottomSheet(controller: widget.viewModel.bottomSheetController, theme: theme)
                ),
              ],
            );
            } else {
              return const SizedBox();
            }
          }
        )
      ),
    );
  }
}