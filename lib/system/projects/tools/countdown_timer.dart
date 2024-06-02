import 'dart:async';
import 'dart:ui';

class CountdownTimer {
  final int durationInSeconds;
  int _remainingTime;
  Timer? _timer;

  CountdownTimer({required this.durationInSeconds}) : _remainingTime = durationInSeconds;

  int get remainingTime => _remainingTime;

  void start(VoidCallback onTick) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        try {
          onTick();
        } catch(e) {
          return;
        }
      } else {
        timer.cancel();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
