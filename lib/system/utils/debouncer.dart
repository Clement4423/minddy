import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;
  Function? _callback;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(delay, () async {
      await _executeCallback();
    });
  }

  Future<void> _executeCallback() async {
    if (_timer!.isActive) {
      _timer!.cancel();
    }
    if (_callback != null) {
      await _callback!();
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}