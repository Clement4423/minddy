import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_bottom_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesBottomMenu extends StatefulWidget {
  final ArticlesBottomMenuController controller;
  const ArticlesBottomMenu({super.key, required this.controller});

  @override
  State<ArticlesBottomMenu> createState() => _ArticlesBottomMenuState();
}

class _ArticlesBottomMenuState extends State<ArticlesBottomMenu> {
  bool _isClosed = true;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // Check if the user is dragging upwards
        if (details.primaryDelta! < 0) {
          setState(() {
            _isClosed = false;
          });
        } else {
          setState(() {
            _isClosed = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
                child: AnimatedContainer(
                  constraints: const BoxConstraints(
                    maxWidth: 350
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubicEmphasized,
                  width: _isClosed ? screenWidth / 5 : 350,
                  height: _isClosed ? 56 : 300,
                  decoration: BoxDecoration(
                    color: theme.primaryContainer,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: theme.onPrimary.withValues(alpha: theme.brightness == Brightness.light ? 1 : 0.2),
                      width: 0.5
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Column(
                      children: [
                        // Top bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Buttons for pages buttons
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      // Sources
                                      SizedBox(
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            _isClosed = false;
                                            widget.controller.setCurrentSelected(0);
                                            widget.controller.setCurrentPage("/sources");
                                          },
                                          style: widget.controller.getActive(0)
                                              ? ButtonThemes.primaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0))
                                              : ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
                                          child: Text(
                                            S.of(context).articles_bottom_menu_sources_button,
                                            style: theme.bodyMedium.copyWith(
                                              color: widget.controller.getActive(0)
                                                  ? theme.onSecondary
                                                  : theme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Content
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () {
                                              _isClosed = false;
                                              widget.controller.setCurrentSelected(1);
                                              widget.controller.setCurrentPage("/content");
                                            },
                                            style: widget.controller.getActive(1)
                                                ? ButtonThemes.primaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0))
                                                : ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
                                            child: Text(
                                              S.of(context).articles_bottom_menu_content_button,
                                              style: theme.bodyMedium.copyWith(
                                                color: widget.controller.getActive(1)
                                                    ? theme.onSecondary
                                                    : theme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Notes
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () {
                                              _isClosed = false;
                                              widget.controller.setCurrentSelected(2);
                                              widget.controller.setCurrentPage("/notes");
                                            },
                                            style: widget.controller.getActive(2)
                                                ? ButtonThemes.primaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0))
                                                : ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
                                            child: Text(
                                              S.of(context).articles_bottom_menu_notes_button,
                                              style: theme.bodyMedium.copyWith(
                                                color: widget.controller.getActive(2)
                                                    ? theme.onSecondary
                                                    : theme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Button to open or close the menu
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isClosed = !_isClosed;
                                    });
                                  },
                                  tooltip: _isClosed 
                                  ? S.of(context).articles_bottom_menu_open_semantic_text
                                  : S.of(context).articles_bottom_menu_close_semantic_text,
                                  style: ButtonThemes.secondaryButtonStyle(context),
                                  icon: AnimatedRotation(
                                    duration: const Duration(milliseconds: 300),
                                    turns: _isClosed 
                                    ? 0
                                    : -0.5,
                                    child: Icon(Icons.keyboard_arrow_up_rounded,
                                        color: theme.onPrimary, 
                                        size: 24,
                                        semanticLabel: _isClosed 
                                          ? S.of(context).articles_bottom_menu_open_semantic_text
                                          : S.of(context).articles_bottom_menu_close_semantic_text,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Bottom menu content
                        if (!_isClosed)
                          widget.controller.currentPage
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
