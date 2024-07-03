import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomInputDatePicker extends StatefulWidget {
  const CustomInputDatePicker({super.key, required this.onCompleted, required this.initialValue});

  final Function(DateTime?) onCompleted; 
  final DateTime? initialValue;

  @override
  State<CustomInputDatePicker> createState() => _CustomInputDatePickerState();
}

class _CustomInputDatePickerState extends State<CustomInputDatePicker> {

  String date = '';

  String hint = '';
  
  bool hasError = false;

  getHint() {
    AppDate.formatDateAsString(DateTime.now()).then((value) => setState(() {
      hint = formatToDashFormat(value);
    }));
  }

  String formatToDashFormat(String text) {
    return text.replaceAll(RegExp(r'[-./ _:,.]'), '-');
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      AppDate.formatDateAsString(widget.initialValue!)
      .then((value) => setState(() {
        date = formatToDashFormat(value);
      }));
    }
    getHint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: 150,
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.primary,
        border: hasError ? Border.all(color: theme.error) : null,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: CustomTooltip(
          message: date.isNotEmpty ? hasError ? S.of(context).custom_date_picker_invalid_date : '' : '',
          textColor: theme.onError,
          background: theme.error,
          child: TextSelectionTheme(
            data: TextSelectionThemeData(
              selectionColor: theme.secondary.withOpacity(0.5)
            ),
            child: TextField(
              controller: TextEditingController(text: date.replaceAll('-', '/')),
              onChanged: (value) {
                date = value;
                if (date.isEmpty) {
                  setState(() {
                    hasError = false;
                  });
                }
              },
              style: theme.bodyMedium,
              cursorColor: theme.onPrimary,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint.replaceAll('-', '/'),
              ),
              onEditingComplete: () async {
                if (date.isEmpty) {
                  return;
                }
                DateTime? formated = await AppDate.formatDateAsDateTime(formatToDashFormat(date));
                if (formated != null) {
                  if (hasError) {
                    setState(() {
                      hasError = false;
                    });
                  }
                  await widget.onCompleted(formated);
                } else {
                  setState(() {
                    hasError = true;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}