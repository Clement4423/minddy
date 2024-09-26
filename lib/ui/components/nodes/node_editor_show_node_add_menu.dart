import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_node_widget.dart';
import 'package:minddy/ui/components/menus/sub_menus/node_editor_new_node_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

Future<INodeWidget?> showNodeEditorAddMenu(BuildContext context, List<NodeEditorNewNodeSubMenuNodeModel> nodesToShow, StylesGetters theme, Function(INodeWidget?) onSelected, bool autosearch) async {
  Completer<INodeWidget?> completer = Completer<INodeWidget?>();

  showSubMenu(
    context, 
    onMenuDismissed: () {
      completer.complete(null);
    },
    NodeEditorNewNodeSubMenu(
      onSelected: (INodeWidget? node) {
        onSelected(node);
        completer.complete(node);
      },
      nodesToShow: nodesToShow,
      onClosed: () {
        Navigator.pop(context);
      },
      autosearch: autosearch,
      theme: theme,
    ),
  );

  return completer.future;
}