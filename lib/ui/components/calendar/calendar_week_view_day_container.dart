import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/ui/theme/theme.dart';

class CalendarWeekViewDayContainer extends StatelessWidget {
  const CalendarWeekViewDayContainer({
    super.key, 
    required this.width, 
    required this.height, 
    required this.date,
    required this.theme
  });

  final double width;
  final double height;
  final DateTime date;
  final StylesGetters theme;

  bool isToday() {
    DateTime now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isToday() 
          ? theme.secondary
          : theme.primaryContainer,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(
          intl.DateFormat('EEEE dd').format(date).replaceFirst(intl.DateFormat('EEEE dd').format(date).characters.first, intl.DateFormat('EEEE dd').format(date).characters.first.toUpperCase()),
          style: theme.titleMedium
            .copyWith(
              fontWeight: FontWeight.w600, 
              color: isToday() 
                ? theme.onSecondary 
                : theme.onPrimary
            ),
          overflow: TextOverflow.ellipsis
        ),
      ),
    );
  }
}