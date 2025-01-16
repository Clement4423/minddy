import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/calendar/app_date.dart';
import 'package:minddy/system/model/calendar_event.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomRecIntervalPicker extends StatefulWidget {
  const CustomRecIntervalPicker({
    super.key,
    required this.theme,
    required this.onSelected,
    required this.value,
    required this.recurenceType
  });

  final StylesGetters theme;
  final int value;
  final Function(int) onSelected;
  final CalendarEventRecurenceType recurenceType;

  @override
  State<CustomRecIntervalPicker> createState() => _CustomRecIntervalPickerState();
}

class _CustomRecIntervalPickerState extends State<CustomRecIntervalPicker> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  int selected = 1;

  GlobalKey key = GlobalKey();

  OverlayEntry? entry;

  late PageController intervalController = PageController(viewportFraction: 0.25, initialPage: selected - 1);

  void _confirmSelection() {
    _controller.reverse().then((_) {
      entry?.remove();
      entry = null;
      widget.onSelected(selected);
    });
  }

  int minValue = 1;

  int maxValue = 500;

  String getunitLabel(int interval) {
    switch (widget.recurenceType) {
      case CalendarEventRecurenceType.daily:
        return S.current.calendar_new_event_recurence_every_day(interval);
      case CalendarEventRecurenceType.weekly:
        return S.current.calendar_new_event_recurence_every_week(interval);
      case CalendarEventRecurenceType.monthly:
        return S.current.calendar_new_event_recurence_every_month(interval);
      case CalendarEventRecurenceType.yearly:
        return S.current.calendar_new_event_recurence_every_year(interval);
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var buttonSize = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    double width = 300;
    double height = 200;

    Size screensize = MediaQuery.of(context).size;

    double top = offset.dy - (height / 2) + (buttonSize.height / 2);
    double left = offset.dx  - (width / 2) + (buttonSize.width / 2);

    if (top + height + 45 > screensize.height) {

      top = screensize.height - height - 45;
    }

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _confirmSelection,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: ScaleTransition(
                scale: _animation,
                child: Container(
                  width: width,
                  height: height + 45,
                  decoration: BoxDecoration(
                    color: widget.theme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.theme.onPrimary.withValues(alpha: widget.theme.brightness == Brightness.light ? 1 : 0.2),
                      width: 0.5
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Stack(
                        children: [
                          Positioned(
                            top: (height / 2) - 20,
                            left: width - (width - 7.5),
                            child: Container(
                              width: width - 15,
                              height: 40,
                              decoration: BoxDecoration(
                                color: widget.theme.surface,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    getunitLabel(selected),
                                    textAlign: TextAlign.end,
                                    style: widget.theme.titleLarge
                                      .copyWith(color: widget.theme.onSurface),
                                  ),
                                ),
                              ),
                            )
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: PageView(
                              scrollDirection: Axis.vertical,
                              controller: intervalController,
                              pageSnapping: true, 
                              onPageChanged: (index) {
                                selected = index + 1;
                              },
                              allowImplicitScrolling: true,
                              children: List.generate(maxValue, (index) => Container(
                                  width: 10, 
                                  height: 15, 
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent
                                  ),
                                  child: Center(
                                      child: Text(
                                        AppDate.padIfNecessary((index + 1)),
                                        style: widget.theme.titleLarge
                                          .copyWith(color: widget.theme.onPrimary),
                                      )
                                    ),
                                )
                              )
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: SizedBox(
                              width: width,
                              height: (height / 2) - 20, 
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: SizedBox(
                                    width: width,
                                    height: (height / 2) - 20,
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            bottom: 45,
                            child: SizedBox(
                              width: width,
                              height: (height / 2) - 20, 
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: SizedBox(
                                    width: width,
                                    height: (height / 2) - 20,
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            top: height + 5,
                            left: width - (width - 7.5),
                            width: width - 15,
                            height: 30,
                            child: CustomTextButton(
                              S.of(context).submenu_artilces_image_description_button, 
                              _confirmSelection,
                              false, 
                              false
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      )
    ); 
  }

  void _showOverlayMenu(BuildContext context) {
    entry = _createOverlayEntry(context);
    Overlay.of(context).insert(entry!);

    _controller.forward();
  }

  @override
  void initState() {
    selected = widget.value;
     _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200)
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showOverlayMenu(context);
        },
        child: Text(
          key: key,
          '$selected ${getunitLabel(selected)}',
          style: widget.theme.bodyMedium
            .copyWith(color: widget.theme.onPrimary),
          overflow: TextOverflow.ellipsis
        ),
      ),
    );
  }
}
