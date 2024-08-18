import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/nodes/nodes_container.dart';
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
            "Node editor",
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
            homeButtonIcon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary)
          )
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: NodeEditorBottomSheet()
            ),
          ],
        )
      ),
    );
  }
}

class NodeEditorBottomSheet extends StatefulWidget {
  const NodeEditorBottomSheet({super.key});

  @override
  State<NodeEditorBottomSheet> createState() => _NodeEditorBottomSheetState();
}

class _NodeEditorBottomSheetState extends State<NodeEditorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size appWindowSize = MediaQuery.of(context).size;
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: appWindowSize.width,
      height: appWindowSize.height / 1.8,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        )
      ),
      child: Stack(
        children: [
          // Grid with nodes
          InteractiveViewer(
            maxScale: 4.0,
            minScale: 0.1,
            child: CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: NodeEditorGridPainter(
                theme: theme, 
                scale: 1.0
              ),
            ),
          ),
          // Top bar
          Positioned(
            top: 0,
            child: SizedBox(
              width: appWindowSize.width,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(),
                    Container(
                      width: appWindowSize.width * 0.02,
                      height: appWindowSize.height * 0.005,
                      decoration: BoxDecoration(
                        color: theme.onSurface.withOpacity(0.8),
                        borderRadius: BorderRadius.circular((appWindowSize.height * 0.005) / 2)
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        
                      },
                      style: ButtonThemes.secondaryButtonStyle(context), 
                      icon: Icon(Icons.add_rounded, color: theme.onPrimary)
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}