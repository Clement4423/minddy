import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomSelectionMenuTooltip extends StatefulWidget {
  const CustomSelectionMenuTooltip({
    super.key,
    required this.item,
    required this.theme,
    required this.itemHeight
  });

  final CustomSelectionMenuItem item;
  final double itemHeight;
  final StylesGetters theme;

  static double calculateTooltipHeight(CustomSelectionMenuItem item, StylesGetters theme) {
    double height = 0.0;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: item.tooltip?.title ?? '',
        style: item.labelStyle ?? theme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    textPainter.layout(maxWidth: 180);
    
    height += textPainter.height;

    textPainter = TextPainter(
      text: TextSpan(
        text: item.tooltip?.text ?? '',
        style: item.labelStyle ?? theme.bodyMedium.copyWith(color: theme.onPrimary),
      ),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(maxWidth: 179);
    
    height += textPainter.height;

    height += 16 + 1 + (item.tooltip?.title != null ? 5 : 0); // + Padding + Border + Title padding

    return height;
  }

  @override
  State<CustomSelectionMenuTooltip> createState() => _CustomSelectionMenuTooltipState();
}

class _CustomSelectionMenuTooltipState extends State<CustomSelectionMenuTooltip> {

  double _menuHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _menuHeight = CustomSelectionMenuTooltip.calculateTooltipHeight(widget.item, widget.theme);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 200,
          height: _menuHeight,
          constraints: BoxConstraints(
            minHeight: widget.itemHeight,
          ),
          decoration: BoxDecoration(
            color: widget.item.tooltip?.backgroundColor ?? widget.theme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: widget.item.tooltip?.border ?? Border.all(
              color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.4),
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignInside
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: widget.item.tooltip?.title != null ? 5 : 0),
                  child: Text(
                    widget.item.tooltip?.title ?? '',
                    style: widget.item.labelStyle?.copyWith(color: widget.item.tooltip?.foregroundColor ?? widget.theme.onPrimary, fontWeight: FontWeight.w600) ?? widget.theme.bodyMedium
                      .copyWith(color: widget.theme.onPrimary, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  widget.item.tooltip?.text ?? '',
                  style: widget.item.labelStyle?.copyWith(color: widget.item.tooltip?.foregroundColor ?? widget.theme.onPrimary) ?? widget.theme.bodyMedium
                    .copyWith(color: widget.theme.onPrimary),
                  overflow: TextOverflow.fade
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}