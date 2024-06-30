import 'package:flutter/material.dart';

enum CustomTableType {
  text,
  number,
  phoneNumber,
  email,
  url,
  date,
  selection
}

Map<CustomTableType, String> customTableNames = {
  CustomTableType.date: 'date',
  CustomTableType.email: 'email',
  CustomTableType.number: 'number',
  CustomTableType.phoneNumber: 'phone number',
  CustomTableType.selection: 'selection',
  CustomTableType.text: 'text',
  CustomTableType.url: 'url',
}; 

Map<CustomTableType, Icon> customTableIcons = {
  CustomTableType.date: const Icon(Icons.date_range_rounded),
  CustomTableType.email: const Icon(Icons.email_outlined),
  CustomTableType.number: const Icon(Icons.numbers_rounded),
  CustomTableType.phoneNumber: const Icon(Icons.phone_rounded),
  CustomTableType.selection: const Icon(Icons.list_rounded),
  CustomTableType.text: const Icon(Icons.label_outline_rounded),
  CustomTableType.url: const Icon(Icons.web_rounded),
};