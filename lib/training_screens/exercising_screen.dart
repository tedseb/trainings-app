import 'dart:async';

import 'package:flutter/material.dart';
import 'package:higym/app_utils/timer_utils.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/training_screens/exercise_info_screen.dart';
import 'package:higym/training_screens/leave_exercise_screen.dart';
import 'package:higym/training_screens/rpe_scale.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/training_ended_screen.dart';
import 'package:higym/widgets/loading_widget.dart';
import 'package:higym/models/goal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'dart:developer' as dev;

class ExercisingScreen extends StatefulWidget {
  const ExercisingScreen({
    Key? key,
    required this.selectedPlan,
    required this.appUser,
  }) : super(key: key);

  final Map<String, dynamic> selectedPlan;
  final AppUser appUser;

  @override
  State<ExercisingScreen> createState() => _ExercisingScreenState();
}

class _ExercisingScreenState extends State<ExercisingScreen> {
  ///Screen Informations
  Color modeColor = Styles.backgroundActivity;
  late int actualSetNumber;
  late double actualWeight;
  late String actualTimeorRep;
  int actualTimeOrRepNumberToDo = 0;
  int trainModeTimeDone = 0;
  int actualTimeOrRepNumber = 0;
  late String exeriseName;
  late String exeriseSubName;
  late String prepareFor;
  double progressValue = 0.0;

  Color progressColor = Styles.white;

  late int selectedExerciseIndex;
  late List<int> doingExeIndexList;
  List<int> occupiedExeIndexList = [];
  int doingExeIndexListLength = 0;
  int doingExeIndex = 0;
  bool doLater = false;
  bool skipExe = false;
  bool lastExe = false;
  bool exerciseStarted = false;

  late Plans selectedPlan;
  late Exercises selectedExercise;
  Completer<void>? buttonCompleter;
  VideoPlayerController? _vpController;

  Stream<int>? globalTimeStream;
  StreamSubscription<int>? globalTimeSubscription;
  Stream<int>? smallTimeStream;
  StreamSubscription<int>? smallTimeSubscription;

  IconData playDoneButton = Icons.play_circle_fill_rounded;

  String toDay = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // late List<List<Map<String,num>>> fillPlanList;

  @override
  void initState() {
    selectedPlan = Plans.plansFromJson(widget.selectedPlan);
    selectedPlan.time = 0;
    // fillPlanList = List.generate(
    //   selectedPlan.exercises.length,
    //   (exe) => List.generate(
    //     selectedPlan.exercises[exe].sets.length,
    //     (set) => {},
    //     growable: false,
    //   ),
    //   growable: false,
    // );

    for (Exercises exe in selectedPlan.exercises) {
      exe.rpeScale[toDay] = -1;
      // selectedPlan.exercises[exeIndex].rpeScale[toDay] = addNewValue;
    }

    /// Set toDo ExerciseList
    doingExeIndexList = List.generate(
      selectedPlan.exercises.length,
      (exeIndex) => exeIndex,
      growable: true,
    );
    doingExeIndexListLength = selectedPlan.exercises.length - 1;

    setExerciseVideo(selectedPlan.exercises[0]);
    screenExerciseDataUpdater(0, 0, true);

    WidgetsBinding.instance.addPostFrameCallback((_) => startPlan());

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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// TopBar Close - Skip - Buttons
              Container(
                height: 100,
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
                          LeaveExerciseScreen(
                              leaveTraining: false,
                              nextExercise: () {
                                setState(() {
                                  skipExe = true;
                                });
                                nextExeButtonPressed();
                              },
                              exerciseOccupied: doExerciseLater,
                              endTraining: endTraining),
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
                        onPressed: () => openExerciseInfo(),
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
                child: !_vpController!.value.isInitialized
                    ? const LoadingWidget()
                    : Stack(
                        children: [
                          /// Video
                          Center(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(modeColor, BlendMode.modulate),
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
                                color: progressColor,
                                strokeWidth: 8.0,
                              ),
                            ),
                          ),

                          /// Counter
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  actualTimeOrRepNumber.toString(),
                                  style: TextStyle(color: progressColor, fontSize: 100.0, fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  actualTimeorRep,
                                  style: TextStyle(color: progressColor, fontSize: 21.0, fontWeight: FontWeight.w600, height: 0.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),

              ///Play Button
              SizedBox(
                height: 105,
                // padding: const EdgeInsets.only(bottom: 18.0),
                child: IconButton(
                  onPressed: () {
                    nextExeButtonPressed();
                    // if (globalTimeStream == null) {
                    //   startPlan();
                    // } else {
                    //   nextExeButtonPressed();
                    // }
                  },
                  iconSize: 72,
                  icon: Icon(
                    playDoneButton,
                    color: Styles.white,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: (!lastExe && playDoneButton != Icons.check_circle_rounded),
                      child: ElevatedButton(
                        onPressed: () => doExerciseLater(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide.none,
                          ),
                          primary: Colors.transparent,
                          onPrimary: Styles.white,
                          elevation: 0.0,
                        ),
                        child: const Text(
                          'Occupied - Do Later',
                          style: TextStyle(
                            color: Styles.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startPlan() async {
    // int exercisesLength = selectedPlan.exercises.length - 1;

    ///Start only the Global Time for Training duration
    startGlobalTimer();

    for (int doingExe = 0; doingExe <= doingExeIndexListLength; doingExe++) {
      doingExeIndex = doingExe;
      if (doingExe == doingExeIndexListLength) {
        setState(() {
          lastExe = true;
        });
      }
      await waitUserForUserButtonPress();
      if (!doLater) {
        addOccupiedExeToList();
        setState(() {
          playDoneButton = Icons.check_circle_rounded;
        });
        await startExercise(doingExeIndexList[doingExe]);
        setState(() {
          playDoneButton = Icons.play_circle_fill_rounded;
        });
        // if (!lastExe) {
        //   await waitUserForUserButtonPress();
        // }
      } else {
        setState(() {
          doLater = false;
        });
      }
    }
    endTraining();
  }

  Future<void> startExercise(int exeIndex) async {
    Exercises exercise = selectedPlan.exercises[exeIndex];
    int setsLength = exercise.sets.length - 1;
    for (int setIndex = 0; setIndex <= setsLength; setIndex++) {
      /// Trainings Screen
      if (!skipExe) {
        screenTrainingsDataUpdater(exeIndex, setIndex, true, false);
        await waitUserForUserButtonPress();
        // Fill Repetitions and Trainings TimeDone after done Button Pressed
        selectedPlan.exercises[exeIndex].sets[setIndex].repetitions[toDay] = selectedPlan.exercises[exeIndex].repetitionsScale['actualToDo']!;
        selectedPlan.exercises[exeIndex].sets[setIndex].setTime[toDay] = trainModeTimeDone;
      }

      /// Pause Screen
      if (!skipExe) {
        if (setIndex < setsLength) {
          screenTrainingsDataUpdater(exeIndex, setIndex, false, false);
          await waitUserForUserButtonPress();
          // Fill Rest Time after done Button Pressed
          selectedPlan.exercises[exeIndex].sets[setIndex].setRestTime[toDay] = actualTimeOrRepNumber;
        }
      }
    }

    /// Exercise Pause Screen
    if (!skipExe) {
      if (!lastExe) {
        screenTrainingsDataUpdater(doingExeIndexList[doingExeIndex + 1], 0, false, true);
      }
      showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: RPEScale(rpeScaleUpdater: changeRpeScale, exeScore: 100, exerciseIndex: exeIndex),
          );
        },
      );

      /// Wait for RPE Scale Pressed
      await waitUserForUserButtonPress();
    }
    if (!lastExe) {
      if (!skipExe) {
        await waitUserForUserButtonPress();
      }
      // Fill Exercise Rest Time after done Button Pressed
      selectedPlan.exercises[exeIndex].exerciseRestTime[toDay] = actualTimeOrRepNumber;
      screenExerciseDataUpdater(doingExeIndexList[doingExeIndex + 1], 0, false);
    }

    skipExe = false;
  }

  Future<void> waitUserForUserButtonPress() async {
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

  void addOccupiedExeToList() {
    if (occupiedExeIndexList.isNotEmpty) {
      for (int occupiedExe = 0; occupiedExe < occupiedExeIndexList.length; occupiedExe++) {
        doingExeIndexList.insert(doingExeIndex + occupiedExe + 1, occupiedExeIndexList[occupiedExe]);
      }

      occupiedExeIndexList.clear();
    }
  }

  void doExerciseLater() {
    dev.log('do Later');

    setState(() {
      doLater = true;
      doingExeIndexListLength++;
      // doingExeIndexList.add(selectedExerciseIndex);
      // doingExeIndexList.insert(doingExeIndex+2, selectedExerciseIndex);
      occupiedExeIndexList.add(selectedExerciseIndex);
      if (doingExeIndexList.length - 1 <= doingExeIndex) {
        addOccupiedExeToList();
      }
      setExerciseVideo(selectedPlan.exercises[doingExeIndexList[doingExeIndex + 1]]);
      screenExerciseDataUpdater(doingExeIndexList[doingExeIndex + 1], 0, true);
    });
    nextExeButtonPressed();
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
    Exercises doingExercise = selectedPlan.exercises[exeIndex];
    selectedExercise = doingExercise;

    ///Initialize Screen Info
    setState(() {
      exeriseName = doingExercise.name;
      exeriseSubName = 'Exercise';
      actualSetNumber = doingSetIndex + 1;
      actualWeight = doingExercise.weigthScale['actualToDo'] ?? 0.0;

      ///Trainings Mode
      if (trainingsMode) {
        prepareFor = 'train';
        modeColor = Styles.backgroundActivity;
        if (doingExercise.setDoTimeScale['actualToDo'] == 0) {
          actualTimeorRep = 'rep';
          actualTimeOrRepNumberToDo = doingExercise.repetitionsScale['actualToDo'] ?? 0;
          actualTimeOrRepNumber = actualTimeOrRepNumberToDo;
          progressValue = 1;
          progressColor = Styles.white;
          startPassiveTimerTrainignsMode(exeIndex, doingSetIndex);
        } else {
          progressValue = 0.0;
          progressColor = Styles.white;
          actualTimeorRep = 'sec';
          actualTimeOrRepNumberToDo = doingExercise.setDoTimeScale['actualToDo'] ?? 0;
          actualTimeOrRepNumber = 0;
          startActiveTimerTrainignsMode(exeIndex, doingSetIndex);
        }

        ///Pause Mode
      } else {
        progressValue = 0.0;
        progressColor = Styles.white;
        modeColor = Styles.backgroundPause;
        actualTimeorRep = 'sec';
        actualTimeOrRepNumber = 0;

        if (!exepause) {
          prepareFor = 'pause';
          actualTimeOrRepNumberToDo = doingExercise.setRestTimeScale['actualToDo'] ?? 0;
          startActiveTimerPauseMode(exeIndex, doingSetIndex);
        } else {
          prepareFor = 'pause - next';
          setExerciseVideo(doingExercise);

          actualTimeOrRepNumberToDo = selectedPlan.exercises[exeIndex].setRestTimeScale['actualToDo'] ?? 0;
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
        trainModeTimeDone = newTick;
        // fillPlanList[exeIndex][setIndex]['setDoTimeScale'] = newTick;
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
        // fillPlanList[exeIndex][setIndex]['setDoTimeScale'] = newTick;
        trainModeTimeDone = newTick;
        actualTimeOrRepNumber = newTick;
        if (actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1) {
          progressValue = 1;
          progressColor = progressColor == Styles.white ? Styles.pastelRed : Styles.white;
        } else {
          progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
        }
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
        // fillPlanList[exeIndex][setIndex]['setRestTimeScale'] = newTick;

        actualTimeOrRepNumber = newTick;
        if (actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1) {
          progressValue = 1;
          progressColor = progressColor == Styles.white ? Styles.pastelRed : Styles.white;
        } else {
          progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
        }
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
        // selectedPlan.exercises![exeIndex - 1].exePauseTimeDone = newTick;
        // fillPlanList[exeIndex][0]['exerciseRestTime'] = newTick;

        actualTimeOrRepNumber = newTick;
        if (actualTimeOrRepNumber / actualTimeOrRepNumberToDo > 1) {
          progressValue = 1;
          progressColor = progressColor == Styles.white ? Styles.pastelRed : Styles.white;
        } else {
          progressValue = actualTimeOrRepNumber / actualTimeOrRepNumberToDo;
        }
      });
    });
  }

  void screenExerciseDataUpdater(int exeIndex, int doingSetIndex, bool trainingsMode) {
    Exercises doingExercise = selectedPlan.exercises[exeIndex];
    selectedExercise = doingExercise;
    if (smallTimeSubscription != null) {
      smallTimeSubscription!.cancel();
    }
    setState(() {
      exeriseName = doingExercise.name;
      selectedExerciseIndex = exeIndex;
      exeriseSubName = 'Exercise';
      actualSetNumber = doingSetIndex + 1;
      actualWeight = doingExercise.weigthScale['actualToDo'] ?? 0.0;
      prepareFor = 'Next Exercise';

      modeColor = Styles.backgroundActivity;
      if (doingExercise.setDoTimeScale['actualToDo'] == 0) {
        actualTimeorRep = 'rep';
        actualTimeOrRepNumberToDo = doingExercise.repetitionsScale['actualToDo'] ?? 0;
        actualTimeOrRepNumber = actualTimeOrRepNumberToDo;
        trainModeTimeDone = 0;
        progressValue = 1;
        progressColor = Styles.white;
      } else {
        actualTimeorRep = 'sec';
        actualTimeOrRepNumberToDo = doingExercise.setDoTimeScale['actualToDo'] ?? 0;
        actualTimeOrRepNumber = 0;
        trainModeTimeDone = 0;
        progressValue = 0.0;
        progressColor = Styles.white;
      }
    });
  }

  void changeRpeScale(int addNewValue, int exeIndex) {
    selectedPlan.exercises[exeIndex].rpeScale[toDay] = addNewValue;
    // fillPlanList[exeIndex][0]['rpeScale'] = addNewValue;

    nextExeButtonPressed();
  }

  void setExerciseVideo(Exercises? doingExercise) {
    _vpController?.dispose();

    if (doingExercise != null) {
      _vpController = VideoPlayerController.asset('assets/videos/${doingExercise.media}.mp4')
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..setVolume(0.0)
        ..initialize().then((_) => _vpController!.play() /*_vpController.play()*/);
    }
  }

  Future<void> openExerciseInfo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseInfoScreen(
                selectedExercise: selectedExercise.exercisesToJson(),
                modeColor: modeColor,
              )),
    );

    if (result) {
      resumeExerciseVideo();
    }
  }

  void resumeExerciseVideo() {
    if (_vpController != null) {
      _vpController!.play();
    }
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
        builder: (context) => TrainingEndedScreen(selectedPlan: selectedPlan.plansToJson(), user: widget.appUser),
      ),
    );
  }
}//353
