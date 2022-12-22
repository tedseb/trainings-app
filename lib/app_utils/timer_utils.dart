import 'dart:async';

class StartTimer {
  Stream<int> stopWatchStream() {
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = const Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer?.cancel();
        timer = null;
        counter = 0;
        streamController?.close();
      }
    }

    void pauseTimer() {
      if (timer != null) {
        timer?.cancel();
      }
    }

    void tick(_) {
      counter++;
      streamController?.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    void resumeTimer() {
      if (timer != null) {
        if (!timer!.isActive) {
          timer = Timer.periodic(timerInterval, tick);
        }
      }
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: resumeTimer,
      onPause: pauseTimer,
    );

    return streamController.stream;
  }
}

class TimeLeft {
  String intToTimeLeft(int value, bool isHour) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hours = h.toString().length < 2 ? "0$h" : h.toString();
    String minutes = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    String resultIsHour = "$hours:$minutes:$seconds";
    String resultNotHour = "$minutes:$seconds";

    if (isHour) {
      return resultIsHour;
    } else {
      return resultNotHour;
    }
  }

  String intToTimeLeftSmall(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hours = h.toString().length < 2 ? "0$h" : h.toString();
    String minutes = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$hours:$minutes:$seconds";

    return result;
  }
}
