import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_date_picker_result.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableDateCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableDateCell({super.key, required this.initialValue, required this.theme, required this.cellHeight, required this.cellWidth, required this.controller}) {
    data = initialValue;
  }

  final String? initialValue;

  final double cellHeight;
  final double cellWidth;

  final CustomTableController controller;

  final StylesGetters theme;

  @override
  var data = '';

  @override
  State<CustomTableDateCell> createState() => _CustomTableDateCellState();
}

class _CustomTableDateCellState extends State<CustomTableDateCell> {

  Future<String> formatDateInAUserFriendlyWay() async {
    if (widget.data == null || widget.data as String == '') {
      return '';
    }

    DateTime? date = await AppDate.formatDateAsDateTime(widget.data);

    bool useUsFormat = await AppConfig.getConfigValue('prefer_us_date_format') ?? false;

    String newString = widget.data;
    if (date != null) {
      if (useUsFormat) {
        newString = '${DateFormat('MMMM').format(date)} ${date.day} ${date.year}';
      } else {
        newString = '${date.day} ${DateFormat('MMMM').format(date)} ${date.year}';
      }
    }
    return newString;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
            CustomDatePickerResult? result = await AppDate.pickDate(
            // ignore: use_build_context_synchronously
            context, 
            initialDate: widget.data == null 
              ? null
              : widget.data as String != ''
                ? await AppDate.formatDateAsDateTime(widget.data)
                : null
            );
    
            if (result != null) {
              String resultAsString = await AppDate.formatDateAsString(result.selectedDates.first);
              widget.data = resultAsString;
              if (context.mounted) {
                setState(() {});
              } else {
                widget.controller.saveCells();
              }
            } else {
              widget.data = null;
              if (context.mounted) {
                setState(() {});
              } else {
                widget.controller.saveCells();
              }
            }      
        }, 
        child: Center(
          child: Container(
            constraints: BoxConstraints(minWidth: widget.cellWidth, minHeight: widget.cellHeight),
            padding: EdgeInsets.symmetric(vertical: widget.cellHeight / 2 - 12),
            child: FutureBuilder<String>(
              future: formatDateInAUserFriendlyWay(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '',
                  style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}