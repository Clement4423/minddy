/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:async';

import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class NotificationHandler {
  static final _controller = StreamController<List<NotificationState>>.broadcast();

  static Stream<List<NotificationState>> get notifications => _controller.stream;

  static final List<NotificationState> _notificationsList = [];

  static void addNotification(NotificationModel notification) {
    notification.id = createUniqueId();
    NotificationState state = NotificationState(
      model: notification, 
      timer: NotificationTimer(
        duration: convertDurationInSeconds(notification.duration)
      )
    );
    _notificationsList.add(state);
    _controller.add(_notificationsList);
  }

  static void removeNotification(NotificationModel notification) {
    try {
      _notificationsList.removeWhere((n) => n.model.id == notification.id);
      _controller.add(_notificationsList);
    } catch (e) {
      return;
    }
  }

  static int convertDurationInSeconds(NotificationDuration duration) {
    switch (duration) {
      case NotificationDuration.short:
        return 3;
      case NotificationDuration.long:
        return 15;
      case NotificationDuration.untilClosed:
        return -1;
    }
  }
}

class NotificationState {
  NotificationModel model;
  NotificationTimer timer;

  NotificationState({required this.model, required this.timer});
}

class NotificationModel {
  int id;
  String content;
  Function? action;
  String actionLabel;
  NotificationDuration duration;

  NotificationModel({required this.content, required this.action, required this.actionLabel, required this.duration, this.id = 0});
}

class NotificationTimer {
  int duration;
  double _remainingTime = 0;
  Timer? timer;
  Function(double)? onTick;

  double get remainingTime => _remainingTime;

  NotificationTimer({required this.duration, this.onTick}) {
    _remainingTime = duration.toDouble();
  }

  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_remainingTime > 0) {
        _remainingTime -= 0.02;
        try {
          if (onTick != null) {
            onTick!(_remainingTime);
          }
        } catch (e) {
          return;
        }
      } else {
        stop();
      }
    });
  }

  void stop() {
    timer?.cancel();
  }
}