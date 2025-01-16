import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomHappensOnPicker extends StatefulWidget {
  const CustomHappensOnPicker({
    super.key, 
    required this.recurenceType, 
    required this.onSelected,
    required this.theme,
    required this.happensOn
  });

  final CalendarEventRecurenceType recurenceType;
  final Function(List<int>) onSelected;
  final StylesGetters theme;
  final List<int> happensOn;

  @override
  State<CustomHappensOnPicker> createState() => _CustomHappensOnPickerState();
}

class _CustomHappensOnPickerState extends State<CustomHappensOnPicker> {

  List<int> selected = [];

  List<String> vowels = ['a', 'e', 'i', 'o', 'u', 'y'];

  @override
  void initState() {
    selected = widget.happensOn;
    super.initState();
  }

  String getWeekdayName(int dayNumber) {  
    DateTime date = DateTime(2023, 1, dayNumber);
    String text = intl.DateFormat('EEEE').format(date);
    String firstLetter = text.characters.first;
    return '${firstLetter.toUpperCase()}${text.substring(1)}';
  }

  String getMonthName(int monthNumber) {
    DateTime date = DateTime(2025, monthNumber, 1);
    String text = intl.DateFormat('MMMM').format(date);
    String firstLetter = text.characters.first;
    String name = '${firstLetter.toUpperCase()}${text.substring(1)}';
    if (name.length > 4) {
      String fourLettersName = name.substring(0, 4);
      if (vowels.contains(fourLettersName.characters.last)) {
        return '${fourLettersName.substring(0, 3)}.';
      } else {
        return '$fourLettersName.';
      }
    } else {
      return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.recurenceType) {
      case CalendarEventRecurenceType.weekly:
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 350,
              child: Column(
                children: [
                  ...List.generate(7, (index) {
                    int selectedIndex = index + 1;
                    return ListTile(
                      splashColor: Colors.transparent,
                      tileColor: selected.contains(selectedIndex) 
                        ? widget.theme.secondary
                        : widget.theme.surface,
                      textColor: selected.contains(selectedIndex) 
                        ? widget.theme.onSecondary
                        : widget.theme.onSurface,
                      onTap: () {
                        if (selected.contains(selectedIndex)) {
                          if (selected.length > 1) {
                            selected.remove(selectedIndex);
                          }
                        } else {
                          selected.add(selectedIndex);
                        }
                        setState(() {});
                        widget.onSelected(selected);
                      },
                      title: Text(
                        getWeekdayName(index + 2),
                        style: widget.theme.bodyMedium
                          .copyWith(
                            color: selected.contains(selectedIndex) 
                              ? widget.theme.onSecondary
                              : widget.theme.onSurface
                          ),
                      ),
                      
                      trailing: selected.contains(selectedIndex) 
                        ? Icon(Icons.check_rounded, color: widget.theme.onSecondary)
                        : null
                    );
                  })
                ],
              ),
            ),
          ),
        );
      case CalendarEventRecurenceType.monthly: 
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: 350,
            height: 5 * 45.5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 45,
                crossAxisCount: 7,
                crossAxisSpacing: 0.5,
                mainAxisSpacing: 0.5
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 35,
              itemBuilder: (context, index) {
                int selectedIndex = index + 1;
                if (selectedIndex > 31) {
                    return Container(
                    width: 50,
                    height: 45,
                    decoration: BoxDecoration(
                      color: widget.theme.surface.withValues(alpha: 0.5),
                    ),
                  );
                }
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (selected.contains(selectedIndex)) {
                        if (selected.length > 1) {
                          selected.remove(selectedIndex);
                        }
                      } else {
                        selected.add(selectedIndex);
                      }
                      setState(() {});
                      widget.onSelected(selected);
                    },
                    child: Container(
                      width: 50,
                      height: 45,
                      decoration: BoxDecoration(
                        color: selected.contains(selectedIndex) 
                          ? widget.theme.secondary
                          : widget.theme.surface,
                      ),
                      child: Center(
                        child: Text(
                          selectedIndex.toString(),
                          style: widget.theme.bodyMedium
                            .copyWith(
                              color: selected.contains(selectedIndex) 
                                ? widget.theme.onSecondary
                                : widget.theme.onSurface,
                            ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        );
      case CalendarEventRecurenceType.yearly:
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: 350,
            height: 3 * 45.5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 45,
                crossAxisCount: 4,
                crossAxisSpacing: 0.5,
                mainAxisSpacing: 0.5
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                int selectedIndex = index + 1;
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (selected.contains(selectedIndex)) {
                        if (selected.length > 1) {
                          selected.remove(selectedIndex);
                        }
                      } else {
                        selected.add(selectedIndex);
                      }
                      setState(() {});
                      widget.onSelected(selected);
                    },
                    child: Container(
                      width: 50,
                      height: 45,
                      decoration: BoxDecoration(
                        color: selected.contains(selectedIndex) 
                          ? widget.theme.secondary
                          : widget.theme.surface,
                      ),
                      child: Center(
                        child: Text(
                          getMonthName(selectedIndex),
                          style: widget.theme.bodyMedium
                            .copyWith(
                              color: selected.contains(selectedIndex) 
                                ? widget.theme.onSecondary
                                : widget.theme.onSurface,
                            ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}