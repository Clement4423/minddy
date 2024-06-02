import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/theme/theme.dart';

/// Creates a back button that will pop the context when clicked
class ArticlesBackButton extends StatelessWidget {
  final Function? action;
  const ArticlesBackButton({this.action ,super.key});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () async {
          if (action != null) {
            await action!();
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        }, 
        tooltip: S.of(context).articles_go_back_semantic_text,
        icon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary, semanticLabel: S.of(context).articles_go_back_semantic_text,),
        style: ButtonThemes.secondaryButtonStyle(context).copyWith(backgroundColor: MaterialStatePropertyAll(theme.primaryContainer)),
      ),
    );
  }
}