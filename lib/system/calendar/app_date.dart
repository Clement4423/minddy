import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/components/custom_components/custom_date_picker.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';

class AppDate {
  static Future<CustomDatePickerResult?> pickDate(BuildContext context, {DateTime? initialDate, DateTime? initialEndDate, String? title, CustomDatePickerMode mode = CustomDatePickerMode.single, bool useTime = false}) async {
    Completer<CustomDatePickerResult?> completer = Completer();

    if (title == null) {
      switch (mode) {
        case CustomDatePickerMode.single:
          title = S.of(context).custom_date_picker_select_single_date_title;
          break;
        default:
          title = S.of(context).custom_date_picker_select_multiples_date_title;
      }
    }
    await showSubMenu(
      context, 
      CustomDatePicker(
        key: UniqueKey(),
        title: title,
        initialStartDate: initialDate,
        initialEndDate: initialEndDate,
        mode: mode,
        useTime: useTime,
        onSelected: (result) {
          completer.complete(result);
        }
      ), 
      onMenuDismissed: () {
        completer.complete(null);
      }
    );
    return completer.future;
  }

  static String formatDateAsString(DateTime date) {
    try {
      return date.toIso8601String();
    } catch (e) {
      return '';
    }
  }

  static DateTime? formatDateAsDateTime(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> formatIso8601StringToPreferedDateFormatString(String iso8601String, [bool useTime = true]) async {
    try {
      bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;
      DateTime dateTime = DateTime.parse(iso8601String);

      String year = dateTime.year.toString();
      String month = padIfNecessary( dateTime.month);
      String day = padIfNecessary(dateTime.day);
      String hour = padIfNecessary(dateTime.hour);
      String minute = padIfNecessary(dateTime.minute);

      if (useUsFormat) {
        return '$month/$day/$year${useTime ? ' $hour:$minute' : ''}';
      } else {
        return '$day/$month/$year${useTime ? ' $hour:$minute' : ''}';
      }
    } catch (e) {
      return null;
    }
  }

  static Future<DateTime?> formatDateWithTheCorrectOrder(String date, [bool useTime = false]) async {
    try {
      // Determine the date format preference (US or not)
      bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;

      // Replace slashes with dashes to standardize the input
      date = date.replaceAll('/', '-');
      
      // Split the date and time parts if useTime is true
      List<String> dateTimeParts = date.split(' ');
      String datePart = dateTimeParts[0]; // The first part is the date
      String timePart = useTime && dateTimeParts.length > 1 ? dateTimeParts[1] : '';

      // Split the date by dashes
      List<String> dateParts = datePart.split('-');
      if (dateParts.length < 3) {
        throw const FormatException("Invalid date format");
      }

      // Parse day, month, and year based on the format
      int day = int.parse(dateParts[useUsFormat ? 1 : 0]);
      int month = int.parse(dateParts[useUsFormat ? 0 : 1]);
      int year = int.parse(dateParts[2].split(' ').first); // Ensure we only take the year part

      // Handle year if it starts with zero or is two digits
      if (year.toString().startsWith('0')) {
        year = int.parse(year.toString().replaceFirst('0', ''));
      }

      if (year.toString().length == 2) {
        if (year <= int.parse(DateTime.now().year.toString().substring(2))) {
          year = 2000 + year;
        } else {
          year = 1900 + year;
        }
      } else if (year.toString().length == 1) {
        year = 2000 + year;
      }

      // Validate and clamp day, month, and year
      day = day.clamp(1, 31);
      month = month.clamp(1, 12);
      year = year.clamp(1900, 2300);

      // Handle time if needed
      int hour = 0;
      int minute = 0;

      if (useTime && timePart.isNotEmpty) {
        List<String> timeParts = timePart.split(':');
        if (timeParts.length >= 2) {
          hour = int.parse(timeParts[0].toString()).clamp(0, 23);
          minute = int.parse(timeParts[1].toString()).clamp(0, 59);
        }
      }

      // Return the properly formatted DateTime object
      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String padIfNecessary(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return value.toString();
    }
  }
}