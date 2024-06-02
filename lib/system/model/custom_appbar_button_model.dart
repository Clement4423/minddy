import 'package:flutter/material.dart';

class CustomAppBarButtonModel {
  final String semanticText;

  final IconData icon;

  final bool isPrimary;

  final Function action;

  CustomAppBarButtonModel({
    required this.icon, 
    required this.semanticText, 
    required this.isPrimary, 
    required this.action
  });
}