import 'package:flutter/material.dart';

class CustomPopupItemModel {
  Text text;
  Icon icon;
  Function action;
  CustomPopupItemModel({
    required this.text, 
    required this.icon, 
    required this.action
  });
}