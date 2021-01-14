import 'dart:async';

import 'package:rx_notifier/rx_notifier.dart';

enum StopWatchMode { countDown, countUp }

class HomeController {
  Timer _timer;
  StopWatchMode _mode = StopWatchMode.countUp;

  final _seconds = RxNotifier<int>(0);
  final _minutes = RxNotifier<int>(0);
  final _hours = RxNotifier<int>(0);

  int get seconds => _seconds.value;
  int get minutes => _minutes.value;
  int get hours => _hours.value;

  final _oneSecond = const Duration(seconds: 1);

  final _isRunning = RxNotifier(false);
  bool get isRunning => _isRunning.value;

  void _countUpLogic() {
    _seconds.value++;

    if (seconds == 60) {
      _minutes.value++;
      _seconds.value = 0;
    }

    if (minutes == 60) {
      _hours.value++;
      _minutes.value = 0;
    }
  }

  void _countDownLogic() {
    if (minutes == 00 && seconds == 00) {
      // naturalClose = true;
      stop();
      return;
    } else if (seconds == 00) {
      _minutes.value--;
      _seconds.value = 59;
      return;
    }

    _seconds.value--;
  }

  void pause() {
    if (isRunning) {
      _isRunning.value = false;
      _timer.cancel();      
    } else {
      _isRunning.value = true;
      _timer = new Timer.periodic(_oneSecond, callback);
    }
  }

  void stop() {
    if (isRunning) {
      _isRunning.value = false;
      _timer.cancel();      
    }
  }

  void start() {
    if (!isRunning) {
      _isRunning.value = true;    
      _timer = new Timer.periodic(_oneSecond, callback);
    }
  }

  void callback(Timer timer) {
    if (_mode == StopWatchMode.countUp) {
      _countUpLogic();
    }
    else {
      _countDownLogic();
    }
  }

  void reset() {
    _hours.value = 0;
    _seconds.value = 0;
    _minutes.value = 0;
  }
}
