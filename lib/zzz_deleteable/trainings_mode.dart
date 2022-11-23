// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:higym/app_utils/styles.dart';
// import 'package:higym/app_utils/timer_utils.dart';
// import 'package:higym/models/app_user.dart';
// import 'package:higym/models/goal.dart';
// import 'package:higym/training_screens/exercise_info_screen.dart';
// import 'package:higym/training_screens/leave_exercise_screen.dart';
// import 'package:higym/training_screens/rpe_scale.dart';
// import 'package:higym/training_screens/training_ended_screen.dart';
// import 'package:higym/widgets/general_widgets/loading_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
// import 'dart:developer' as dev;

// class TrainingsMode extends StatefulWidget {
//   const TrainingsMode({
//     Key? key,
//     required this.selectedPlan,
//   }) : super(key: key);

//   final Map<String, dynamic> selectedPlan;

//   @override
//   State<TrainingsMode> createState() => _TrainingsModeState();
// }

// class _TrainingsModeState extends State<TrainingsMode> {
//   AppUser? user;

//   ///TrainingsPlan Data
//   late Plans selectedPlan;
//   late int selectedExerciseIndex;
//   late List<int> doingExeIndexList;
//   int doingExeIndexListLength = 0;
//   int doingExeIndex = 0;
//   String toDay = DateFormat('yyyy-MM-dd').format(DateTime.now());

//   /// Training Screen Data
//   late String exerciseName;
//   late String exerciseSubName;
//   late String prepareFor;
//   late int actualSetNumber;
//   late int repetitionsToDo;
//   late int trainTimeToDo;
//   late int restTimeToDo;
//   late double weighthToDo;

//   /// UI Screen Data
//   Color modeColor = Styles.pastelGreen;
//   double progressIndicatorValue = 0;
//   Color progressIndicatorColor = Styles.white;
//   String progressIndicatorText = 'rep';
//   int toDoValue = 0;
//   int doneValue = 0;
//   int doneTime = 0;
//   VideoPlayerController? _vpController;
//   IconData playDoneButton = Icons.play_circle_fill_rounded;
//   Completer<void>? buttonCompleter;
//   bool doLater = false;

//   /// Timer
//   Stream<int>? globalTimeStream;
//   StreamSubscription<int>? globalTimeSubscription;
//   Stream<int>? smallTimeStream;
//   StreamSubscription<int>? smallTimeSubscription;

//   @override
//   void initState() {
//     super.initState();

//     ///Set Plan Data
//     selectedPlan = Plans.plansFromJson(widget.selectedPlan);
//     selectedPlan.time = 0;
//     for (Exercises exe in selectedPlan.exercises) {
//       exe.rpeScale[toDay] = 2;
//       // selectedPlan.exercises[exeIndex].rpeScale[toDay] = addNewValue;
//     }

//     /// Set toDo ExerciseList
//     doingExeIndexList = List.generate(
//       selectedPlan.exercises.length,
//       (exeIndex) => exeIndex,
//       growable: true,
//     );
//     doingExeIndexListLength = selectedPlan.exercises.length;

//     newExerciseDataUpdater(exeIndex: 0, initExercise: true);
//     setExerciseVideo();
//   }

//   @override
//   void dispose() {
//     _vpController!.dispose();
//     // endTraining();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     user = Provider.of<AppUser?>(context);
//     return WillPopScope(
//       onWillPop: () async {
//         return await helper_utils.myBottomSheet(context, LeaveExerciseScreen(leaveTraining: true, endTraining: endTraining));
//       },
//       child: Scaffold(
//         backgroundColor: modeColor,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// TopBar Close - Skip - Buttons
//             Container(
//               height: 100,
//               padding: const EdgeInsets.only(left: 16.0, top: 26.0, right: 16.0, bottom: 30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     iconSize: 32,
//                     icon: Styles.closeIcon,
//                     onPressed: () async {
//                       await helper_utils.myBottomSheet(context, LeaveExerciseScreen(leaveTraining: true, endTraining: endTraining));
//                     },
//                   ),
//                   IconButton(
//                     iconSize: 32,
//                     icon: Styles.skipIcon,
//                     onPressed: () async {
//                       await helper_utils.myBottomSheet(
//                         context,
//                         LeaveExerciseScreen(leaveTraining: false, nextExercise: doneButtonPressed, endTraining: endTraining),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             /// Exercise Informations
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 40.0,
//                     child: ElevatedButton(
//                       onPressed: () => openExerciseInfo(),
//                       style: ElevatedButton.styleFrom(
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(8.0),
//                             bottomRight: Radius.circular(8.0),
//                           ),
//                           side: BorderSide.none,
//                         ),
//                         primary: Styles.white,
//                         onPrimary: Styles.white,
//                         elevation: 0.0,
//                         minimumSize: Size.zero,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text(
//                           'i',
//                           style: TextStyle(
//                             color: modeColor,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 38,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(prepareFor, style: Styles.exercisingSubTitle),
//                         Text(
//                           helper_utils.truncateExerciseName(exerciseName, Styles.exercisingTitle, MediaQuery.of(context).size.width),
//                           style: Styles.exercisingTitle,
//                         ),
//                         Text(
//                           exerciseSubName,
//                           style: Styles.exercisingTitle,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Expanded(
//                     child: SizedBox(),
//                   ),
//                   const SizedBox(
//                     height: 125,
//                     child: VerticalDivider(
//                       color: Styles.white,
//                       thickness: 1.5,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 90.0,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '$actualSetNumber.',
//                                 style: Styles.exercisingTitle,
//                               ),
//                               Text(
//                                 'set',
//                                 style: Styles.exercisingTitle,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 weighthToDo.toString(),
//                                 style: Styles.exercisingTitle,
//                               ),
//                               Text(
//                                 'kg',
//                                 style: Styles.exercisingTitle,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 repetitionsToDo.toString(),
//                                 style: Styles.exercisingTitle,
//                               ),
//                               Text(
//                                 progressIndicatorText,
//                                 style: Styles.exercisingTitle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             /// Progress Indicator
//             Expanded(
//               child: !_vpController!.value.isInitialized
//                   ? const LoadingWidget()
//                   : Stack(
//                       children: [
//                         /// Video
//                         Center(
//                           child: ColorFiltered(
//                             colorFilter: ColorFilter.mode(modeColor, BlendMode.modulate),
//                             child: AspectRatio(
//                               aspectRatio: _vpController!.value.aspectRatio,
//                               child: VideoPlayer(_vpController!),
//                             ),
//                           ),
//                         ),

//                         /// Circle
//                         Center(
//                           child: SizedBox(
//                             height: (MediaQuery.of(context).size.height / 10) * 3,
//                             width: (MediaQuery.of(context).size.height / 10) * 3,
//                             child: CircularProgressIndicator(
//                               value: progressIndicatorValue,
//                               color: progressIndicatorColor,
//                               strokeWidth: 8.0,
//                             ),
//                           ),
//                         ),

//                         /// Counter
//                         Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 toDoValue.toString(),
//                                 style: TextStyle(color: progressIndicatorColor, fontSize: 100.0, fontWeight: FontWeight.w300),
//                               ),
//                               Text(
//                                 progressIndicatorText,
//                                 style: TextStyle(color: progressIndicatorColor, fontSize: 21.0, fontWeight: FontWeight.w600, height: 0.3),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//             ),

//             ///Play Button
//             Container(
//               height: 105,
//               padding: const EdgeInsets.only(bottom: 18.0),
//               child: IconButton(
//                 onPressed: () {
//                   if (globalTimeStream == null) {
//                     startPlan();
//                   } else {
//                     doneButtonPressed();
//                   }
//                 },
//                 iconSize: 72,
//                 icon: Icon(
//                   playDoneButton,
//                   color: Styles.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> startPlan() async {
//     startGlobalTimer();

//     for (int doingExe = 0; doingExe < doingExeIndexListLength; doingExe++) {
//       doingExeIndex = doingExe;
//       if (!doLater) {
//         setState(() {
//           playDoneButton = Icons.check_circle_rounded;
//         });
//         await startExercise();
//       } else {
//         setState(() {
//           doLater = false;
//         });
//       }
//     }
//     endTraining();
//   }

//   Future<void> startExercise() async {
//     Exercises selectedExercise = selectedPlan.exercises[selectedExerciseIndex];
//     int setsLength = selectedExercise.sets.length - 1;
//     for (int setIndex = 0; setIndex <= setsLength; setIndex++) {
//       /// Trainings Screen
//       newDoingDataUpdater(pauseMode: false, set: setIndex);
//       await waitUserForDoneButtonPress();
//       // Fill Repetitions and Trainings TimeDone after done Button Pressed
//       selectedPlan.exercises[selectedExerciseIndex].sets[setIndex].repetitions[toDay] =
//           selectedPlan.exercises[selectedExerciseIndex].repetitionsScale['actualToDo']!;
//       selectedPlan.exercises[selectedExerciseIndex].sets[setIndex].setTime[toDay] = doneTime;

//       /// Pause Screen
//       if (setIndex < setsLength) {
//         newDoingDataUpdater(pauseMode: true, set: setIndex);
//         await waitUserForDoneButtonPress();
//         // Fill Rest Time after done Button Pressed
//         selectedPlan.exercises[selectedExerciseIndex].sets[setIndex].setRestTime[toDay] = doneTime;
//       }
//     }

//     /// Exercise Pause Screen
//     bool notLastExe = doingExeIndex < (doingExeIndexListLength - 1);
//     if (notLastExe) {
//       newExerciseDataUpdater(exeIndex: doingExeIndex + 1, initExercise: false);
//     }
//     showModalBottomSheet(
//       isScrollControlled: true,
//       enableDrag: false,
//       isDismissible: false,
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: RPEScale(rpeScaleUpdater: changeRpeScale, exeScore: 100, exerciseIndex: selectedExerciseIndex),
//         );
//       },
//     );

//     /// Wait for RPE Scale Pressed
//     await waitUserForDoneButtonPress();

//     if (notLastExe) {
//       /// Waiting here for Exercise Pause time is over!
//       await waitUserForDoneButtonPress();
//       // Fill Exercise Rest Time after done Button Pressed
//       selectedPlan.exercises[selectedExerciseIndex].exerciseRestTime[toDay] = doneTime;
//       newExerciseDataUpdater(exeIndex: selectedExerciseIndex, initExercise: true);
//     }

//     // newExerciseDataUpdater(exeIndex: exeIndex, initExercise: false);
//   }

//   Future<void> waitUserForDoneButtonPress() async {
//     final completer = Completer<void>();
//     buttonCompleter = completer;

//     await completer.future;
//   }

//   void doneButtonPressed() {
//     setState(() {
//       buttonCompleter?.complete();
//       buttonCompleter = null;
//     });
//   }

//   void doExerciseLater() {
//     setState(() {
//       doLater = true;
//       doingExeIndexListLength++;
//       doingExeIndexList.add(selectedExerciseIndex);
//     });
//   }

//   void newExerciseDataUpdater({required int exeIndex, required bool initExercise}) {
//     Exercises selectedExercise = selectedPlan.exercises[exeIndex];

//     /// Stop running Timer
//     if (smallTimeSubscription != null) {
//       smallTimeSubscription!.cancel();
//     }
//     setState(() {
//       selectedExerciseIndex = exeIndex;

//       exerciseName = selectedExercise.name;
//       exerciseSubName = 'Exercise';
//       restTimeToDo = selectedExercise.setRestTimeScale['actualToDo'] ?? 0;
//     });

//     if (initExercise) {
//       setState(() {
//         prepareFor = 'next';

//         repetitionsToDo = selectedExercise.repetitionsScale['actualToDo'] ?? 0;
//         trainTimeToDo = selectedExercise.setDoTimeScale['actualToDo'] ?? 0;
//         weighthToDo = selectedExercise.weigthScale['actualToDo'] ?? 0.0;
//         playDoneButton = Icons.play_circle_fill_rounded;
//         actualSetNumber = 1;
//       });
//     } else {
//       setExerciseVideo();
//       setState(() {
//         prepareFor = 'pause - next';

//         repetitionsToDo = -1;
//         trainTimeToDo = -1;
//         weighthToDo = -1;
//       });
//       newDoingDataUpdater(pauseMode: true, set: selectedPlan.exercises[selectedExerciseIndex].sets.length);
//     }
//   }

//   void newDoingDataUpdater({required pauseMode, required int set}) {
//     /// Stop running Timer
//     if (smallTimeSubscription != null) {
//       smallTimeSubscription!.cancel();
//     }
//     setState(() {
//       actualSetNumber = set;
//       if (pauseMode) {
//         /// Pause Mode
//         toDoValue = restTimeToDo;
//         doneValue = doneTime;
//         modeColor = Styles.pastelBlue;
//         prepareFor = 'pause';
//         progressIndicatorText = 'sec';
//       } else {
//         /// Trainings Mode
//         if (trainTimeToDo != 0) {
//           toDoValue = trainTimeToDo;
//           doneValue = doneTime;
//           progressIndicatorText = 'sec';
//         } else {
//           toDoValue = repetitionsToDo;
//           doneValue = repetitionsToDo;
//           progressIndicatorText = 'rep';
//         }
//         prepareFor = 'train';
//         modeColor = Styles.pastelGreen;
//       }

//       progressIndicatorValue = 0.0;
//       progressIndicatorColor = Styles.white;

//       startDoingTimer();
//     });
//   }

//   void startDoingTimer() {
//     if (smallTimeSubscription != null) {
//       smallTimeSubscription!.cancel();
//     }
//     smallTimeStream = StartTimer().stopWatchStream();
//     smallTimeSubscription = smallTimeStream!.listen((int newTick) {
//       if (newTick % 5 == 0) {
//         dev.log('SmallTime: $newTick');
//       }
//       setState(() {
//         doneTime = newTick;

//         if (doneValue / toDoValue > 1) {
//           progressIndicatorValue = 1;
//           progressIndicatorColor = progressIndicatorColor == Styles.white ? Styles.pastelRed : Styles.white;
//         } else {
//           progressIndicatorValue = doneValue / toDoValue;
//         }
//       });
//     });
//   }

//   void startGlobalTimer() {
//     globalTimeStream = StartTimer().stopWatchStream();
//     globalTimeSubscription = globalTimeStream!.listen((int newTick) {
//       if (newTick % 5 == 0) {
//         dev.log(newTick.toString());
//       }
//       setState(() {
//         selectedPlan.time = newTick;
//       });
//     });
//   }

//   void changeRpeScale(int addNewValue, int exeIndex) {
//     selectedPlan.exercises[exeIndex].rpeScale[toDay] = addNewValue;
//     // fillPlanList[exeIndex][0]['rpeScale'] = addNewValue;

//     doneButtonPressed();
//   }

//   void setExerciseVideo() {
//     _vpController?.dispose();

//     _vpController = VideoPlayerController.asset('assets/videos/${selectedPlan.exercises[selectedExerciseIndex].media}.mp4')
//       ..addListener(() => setState(() {}))
//       ..setLooping(true)
//       ..setVolume(0.0)
//       ..initialize().then((_) => _vpController!.play());
//   }

//   Future<void> openExerciseInfo() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ExerciseInfoScreen(
//                 selectedExercise: selectedPlan.exercises[selectedExerciseIndex].exercisesToJson(),
//                 modeColor: modeColor,
//               )),
//     );

//     if (result) {
//       resumeExerciseVideo();
//     }
//   }

//   void resumeExerciseVideo() {
//     if (_vpController != null) {
//       _vpController!.play();
//     }
//   }

//   void endTraining() {
//     if (smallTimeSubscription != null) {
//       smallTimeSubscription!.cancel();
//     }
//     if (globalTimeSubscription != null) {
//       globalTimeSubscription!.cancel();
//     }

//     // Navigator.pushReplacement(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => TrainingEndedScreen(selectedPlan: selectedPlan.plansToJson(), user: user!),
//     //   ),
//     // );
//   }
// }//257
