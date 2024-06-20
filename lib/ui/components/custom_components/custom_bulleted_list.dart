import 'package:flutter/material.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list_content.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list_controller.dart';

// ignore: must_be_immutable
class CustomBulletedList extends StatefulWidget implements IArticlesWriteElement {
  final List<dynamic>? initialContent;
  late final CustomBulletedListController controller;

  @override
  dynamic get data => controller.stringContent;

  CustomBulletedList({
    super.key,
    this.initialContent,
  }) {
    controller =  CustomBulletedListController(initialContent ?? []);
  }

  @override
  State<CustomBulletedList> createState() => _CustomBulletedListState();
  
  @override
  set data(newData) {}
}

class _CustomBulletedListState extends State<CustomBulletedList> {

  @override
  void initState() {
    widget.data = widget.controller.stringContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: CustomBulletedListContent(controller: widget.controller),
    );
  }
}
