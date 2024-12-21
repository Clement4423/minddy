import 'package:flutter/material.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomDatePickerDayContainer extends StatefulWidget {
  const CustomDatePickerDayContainer({
    super.key,
    required this.theme, 
    required this.date, 
    required this.isSelected, 
    required this.isSelectable, 
    required this.isGreyedOut, 
    required this.isInRange, 
    required this.isEndDate,
    required this.startDate,
    required this.endDate,
    required this.isToday,
    required this.onSelected, 
    required this.onGreyedOutDayClicked
    });

  final StylesGetters theme;

  final DateTime date;

  final bool isSelected;
  final bool isSelectable;
  final bool isGreyedOut;
  final bool isInRange;
  final bool isEndDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isToday;
  final Function(DateTime, bool) onSelected;
  final Function(DateTime, bool) onGreyedOutDayClicked; 

  @override
  State<CustomDatePickerDayContainer> createState() => _DayContainerState();
}

class _DayContainerState extends State<CustomDatePickerDayContainer> {

  bool isHovering = false;

  Color getHoverColor() {
    if (!widget.isSelectable || widget.isSelected || !isHovering) {
      return Colors.transparent;
    }

    return widget.theme.secondary;
  }

  Color? getColor() {
    if (widget.isSelected) {
      return widget.theme.secondary;
    } 

    if (widget.isToday) {
      return widget.isInRange 
        ? widget.theme.secondary.withValues(alpha: 0.3) 
        : DefaultAppColors.blue.color.withValues(alpha: 0.2);
    } 
    
    return widget.isInRange 
        ? widget.theme.secondary.withValues(alpha: 0.3) 
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              isHovering = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovering = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: !widget.isSelectable ? null : widget.isGreyedOut 
              ? () => widget.onGreyedOutDayClicked(widget.date, widget.isEndDate) 
              : () => widget.onSelected(widget.date, widget.isEndDate),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: getColor(),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: getHoverColor())
              ),
              child: Center(
                child: Text(
                  widget.date.day.toString(),
                  style: TextStyle(
                    color: (widget.isGreyedOut || !widget.isSelectable) 
                      ? widget.theme.onPrimary.withValues(alpha: 0.3) 
                      : widget.isSelected 
                        ? widget.theme.onSecondary 
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}