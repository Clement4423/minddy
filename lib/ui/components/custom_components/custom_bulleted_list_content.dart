import 'package:flutter/material.dart';
import 'package:minddy/system/model/custom_bulleted_list_element_model.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list_element_widget.dart';

class CustomBulletedListContent extends StatefulWidget {
  const CustomBulletedListContent({super.key, required this.controller});

  final CustomBulletedListController controller;

  @override
  State<CustomBulletedListContent> createState() => _ElementContentState();
}

class _ElementContentState extends State<CustomBulletedListContent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        widget.controller.content = widget.controller.buildListElementsModels(widget.controller.stringContent);
        _buildListElements(widget.controller, widget.controller.content, context);
        return Column(children: widget.controller.widgetContent);
      },
    );
  }
}


void _buildListElements(CustomBulletedListController controller, List<CustomBulletedListElementModel> list, BuildContext context) {
  double maxWidth = 500;
  List<CustomBulletedListElementWidget> listElementsList = [];
  for (int i = 0; i < list.length; i++) {
    listElementsList.add(
      CustomBulletedListElementWidget(
        key: UniqueKey(),
        initialText: list[i].text,
        index: list[i].index,
        focusNode: list[i].focusNode,
        controller: controller,
        isNew: list[i].isNew,
        maxWidth: maxWidth,
      ),
    );
  }
  controller.widgetContent = listElementsList;
}