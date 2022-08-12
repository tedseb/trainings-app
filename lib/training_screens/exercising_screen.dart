import 'dart:async';

import 'package:flutter/material.dart';
import 'package:higym/app_utils/timer_utils.dart';
import 'package:higym/training_screens/exercise_info_screen.dart';
import 'package:higym/training_screens/leave_exercise_screen.dart';
import 'package:higym/training_screens/rpe_scale.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/training_ended_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'dart:developer' as dev;

import '../models/plans.dart';

class ExercisingScreen extends StatefulWidget {
  const ExercisingScreen({
    Key? key,
    required this.selectedPlan,
  }) : super(key: key);

  final Map<String, dynamic> selectedPlan;

  @override
  State<ExercisingScreen> createState() => _ExercisingScreenState();
}

class _ExercisingScreenState extends State<ExercisingScreen> {
  ///Screen Informations
  Color modeColor = Styles.backgroundActivity;
  late int actualSetNumber;
  double? actualWeight;
  late String actualTimeorRep;
  int actualTimeOrRepNumberToDo = 0;
  int actualTimeOrRepNumber = 0;
  late String exeriseName;
  late String exeriseSubName;
  late String prepareFor;
  double progressValue = 0.0;

  late Plans selectedPlan;
  Completer<void>? buttonCompleter;
  VideoPlayerController? _vpController;

  Stream<int>? globalTimeStream;
  StreamSubscription<int>? globalTimeSubscription;
  Stream<int>? smallTimeStream;
  StreamSubscription<int>? smallTimeSubscription;

  IconData playDoneButton = Icons.play_circle_fill_rounded;

  @override
  void initState() {
    selectedPlan = Plans.plansFromJson(widget.selectedPlan);
    selectedPlan.time = 0;
    setExerciseVideo(selectedPlan.exercises![0]);
    screenExerciseDataUpdater(0, 0, true);

    super.initState();
  }

  @override
  void dispose() {
    _vpController!.dispose();
    // endTraining();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await helper_utils.myBottomSheet(context, LeaveExerciseScreen(leaveTraining: true, endTraining: endTraining));
      },
      child: Scaffold(
        backgroundColor: modeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// TopBar Close - Skip - Buttons
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 26.0, right: 16.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 32,
                    icon: Styles.closeIcon,
                    onPressed: () async {
                      await helper_utils.myBottomSheet(context, LeaveExerciseScreen(leaveTraining: true, endTraining: endTraining));
                    },
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: Styles.skipIcon,
                    onPressed: () async {
                      await helper_utils.myBottomSheet(
                        context,
                        LeaveExerciseScreen(leaveTraining: false, nextExercise: nextExeButtonPressed, endTraining: endTraining),
                      );
                    },
                  ),
                ],
              ),
            ),

            /// Exercise Informations
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseInfoScreen(
                                    selectedExercise: selectedPlan.exercises![0].exercisesToJson(),
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          side: BorderSide.none,
                        ),
                        primary: Styles.white,
                        onPrimary: Styles.white,
                        elevation: 0.0,
                        minimumSize: Size.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'i',
                          style: TextStyle(
                            color: modeColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(prepareFor, style: Styles.exercisingSubTitle),
                        Text(
                          helper_utils.truncateExerciseName(exeriseName, Styles.exercisingTitle, MediaQuery.of(context).size.width),
                          style: Styles.exercisingTitle,
                        ),
                        Text(
                          exeriseSubName,
                          style: Styles.exercisingTitle,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const SizedBox(
                    height: 125,
                    child: VerticalDivider(
                      color: Styles.white,
                      thickness: 1.5,
                    ),
                  ),
                  SizedBox(
                    width: 90.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$actualSetNumber.',
                                style: Styles.exercisingTitle,
                              ),
                              Text(
                                'set',
                                style: Styles.exercisingTitle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                actualWeight.toString(),
                                style: Styles.exercisingTitle,
                              ),
                              Text(
                                'kg',
                                style: Styles.exercisingTitle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                actualTimeOrRepNumberToDo.toString(),
                                style: Styles.exercisingTitle,
                              ),
                              Text(
                                actualTimeorRep,
                                style: Styles.exercisingTitle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Progress Indicator
            Expanded(
              child: Stack(
                children: [
                  /// Video
                  Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(modeColor, BlendMode.modulate),
                      // child: VideoPlayer(_vpController!),
                      child: AspectRatio(
                        aspectRatio: _vpController!.value.aspectRatio,
                        child: VideoPlayer(_vpController!),
                      ),
                    ),
                  ),

                  /// Circle
                  Center(
                    child: SizedBox(
                      height: (MediaQuery.of(context).size.height / 10) * 3,
                      width: (MediaQuery.of(context).size.height / 10) * 3,
                      child: CircularProgressIndicator(
                        value: progressValue,
                        color: Styles.white,
                        strokeWidth: 8.0,
                      ),
                    ),
                  ),

                  /// Counter
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(actualTimeOrRepNumber.toString(),
                            style: const TextStyle(color: Styles.white, fontSize: 100.0, fontWeight: FontWeight.w300)),
                        Text(actualTimeorRep, style: const TextStyle(color: Styles.white, fontSize: 21.0, fontWeight: FontWeight.w600, height: 0.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Play Button
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: IconButton(
                onPressed: () {
                  if (globalTimeStream == null) {
                    startPlan();
                  } else {
                    nextExeButtonPressed();
                  }
                },
                iconSize: 72,
                icon: Icon(
                  playDoneButton,
                  color: Styles.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startPlan() async {
    int exercisesLength = selectedPlan.exercises!.length - 1;
    bool lastExe = false;

    startGlobalTimer();

    for (int exe = 0; exe <= exercisesLength; exe++) {
      if (exe == exercisesLength) {
        setState(() {
          lastExe = true;
        });
      }
      setState(() {
        playDoneButton = Icons.check_circle_rounded;
      });
      await startExercise(exe, lastExe);
      setState(() {
        playDoneButton = Icons.play_circle_fill_rounded;
      });
      if (!lastExe) {
        await waitUserForNextSet();
      }
    }
    endTraining();
  }

  Future<void> startExercise(int exeIndex, bool lastExe) async {
    Exercises exercise = selectedPlan.exercises![exeIndex];
    int setsLength = exercise.sets!.length - 1;
    for (int sets = 0; sets <= setsLength; sets++) {
      ///Trainings Screen
      screenTrainingsDataUpdater(exeIndex, sets, true, false);

      await waitUserForNextSet();
      if (sets < setsLength) {
        ///Pause Screen
        screenTrainingsDataUpdater(exeIndex, sets, false, false);
        await waitUserForNextSet();
      } else {
        ///Exercise Pause Screen
        if (!lastExe) {
          screenTrainingsDataUpdater(exeIndex + 1, 0, false, true);
        }
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: RPEScale(rpeScaleUpdater: changeRpeScale, exeScore: 100, exerciseIndex: exeIndex),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.95,
              //   child: LeaveExerciseScreen(leaveTraining: true),
              // ),
            );
          },
        );
        await waitUserForNextSet();

        if (!lastExe) {
          await waitUserForNextSet();
          screenExerciseDataUpdater(exeIndex + 1, 0, false);
        }
      }
    }
  }

  Future<void> waitUserForNextSet() async {
    final completer = Completer<void>();
    buttonCompleter = completer;

    await completer.future;
  }

  void nextExeButtonPressed() {
    setState(() {
      buttonCompleter?.complete();
      buttonCompleter = null;
    });
  }

  void startGlobalTimer() {
    globalTimeStream = StartTimer().stopWatchStream();
    globalTimeSubscription = globalTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        dev.log(newTick.toString());
      }
      setState(() {
        selectedPlan.time = newTick;
      });
    });
  }

  void screenTrainingsDataUpdater(int exeIndex, int doingSetIndex, bool trainingsMode, bool exepause) {
    Exercises doingExercise = selectedPlan.exercises![exeIndex];

    ///Initialize Screen Info
    setState(() {
      exeriseName = doingExercise.name!;
      exeriseSubName = 'Exercise';
      actualSetNumber = doingSetIndex + 1;
      actualWeight = doingExercise.sets![doingSetIndex].weight;

      ///Trainings Mode
      if (trainingsMode) {
        prepareFor = 'train';
        modeColor = Styles.backgroundActivity;
        if (doingExercise.sets![doingSetIndex].repetitions != null) {
          actualTimeorRep = 'rep';
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].repetitions ?? 0;
          actualTimeOrRepNumber = actualTimeOrRepNumberToDo;
          progressValue = 1;
          startPassiveTimerTrainignsMode(exeIndex, doingSetIndex);
        } else {
          progressValue = 0.0;
          actualTimeorRep = 'sec';
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].time ?? 0;
          actualTimeOrRepNumber = 0;
          startActiveTimerTrainignsMode(exeIndex, doingSetIndex);
        }

        ///Pause Mode
      } else {
        progressValue = 0.0;
        modeColor = Styles.backgroundPause;
        actualTimeorRep = 'sec';
        actualTimeOrRepNumber = 0;

        if (!exepause) {
          prepareFor = 'pause';
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].pause ?? 0;
          startActiveTimerPauseMode(exeIndex, doingSetIndex);
        } else {
          prepareFor = 'pause - next';
          setExerciseVideo(doingExercise);
          actualTimeOrRepNumberToDo = doingExercise.exePauseTime ?? 0;
          startActiveTimerExePauseMode(exeIndex);
        }
      }
    });
  }

  void startPassiveTimerTrainignsMode(int exeIndex, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        dev.log('SmallTime: $newTick');
      }
      setState(() {
        selectedPlan.exercises![exeIndex].sets![setIndex].timeDone = newTick;
      });
    });
  }

  void startActiveTimerTrainignsMode(int exeIndex, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        dev.log('SmallTime: $newTick');
      }
      setState(() {
        selectedPlan.exercises![exeIndex].sets![setIndex].timeDone = newTick;
        actualTimeOrRepNumber = newTick;
        progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1 ? 1 : actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
      });
    });
  }

  void startActiveTimerPauseMode(int exeIndex, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        dev.log('SmallTime: $newTick');
      }
      setState(() {
        selectedPlan.exercises![exeIndex].sets![setIndex].pauseDone = newTick;
        actualTimeOrRepNumber = newTick;
        progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1 ? 1 : actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
      });
    });
  }

  void startActiveTimerExePauseMode(int exeIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        dev.log('SmallTime: $newTick');
      }
      setState(() {
        selectedPlan.exercises![exeIndex - 1].exePauseTimeDone = newTick;
        actualTimeOrRepNumber = newTick;
        progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1 ? 1 : actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
      });
    });
  }

  void screenExerciseDataUpdater(int exeIndex, int doingSetIndex, bool trainingsMode) {
    Exercises doingExercise = selectedPlan.exercises![exeIndex];

    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    setState(() {
      exeriseName = doingExercise.name!;
      exeriseSubName = 'Exercise';
      actualSetNumber = doingSetIndex + 1;
      actualWeight = doingExercise.sets![doingSetIndex].weight;
      prepareFor = 'Next Exercise';

      modeColor = Styles.backgroundActivity;
      if (doingExercise.sets![doingSetIndex].repetitions != null) {
        actualTimeorRep = 'rep';
        actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].repetitions ?? 0;
        actualTimeOrRepNumber = actualTimeOrRepNumberToDo;
        progressValue = 1;
      } else {
        actualTimeorRep = 'sec';
        actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].time ?? 0;
        actualTimeOrRepNumber = 0;
      }
    });
  }

  void changeRpeScale(int addNewValue, int exeIndex, bool userEdited) {
    int rpeScalLength = selectedPlan.exercises![exeIndex].rpeScale!.length;

    if (userEdited) {
      selectedPlan.exercises![exeIndex].rpeScale![(rpeScalLength - 1)] = addNewValue;
    } else {
      selectedPlan.exercises![exeIndex].rpeScale!.add(addNewValue);
    }
    nextExeButtonPressed();
  }

  void setExerciseVideo(Exercises doingExercise) {
    _vpController?.dispose();

    // _vpController = VideoPlayerController.asset('assets/videos/test7.mp4')
    _vpController = VideoPlayerController.asset('assets/videos/${doingExercise.video}.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) => _vpController!.play() /*_vpController.play()*/);
  }

  void endTraining() {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    if (globalTimeSubscription != null) {
      globalTimeSubscription!.cancel();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingEndedScreen(selectedPlan: selectedPlan.plansToJson()),
      ),
    );
  }
}
