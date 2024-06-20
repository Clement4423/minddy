import 'package:flutter/material.dart';

class CustomBulletedListElementModel {
  String text;
  final int index;
  final bool isNew;
  final FocusNode focusNode;

  CustomBulletedListElementModel({
    required this.text,
    required this.index,
    required this.isNew,
    required this.focusNode,
  });
}
