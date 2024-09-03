import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesMenuButton extends StatelessWidget {
  const ArticlesMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.onPrimary.withOpacity(0.2),
                  width: 0.5
                )
              ),
              child: ElevatedButton.icon(
                onPressed: () {showArticles(context);}, 
                // ignore: deprecated_member_use
                icon: SvgPicture.asset("assets/logo/articles/logo_articles.svg", width: 30, color: theme.onPrimary,), 
                label: Text(
                  S.of(context).default_articles_articles_title, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.titleMedium.
                  copyWith(color: theme.onPrimary),
                ),
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(12),
                  backgroundColor: WidgetStatePropertyAll(theme.primaryContainer),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}