import 'package:flutter/material.dart';

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  } else {
    String firstLetter = text.characters.first.toUpperCase();
    return '$firstLetter${text.substring(1)}';
  }
}