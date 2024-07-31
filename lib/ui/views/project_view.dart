import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/utils/debouncer.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_menu_button.dart';
import 'package:minddy/ui/components/articles/articles_view/articles_view.dart';
import 'package:minddy/ui/components/calendar/calendar_button.dart';
import 'package:minddy/ui/components/custom_components/current_page_indicator_view.dart';
import 'package:minddy/ui/components/projects/toolbar/projects_toolbar.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/project_viewmodel.dart';


ShortcutActivator nextPageActivator = SingleActivator(
  LogicalKeyboardKey.arrowRight, 
  meta: Platform.isMacOS 
    ? true 
    : false,
  control: Platform.isWindows || Platform.isLinux
    ? true
    : false
);

ShortcutActivator previousPageActivator = SingleActivator(
  LogicalKeyboardKey.arrowLeft, 
  meta: Platform.isMacOS 
    ? true 
    : false,
  control: Platform.isWindows || Platform.isLinux
    ? true
    : false
);

class NextPageIntent extends Intent {
  const NextPageIntent();
}

class PreviousPageIntent extends Intent {
  const PreviousPageIntent();
}

class SaveProjectIntent extends Intent {
  const SaveProjectIntent();
}

class ProjectView extends StatefulWidget {
  const ProjectView(this._viewmodel, {super.key});

  final ProjectViewModel _viewmodel;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> with AutomaticKeepAliveClientMixin {
  Size? _lastSize;

  Size? currentSize;

  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 600));

  late PageController _pageController;

  final ProjectViewResizeFinishedNotifier _resizeFinishedNotifier = ProjectViewResizeFinishedNotifier();

  Future<void> initialize() async {
    if (_lastSize == null || _lastSize != currentSize) {
      _lastSize = currentSize;
      await widget._viewmodel.initialize();
      _pageController = PageController(initialPage: widget._viewmodel.lastPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    StylesGetters theme = StylesGetters(context);

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        nextPageActivator: const NextPageIntent(),
        previousPageActivator: const PreviousPageIntent(),
        saveActivator: const SaveProjectIntent()
      },
      child: Actions(
        actions: {
          NextPageIntent: CallbackAction<NextPageIntent>(
            onInvoke: (intent) => {
              if (widget._viewmodel.pageIndicatorController.currentPageIndex + 1 < widget._viewmodel.pageIndicatorController.totalPages) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 700), 
                  curve: Curves.fastEaseInToSlowEaseOut
                )
              }
            }
          ),
          PreviousPageIntent: CallbackAction<PreviousPageIntent>(
            onInvoke: (intent) => {
              if (widget._viewmodel.pageIndicatorController.currentPageIndex > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 700), 
                  curve: Curves.fastEaseInToSlowEaseOut
                )
              }
            },
          ),
          SaveProjectIntent: CallbackAction<SaveProjectIntent>(
            onInvoke: (intent) async => {
              await widget._viewmodel.saveProject()
            }
          )
        },
        child: Focus(
          autofocus: true,
          child: Container(
            decoration: BoxDecoration(
              color: theme.background,
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
                  onHomeButtonPressed: () async {
                    await widget._viewmodel.saveProject();
                  },
                  widget._viewmodel.projectInfo.name,
                  true,
                  [
                    CustomAppBarButtonModel(
                      icon: Icons.settings_rounded,
                      semanticText: S.of(context).settings_title,
                      isPrimary: false,
                      action: () async {await showSettings(context);},
                    ),
                    CustomAppBarButtonModel(
                      icon: Icons.add_box_outlined,
                      semanticText: S.of(context).projects_add_module_tooltip,
                      isPrimary: true,
                      action: () async {await _showAddModuleMenu(context, widget._viewmodel);},
                    ),
                    CustomAppBarButtonModel(
                      icon: Icons.save_rounded,
                      semanticText: S.of(context).projects_save_project_button_tooltip,
                      isPrimary: true,
                      action: () async {await widget._viewmodel.saveProject();},
                    ),
                  ],
                ),
              ),
              body: AnimatedBuilder(
                animation: _resizeFinishedNotifier,
                builder: (context, child) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      _lastSize = currentSize;
                  
                      currentSize = constraints.biggest;
                  
                      if (widget._viewmodel.isInitialized) {
                        if (_lastSize != currentSize) {
                          debouncer.call(() async {
                            await widget._viewmodel.saveProject().then((value) {_resizeFinishedNotifier.notify();});
                          });
                          return const SizedBox();
                        } else {
                          debouncer.dispose();
                        }
                      }
                  
                      return FutureBuilder<void>(
                        future: initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            return AnimatedBuilder(
                              animation: widget._viewmodel,
                              builder: (context, child) {
                                widget._viewmodel.buildContainers(currentSize ?? constraints.biggest);
                                widget._viewmodel.pageIndicatorController.setTotalPages(widget._viewmodel.modulesContainer.length);
                                if (widget._viewmodel.pageIndicatorController.currentPageIndex >= widget._viewmodel.modulesContainer.length) {
                                  widget._viewmodel.pageIndicatorController.pageChanged(widget._viewmodel.modulesContainer.length - 1);
                                }
                                return Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 25),
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          child: PageView.builder(
                                            itemCount: widget._viewmodel.modulesContainer.length,
                                            onPageChanged: (index) async {
                                              widget._viewmodel.pageIndicatorController.pageChanged(
                                                index >= widget._viewmodel.modulesContainer.length 
                                                ? 0 
                                                : index
                                              );
                                              await widget._viewmodel.saveProject();
                                            },
                                            controller: _pageController,
                                            itemBuilder: (context, index) {
                                              widget._viewmodel.pageIndicatorController.totalPages = widget._viewmodel.modulesContainer.length;
                                              return Row(
                                                key: UniqueKey(),
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: widget._viewmodel.modulesContainer[index].modules
                                              );
                                            },
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 25),
                                          child: SizedBox(),
                                        ),
                                      ],
                                    ),
                                    // Page navigation buttons
                                    AnimatedBuilder(
                                      animation: widget._viewmodel.pageIndicatorController, 
                                      builder: ((context, child) {
                                        return Stack(
                                          children: [
                                            Positioned(
                                              top: currentSize!.height / 2 - 50,
                                              left: 8,
                                              child: SwitchPageButton(
                                                pageController: _pageController, 
                                                icon: Icons.arrow_back_rounded, 
                                                isNextButton: false, 
                                                pageIndicatorController: widget._viewmodel.pageIndicatorController
                                              )
                                            ),
                                            Positioned(
                                              top: currentSize!.height / 2 - 50,
                                              right: 8,
                                              child: SwitchPageButton(
                                                pageController: _pageController, 
                                                icon: Icons.arrow_forward_rounded, 
                                                isNextButton: true, 
                                                pageIndicatorController: widget._viewmodel.pageIndicatorController
                                              )
                                            ),
                                          ],
                                        );
                                      })
                                    ),
                                    const ProjectsToolbar(),
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      child: CurrentPageIndicatorView(
                                        controller: widget._viewmodel.pageIndicatorController,
                                        pageController: _pageController,
                                      )
                                    ),
                                    const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CalendarButton(),
                                    ),
                                    const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: ArticlesMenuButton(),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

Future<dynamic> _showAddModuleMenu(BuildContext context, ProjectViewModel viewModel) async {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  final offset = renderBox.localToGlobal(Offset.zero);
  const iconSize = 25.0;
  const menuHeight = 80.0;
  StylesGetters theme = StylesGetters(context);
  showMenu(
    context: context,
    color: theme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
    ),
    position: RelativeRect.fromLTRB(
      double.infinity,
      offset.dy + menuHeight - iconSize, // top
      75,
      offset.dy, // bottom
    ),
    items: [
      PopupMenuItem(
        onTap: () {
          viewModel.newModule(ProjectsModulesTypes.tasks);
        },
        child: Text(S.current.projects_module_tasks_title),
      ),
      PopupMenuItem(
        onTap: () {
          viewModel.newModule(ProjectsModulesTypes.notes);
        },
        child: Text(S.of(context).projects_module_notes_title),
      ),
      PopupMenuItem(
        onTap: () {
          viewModel.newModule(ProjectsModulesTypes.spreadsheet);
        },
        child: Text(S.of(context).projects_module_spreadsheet_title),
      ),
    ],
  );
}

class SwitchPageButton extends StatelessWidget {
  const SwitchPageButton({super.key, required this.pageController, required this.icon, required this.isNextButton, required this.pageIndicatorController});

  final PageController pageController;
  final CurrentPageIndicatorController pageIndicatorController;

  final IconData icon;

  final bool isNextButton;

  @override
  Widget build(BuildContext context) {

    final StylesGetters theme = StylesGetters(context);
    bool canAppear = isNextButton ? pageIndicatorController.currentPageIndex + 1 < pageIndicatorController.totalPages : pageIndicatorController.currentPageIndex > 0;
    return Visibility(
      visible: canAppear,
      child: Tooltip(
        message: Platform.isMacOS 
          ? isNextButton
            ? S.of(context).projects_next_page_shortcut_tooltip_mac
            : S.of(context).projects_previous_page_shortcut_tooltip_mac
          : isNextButton 
            ? S.of(context).projects_next_page_shortcut_tooltip
            : S.of(context).projects_previous_page_shortcut_tooltip,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              width: 40,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.primaryContainer
              ),
              child: IconButton(
                onPressed: () {
                  if (canAppear) {
                    if (isNextButton) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 700), 
                        curve: Curves.fastEaseInToSlowEaseOut
                      );
                    }
                    else {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 700), 
                        curve: Curves.fastEaseInToSlowEaseOut
                      );
                    }
                  } 
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  )
                ),
                icon: Icon(icon, color: theme.onPrimary)
              ),
            ),
          ),
        ),
      ),
    );
  }
}