// import 'dart:async';

// import 'package:higym/models/app_enum_models.dart';


// class AiContentStream {
//   Stream<PossibleAiScreens> aiScreen() {
//     StreamController<PossibleAiScreens>? streamController;
//     Timer? timer;
//     Duration timerInterval = const Duration(seconds: 1);
//     int counter = 0;

//     void stopTimer() {
//       if (timer != null) {
//         timer?.cancel();
//         timer = null;
//         counter = 0;
//         streamController?.close();
//       }
//     }

//     void pauseTimer() {
//       if (timer != null) {
//         timer?.cancel();
//         // counter = 0;
//         // streamController.close();
//       }
//     }

//     void tick(_) {
//       counter++;
//       streamController?.add(counter);
//     }

//     void startTimer() {
//       timer = Timer.periodic(timerInterval, tick);
//     }

//     void resumeTimer() {
//       if (timer != null) {
//         if (!timer!.isActive) {
//           timer = Timer.periodic(timerInterval, tick);
//         }
//       }
//     }

//     // int getTick(){
//     //   return counter;
//     // }

//     streamController = StreamController<int>(
//       onListen: startTimer,
//       onCancel: stopTimer,
//       onResume: resumeTimer,
//       onPause: pauseTimer,
//     );

//     return streamController.stream;
//   }


// }

