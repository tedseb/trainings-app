import 'package:flutter/material.dart';

import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/training_screens/exercise_info_screen.dart';
import 'package:higym/widgets/exercise_card_widget.dart';
import 'package:higym/widgets/loading_widget.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class TrainingsProgrammScreen extends StatefulWidget {
  const TrainingsProgrammScreen({Key? key}) : super(key: key);

  @override
  State<TrainingsProgrammScreen> createState() => _TrainingsProgrammScreenState();
}

class _TrainingsProgrammScreenState extends State<TrainingsProgrammScreen> {
  Plans selectedPlan = InitialModels.initialGoal.trainingsProgramms[0].plans[0];
  Goal? myGoal;
  late Goal goal;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (myGoal.trainingsProgramms.isNotEmpty) {
    //     getAndUpdateSelectedPlan(myGoal.trainingsProgramms[0]);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // selectedPlan = Provider.of<List<Plans>>(context).firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());
    myGoal = Provider.of<Goal>(context);
    // selectedPlan = myGoal.trainingsProgramms[0].plans[0];
    getAndUpdateSelectedPlan();
    return Scaffold(
      body: goalNotNullTester()
          ? Column(
              children: [
                ///Talk to AI Button
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ShadowIconButtonWidget(buttonIcon: Icons.surround_sound_outlined, onPressFunction: () {})],
                  ),
                ),

                ///Plan Name
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 70.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedPlan.name,
                            style: Styles.trainingsplanTitle,
                          ),
                          Text(
                            'train',
                            style: Styles.trainingsplanSubTitle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                ///Plan Parameter
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Styles.getFitnessTypeIcons(myGoal!.trainingsProgramms[0].fitnesstype),
                          Text(myGoal!.trainingsProgramms[0].fitnesstype, style: Styles.trainingsplanIconTitle),
                        ],
                      ),
                      Column(
                        children: [
                          Styles.levelIcon,
                          Text(Styles.getFitnessLevelText(myGoal!.trainingsProgramms[0].difficultyLevel), style: Styles.trainingsplanIconTitle),
                        ],
                      ),
                      Column(
                        children: [
                          Styles.timerIcon,
                          Text('${myGoal!.trainingsProgramms[0].durationWeeks.toString()} Weeks', style: Styles.trainingsplanIconTitle),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Shadow Divider
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 0.0),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[BoxShadow(blurRadius: 10, offset: Offset(0, 13), color: Colors.grey, spreadRadius: -7)],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 100.0),
                      itemCount: selectedPlan.exercises.length,
                      itemBuilder: (context, index) {
                        //Exercise Name is Loading...
                        return selectedPlan.exercises[index].name == 'Exercise Name is Loading...'
                            ? const LoadingWidget()
                            : ExerciseCardWidget(
                                selectedExercise: selectedPlan.exercises[index],
                                showInfoScreen: openExerciseInfo,
                              );
                      }),
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }

  bool goalNotNullTester() {
    if (myGoal != null) {
      if (myGoal!.trainingsProgramms.isNotEmpty) {
        dev.log('myGoal!.trainingsProgramms != null');
        return true;
      } else {
        dev.log('myGoal!.trainingsProgramms IST null');
        return false;
      }
    } else {
      dev.log('Goal IST null');
      return false;
    }
  }

  void checkTrainingsPhaseAndUpdate(TrainingsProgramms trainingsProgramm) {
    DateTime now = DateTime.now();
    DateTime phase1Start = DateTime.parse(trainingsProgramm.phases['1']!);
    DateTime phase2Start = DateTime.parse(trainingsProgramm.phases['1']!);
    DateTime phase3Start = DateTime.parse(trainingsProgramm.phases['1']!);

    // if(phase3Start.isBefore(now)){
    //   //Update actualPhase to 3
    // }else if{

    // }
    //  Plans myPlan = trainingsProgramm.plans.firstWhere((element) => element.name == trainingsProgramm.actualPlan);
  }

  void getAndUpdateSelectedPlan() {
    if (myGoal != null) {
      Plans myPlan = myGoal!.trainingsProgramms[0].plans.firstWhere((element) => element.name == myGoal!.trainingsProgramms[0].actualPlan);

      for (Exercises exe in myPlan.exercises) {
        if (exe.rpeScale.isNotEmpty) {
          int rpeLength = exe.rpeScale.entries.length;
          dev.log(exe.rpeScale.toString());
          if (exe.rpeScale.entries.last.value != -1) {
            if (exe.rpeScale.entries.last.value != 3) {
              if (exe.setDoTimeScale['actualToDo'] != 0 && exe.setDoTimeScale['actualToDo']! < exe.setDoTimeScale['rangeTo']!) {
                /// Increase Set Do Time
                exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['actualToDo']! + exe.setDoTimeScale['stepWidth']!;
              } else if (exe.repetitionsScale['actualToDo']! < exe.repetitionsScale['rangeTo']!) {
                /// Increase Repetition
                exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! + exe.repetitionsScale['stepWidth']!;
              } else if (exe.setRestTimeScale['actualToDo']! > exe.setRestTimeScale['rangeTo']!) {
                /// Decrease Rest Time
                exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['actualToDo']! - exe.setRestTimeScale['stepWidth']!;
              } else {
                /// Increase Weigth
                exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! + exe.weigthScale['stepWidth']!;

                /// Decrease
                exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['rangeFrom']!;
                exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['rangeFrom']!;
                exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['rangeFrom']!;
              }
            } else if (rpeLength > 2) {
              ///IF last 3 RPEs smaller -> reverse scale
              if (exe.rpeScale.entries.elementAt(rpeLength - 2).value == 3 && exe.rpeScale.entries.elementAt(rpeLength - 3).value == 3) {
                if (exe.repetitionsScale['actualToDo']! == exe.repetitionsScale['rangeFrom']! &&
                    exe.setDoTimeScale['actualToDo']! == exe.setDoTimeScale['rangeFrom']! &&
                    exe.setRestTimeScale['actualToDo']! == exe.setRestTimeScale['rangeFrom']!) {
                  /// Decrease Weigth
                  exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! - exe.weigthScale['stepWidth']!;

                  /// Increase
                  exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['rangeFrom']!;
                  exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['rangeFrom']!;
                  exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['rangeFrom']!;
                } else if (exe.setRestTimeScale['actualToDo']! < exe.setRestTimeScale['rangeFrom']!) {
                  /// Increase Rest Time
                  exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['actualToDo']! + exe.setRestTimeScale['stepWidth']!;
                } else if (exe.setDoTimeScale['actualToDo'] != 0) {
                  /// Decrease Set Do Time
                  exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['actualToDo']! - exe.setDoTimeScale['stepWidth']!;
                } else {
                  /// Decrease Repetition
                  exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! - exe.repetitionsScale['stepWidth']!;
                }
              }
            }
          }
        }
      }

      setState(() {
        selectedPlan = myPlan;
      });
    }
    // for (Exercises exe in myPlan.exercises) {
    //   dev.log(exe.name);
    //   dev.log('setDoTimeScale: --- ${exe.setDoTimeScale['actualToDo']}');
    //   dev.log('repetitionsScale: --- ${exe.repetitionsScale['actualToDo']}');
    //   dev.log('setRestTimeScale: --- ${exe.setRestTimeScale['actualToDo']}');
    //   dev.log('weigthScale: --- ${exe.weigthScale['actualToDo']}');

    // }
  }

  Future<void> openExerciseInfo(Exercises selectedExercise) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseInfoScreen(
                selectedExercise: selectedExercise.exercisesToJson(),
                modeColor: Styles.grey,
              )),
    );
  }
}
