import 'package:flutter/material.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';

class NotificationsBuilder extends StatefulWidget {
  const NotificationsBuilder({
    super.key,
    required this.notifications
  });

  final List<NotificationState> notifications;

  @override
  State<NotificationsBuilder> createState() => _NotificationsBuilderState();
}

class _NotificationsBuilderState extends State<NotificationsBuilder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StylesGetters theme = StylesGetters(context);
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.notifications.map((notification) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: NotificationWidget(
                  key: UniqueKey(),
                  state: notification,
                  theme: theme
                ),
              );
            })
          ],
        ),
      )
    );
  }
}