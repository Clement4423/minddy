import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationListTileModel {
  String title;
  Icon icon;
  int index;
  String routeName;
  NavigationListTileModel({required this.title, required this.icon, required this.index, required this.routeName});
}