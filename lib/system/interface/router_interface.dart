import 'package:flutter/material.dart';

abstract class IRouter {
  final Map<String, dynamic> routes = {};
  Widget navigateTo(String route, {BuildContext? context});
  Widget navigateToCustomPage(String route, dynamic argument);
}
