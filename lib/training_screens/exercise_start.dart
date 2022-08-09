import 'dart:async';

import 'package:flutter/material.dart';
import 'package:higym/app_utils/timer_utils.dart';
import 'package:higym/training_screens/exercise_info_screen.dart';
import 'package:higym/training_screens/leave_exercise_screen.dart';
import 'package:higym/training_screens/rpe_scale.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/training_ended_screen.dart';
import 'package:video_player/video_player.dart';

import 'dart:developer' as developer;


import '../models/plans.dart';

class ExerciseStart extends StatefulWidget {
  const ExerciseStart({
    Key? key,
    required this.selectedPlan,
  }) : super(key: key);

  final Map<String, dynamic> selectedPlan;

  @override
  State<ExerciseStart> createState() => _ExerciseStartState();
}

class _ExerciseStartState extends State<ExerciseStart> {
  ///Screen Informations
  Color modeColor = Styles.backgroundActivity;
  late int actualSetNumber;
  double? actualWeight;
  late String actualTimeorRep;
  int actualTimeOrRepNumberToDo = 0;
  int actualTimeOrRepNumber = 0;
  late String exeriseName;
  late String exeriseSubName;
  double progressValue = 0.0;

  late Plans selectedPlan;
  Completer<void>? buttonCompleter;
  late VideoPlayerController _vpController;

  Stream<int>? globalTimeStream;
  StreamSubscription<int>? globalTimeSubscription;
  Stream<int>? smallTimeStream;
  StreamSubscription<int>? smallTimeSubscription;

  IconData playDoneButton = Icons.play_circle_fill_rounded;

  @override
  void initState() {
    _vpController = VideoPlayerController.asset('assets/videos/kniebeugen.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) => {} /*_vpController.play()*/);

    selectedPlan = Plans.plansFromJson(widget.selectedPlan);
    selectedPlan.time = 0;

    screenExerciseDataUpdater(0, 0, true);

    super.initState();
  }

  @override
  void dispose() {
    _vpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: modeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// TopBar Close - Skip - Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Styles.white,
                    size: 32.0,
                  ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: LeaveExerciseScreen(leaveTraining: true, endTraining: endTraining,),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.fast_forward_rounded,
                    color: Styles.white,
                    size: 32.0,
                  ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: LeaveExerciseScreen(leaveTraining: false, nextExercise: nextExeButtonPressed, endTraining: endTraining),
                          ),
                        );
                      },
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        exeriseName,
                        style: const TextStyle(fontSize: 28, color: Styles.white),
                      ),
                      Text(
                        exeriseSubName,
                        style: const TextStyle(fontSize: 28, color: Styles.white),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(
                  height: 120,
                  child: VerticalDivider(
                    color: Styles.white,
                    thickness: 2,
                  ),
                ),
                Container(
                  width: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$actualSetNumber.',
                            style: const TextStyle(fontSize: 22, color: Styles.white),
                          ),
                          const Text(
                            'set',
                            style: TextStyle(fontSize: 22, color: Styles.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            actualWeight.toString(),
                            style: const TextStyle(fontSize: 22, color: Styles.white),
                          ),
                          const Text(
                            'kg',
                            style: TextStyle(fontSize: 22, color: Styles.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            actualTimeOrRepNumberToDo.toString(),
                            style: const TextStyle(fontSize: 22, color: Styles.white),
                          ),
                          Text(
                            actualTimeorRep,
                            style: const TextStyle(fontSize: 22, color: Styles.white),
                          ),
                        ],
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
                Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(modeColor, BlendMode.modulate),
                    child: VideoPlayer(_vpController),
                    // child: AspectRatio(
                    //   aspectRatio: _vpController.value.aspectRatio,
                    //   child: VideoPlayer(_vpController),
                    // ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      color: Styles.white,
                      strokeWidth: 6.0,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          actualTimeOrRepNumber.toString(),
                          style: const TextStyle(color: Styles.white, fontSize: 62.0),
                        ),
                        Text(
                          actualTimeorRep,
                          style: const TextStyle(color: Styles.white, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///Play Button
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: SizedBox(
              width: double.infinity,
              height: 110,
              child: IconButton(
                onPressed: () {
                  if (globalTimeStream == null) {
                    startPlan();
                  } else {
                    nextExeButtonPressed();
                  }
                },
                icon: Icon(
                  playDoneButton,
                  color: Styles.white,
                  size: 72,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startPlan() async {
    int exercisesLength = selectedPlan.exercises!.length - 1;
    bool lastExe = false;

    startGlobalTimer();

    for (int exe = 0; exe <= exercisesLength; exe++) {
      if (exe == exercisesLength) {
        lastExe = true;
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
              child: RPEScale(rpeScaleUpdater: () {}, exeScore: 100),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.95,
              //   child: LeaveExerciseScreen(leaveTraining: true),
              // ),
            );
          },
        );

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
        developer.log('GlobalTime: $newTick');
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
        modeColor = Styles.backgroundActivity;
        if (doingExercise.sets![doingSetIndex].repetitions != null) {
          actualTimeorRep = 'rep';
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].repetitions ?? 0;
          actualTimeOrRepNumber = actualTimeOrRepNumberToDo;
          progressValue = 1;
          startPassiveTimerTrainignsMode(doingExercise, doingSetIndex);
        } else {
          progressValue = 0.0;
          actualTimeorRep = 'sec';
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].time ?? 0;
          actualTimeOrRepNumber = 0;
          startActiveTimerTrainignsMode(doingExercise, doingSetIndex);
        }

        ///Pause Mode
      } else {
        progressValue = 0.0;
        modeColor = Styles.backgroundPause;
        actualTimeorRep = 'sec';
        actualTimeOrRepNumber = 0;

        if (!exepause) {
          actualTimeOrRepNumberToDo = doingExercise.sets![doingSetIndex].pause ?? 0;
          startActiveTimerPauseMode(doingExercise, doingSetIndex);
        } else {
          actualTimeOrRepNumberToDo = doingExercise.exePauseTime ?? 0;
          startActiveTimerExePauseMode(doingExercise);
        }
      }
    });
  }

  void startPassiveTimerTrainignsMode(Exercises exercises, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        developer.log('SmallTime: $newTick');
      }
      setState(() {
        exercises.sets![setIndex].timeDone = newTick;
      });
    });
  }

  void startActiveTimerTrainignsMode(Exercises exercises, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        developer.log('SmallTime: $newTick');
      }
      setState(() {
        exercises.sets![setIndex].timeDone = newTick;
        actualTimeOrRepNumber = newTick;
        progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1 ? 1 : actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
      });
    });
  }

  void startActiveTimerPauseMode(Exercises exercises, int setIndex) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        developer.log('SmallTime: $newTick');
      }
      setState(() {
        exercises.sets![setIndex].pauseDone = newTick;
        actualTimeOrRepNumber = newTick;
        progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1 ? 1 : actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
      });
    });
  }

  void startActiveTimerExePauseMode(Exercises exercises) {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    smallTimeStream = StartTimer().stopWatchStream();
    smallTimeSubscription = smallTimeStream!.listen((int newTick) {
      if (newTick % 5 == 0) {
        developer.log('SmallTime: $newTick');
      }
      setState(() {
        exercises.exePauseTimeDone = newTick;
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

  void endTraining() async {
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    if (globalTimeSubscription != null) {
      globalTimeSubscription!.cancel();
    }

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingEndedScreen(selectedPlan: selectedPlan.plansToJson()),
      ),
    );
  }
}



   // onPressed: () async {
        //   await Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => TrainingEndedScreen(
        //         selectedPlan: selectedPlan.plansToJson(),
        //         donePlan: doingPlan.plansToJson(),
        //       ),
        //     ),
        //   );
        // },