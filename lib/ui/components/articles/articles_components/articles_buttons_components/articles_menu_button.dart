import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            child: SizedBox(
              width: 145,
              height: 35,
              child: ElevatedButton.icon(
                onPressed: () {showArticles(context);}, 
                // ignore: deprecated_member_use
                icon: SvgPicture.asset("assets/logo/articles/logo_articles.svg", width: 30, color: theme.onPrimary,), 
                label: Text(
                  "Articles", 
                  style: theme.titleMedium.
                  copyWith(color: theme.onPrimary),
                ),
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(12),
                  backgroundColor: MaterialStatePropertyAll(theme.primaryContainer),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}