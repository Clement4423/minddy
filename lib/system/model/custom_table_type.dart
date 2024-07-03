import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';

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
  CustomTableType.date: S.current.projects_module_spreadsheet_data_type_date,
  CustomTableType.email: S.current.projects_module_spreadsheet_data_type_email,
  CustomTableType.number: S.current.projects_module_spreadsheet_data_type_number,
  CustomTableType.phoneNumber: S.current.projects_module_spreadsheet_data_type_phone_number,
  CustomTableType.selection: S.current.projects_module_spreadsheet_data_type_selection,
  CustomTableType.text: S.current.projects_module_spreadsheet_data_type_text,
  CustomTableType.url: S.current.projects_module_spreadsheet_data_type_url, 
}; 

Map<CustomTableType, Icon> customTableIcons = {
  CustomTableType.date: const Icon(Icons.date_range_rounded),
  CustomTableType.email: const Icon(Icons.email_outlined),
  CustomTableType.number: const Icon(Icons.numbers_rounded),
  CustomTableType.phoneNumber: const Icon(Icons.phone_rounded),
  CustomTableType.selection: const Icon(Icons.list_rounded),
  CustomTableType.text: const Icon(Icons.label_outline_rounded),
  CustomTableType.url: const Icon(Icons.link_rounded),
};