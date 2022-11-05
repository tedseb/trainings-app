import 'package:flutter/material.dart';

import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/training_screens/exercise_info_screen.dart';
import 'package:higym/widgets/general_widgets/exercise_card_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';
import 'package:higym/widgets/screen_widgets/talk_to_ai_screen.dart';
import 'package:provider/provider.dart';
import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'dart:developer' as dev;

class TrainingsProgrammScreen extends StatefulWidget {
  const TrainingsProgrammScreen({Key? key}) : super(key: key);

  @override
  State<TrainingsProgrammScreen> createState() => _TrainingsProgrammScreenState();
}

class _TrainingsProgrammScreenState extends State<TrainingsProgrammScreen> {
  Plans selectedPlan = InitialModels.initialGoal.trainingsProgramms[0].plans[0];
  Goal? myGoal;
  // late Goal goal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    myGoal = Provider.of<Goal>(context);

    return Scaffold(
      body: goalNotNullTester()
          ? Column(
              children: [
                ///Talk to AI Button
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShadowIconButtonWidget(
                        buttonIcon: Icons.surround_sound_outlined,
                        onPressFunction: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TalkToAiScreen(appUser: user!),
                            ),
                          );
                        },
                        loggerText: 'Talk to AI',
                      )
                    ],
                  ),
                ),

                ///Plan Name
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'next',
                              style: Styles.trainingsplanSubTitle,
                            ),
                            Text(
                              // 'Workout',
                              myGoal!.trainingsProgramms[0].actualPlan,
                              style: Styles.trainingsplanTitle,
                            ),
                          ],
                        ),
                      ),
                      // Flexible(
                      //   flex: 1,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Phase',
                      //         style: Styles.trainingsplanSubTitle,
                      //       ),
                      //       Text(
                      //         myGoal!.trainingsProgramms[0].actualPhase.toString(),
                      //         style: Styles.trainingsplanTitle,
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                  child: myGoal == null
                      ? const LoadingWidget()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: ListView.builder(
                              padding: const EdgeInsets.only(top: 50.0, bottom: 100.0),
                              itemCount: myGoal!.trainingsProgramms[0].plans.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: ExpansionTile(
                                    // trailing: Icon(Icons.arrow_drop_down_circle_rounded),
                                    // onExpansionChanged: ,
                                    tilePadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 10),
                                    collapsedIconColor: Styles.hiGymText,
                                    collapsedTextColor: Styles.hiGymText,
                                    iconColor: Styles.secondaryColor,
                                    initiallyExpanded: activeExerciseCheck(index),
                                    textColor: Styles.secondaryColor,
                                    backgroundColor: Colors.transparent,
                                    title: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              helper_utils.truncatePlanName(
                                                myGoal!.trainingsProgramms[0].plans[index].name,
                                                Styles.trainingsplanSubTitle,
                                                MediaQuery.of(context).size.width,
                                              ),
                                              style: Styles.trainingsplanSubTitle,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4.0),
                                              width: 30.0,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: activeExerciseCheck(index) ? Styles.primaryColor : Styles.grey,
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                                          itemCount: myGoal!.trainingsProgramms[0].plans[index].exercises.length,
                                          itemBuilder: (context, exeIndex) {
                                            //Exercise Name is Loading...
                                            return ExerciseCardWidget(
                                              selectedExercise: myGoal!.trainingsProgramms[0].plans[index].exercises[exeIndex],
                                              showInfoScreen: openExerciseInfo,
                                              active: activeExerciseCheck(index),
                                            );
                                          }),
                                    ],
                                  ),
                                );
                              }),
                        ),
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }

  bool goalNotNullTester() {
    if (myGoal == null) {
      dev.log('Goal is null, Wait Goal Stream');
      return false;
    }
    if (myGoal!.trainingsProgramms.isEmpty) {
      dev.log('Trainings Programm is null');
      return false;
    }
    dev.log('Trainings Programm Loaded!');
    return true;
  }

  /// Check If the selected Exerci is the Actual Plan
  bool activeExerciseCheck(int index) {
    if (myGoal!.trainingsProgramms[0].actualPlan == myGoal!.trainingsProgramms[0].plans[index].name) {
      return true;
    } else {
      return false;
    }
  }

  void checkTrainingsPhaseAndUpdate(TrainingPrograms trainingsProgramm) {
    DateTime now = DateTime.now();
    DateTime phase1Start = DateTime.parse(trainingsProgramm.phases[0]);
    DateTime phase2Start = DateTime.parse(trainingsProgramm.phases[1]);
    DateTime phase3Start = DateTime.parse(trainingsProgramm.phases[2]);
    DateTime phase3End = DateTime.parse(trainingsProgramm.phases[3]);

    // if(phase3Start.isBefore(now)){
    //   //Update actualPhase to 3
    // }else if{

    // }
    //  Plans myPlan = trainingsProgramm.plans.firstWhere((element) => element.name == trainingsProgramm.actualPlan);
  }

  // void getAndUpdateSelectedPlan() {
  //   if (myGoal != null) {
  //     Plans myPlan = myGoal!.trainingsProgramms[0].plans.firstWhere((element) => element.name == myGoal!.trainingsProgramms[0].actualPlan);

  //     setState(() {
  //       selectedPlan = myPlan;
  //     });
  //   }
  // }

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




  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (myGoal.trainingsProgramms.isNotEmpty) {
  //       getAndUpdateSelectedPlan(myGoal.trainingsProgramms[0]);
  //     }
  //   });
  // }