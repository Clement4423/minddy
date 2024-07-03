import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/model/custom_date_picker_mode.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/components/custom_components/custom_date_picker.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';

class AppDate {
  static Future<CustomDatePickerResult?> pickDate(BuildContext context, {DateTime? initialDate, DateTime? initialEndDate, String? title, CustomDatePickerMode mode = CustomDatePickerMode.single}) async {
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
        title: title,
        initialStartDate: initialDate,
        initialEndDate: initialEndDate,
        onSelected: (result) {
          completer.complete(result);
        }
      ), onMenuDismissed: () {
        completer.complete(null);
      }
    );
    return completer.future;
  }

  static Future<String> formatDateAsString(DateTime date, {bool includeTime = false}) async {
    try {
      bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;
      String dateAsString = '';
      if (useUsFormat) {
        dateAsString = '${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}-${date.year}';
      } else {
        dateAsString = '${date.day < 10 ? '0${date.day}' : date.day}-${date.month < 10 ? '0${date.month}' : date.month}-${date.year}';
      }

      if (includeTime) {
        dateAsString += ' ${date.hour}:${date.minute}';
      }

      return dateAsString;
    } catch (e) {
      await AppLogs.writeError('Unable to format date into string', 'app_date_picker.dart - formatDateAsString');
      return '';
    }
  }

  static Future<DateTime?> formatDateAsDateTime(String date, {bool includeTime = false}) async {
  try {
    bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;
    int day = int.parse(date.split('-')[useUsFormat ? 1 : 0]);
    int month = int.parse(date.split('-')[useUsFormat ? 0 : 1]);
    int year = int.parse(date.split('-').last.split(' ').first);

    if (year.toString().startsWith('0')) {
        year = int.parse(year.toString().replaceFirst('0', ''));
      }

    if (year.toString().length == 2) {
      if (year >= 10 && year < 100) {
        if (year <= int.parse(DateTime.now().year.toString().substring(2))) {
          year = 2000 + year;
        } else {
          year = 1900 + year;
        }
      }
    } else if (year.toString().length == 1) {
      if (year >= 0 && year < 10) {
        year = 2000 + year;
      }
    }

    if (year > 2300 || year < 1900) {
      return null;
    }

    if (day < 0 || day > 31) {
      return null;
    }

    if (month < 0 || month > 12) {
      return null;
    }
  
    DateTime? dateTime;
    if (includeTime) {
      int hour = int.parse(date.split('-').last.split(' ').last.split(':').first);
      int minute = int.parse(date.split('-').last.split(' ').last.split(':')[1]);
      dateTime = DateTime(year, month, day, hour, minute);
    } else {
      dateTime = DateTime(year, month, day);
    }
    return dateTime;
  } catch (e) {
    await AppLogs.writeError('Unable to format string into date', 'app_date_picker.dart - formatDateAsDateTime');
    return null;
  }
}
}
