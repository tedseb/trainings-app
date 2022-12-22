import 'package:flutter/material.dart';
import 'package:higym/constants/icon_constants.dart';

import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/constants/model_constants.dart';
import 'package:higym/constants/value_constants.dart';
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
  Plans selectedPlan = ModelConstants.initialGoal.trainingsProgramms[0].plans[0];
  Goal? myGoal;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    myGoal = Provider.of<Goal>(context);

    return Scaffold(
      body: goalNotNullTester()
          ? Column(
              children: [
                /// TrainingsProgram TopBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///Talk to AI Button
                    ShadowIconButtonWidget(
                      buttonIcon: IconConstants.talkToAiIconData,
                      onPressFunction: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TalkToAiScreen(appUser: user!.appUserToJson(), goal: myGoal!.goalToJson()),
                          ),
                        );
                      },
                      loggerText: 'Talk to AI',
                    ),

                    /// Spacer
                    const SizedBox(height: 100.0, width: 16.0),
                  ],
                ),

                ///Plan Name
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TrainingsProgramm next
                          Text(
                            'upcoming',
                            style: Styles.normalLinesLight,
                          ),

                          /// TrainingsProgram Name
                          Text(
                            myGoal!.trainingsProgramms[0].actualPlan,
                            style: Styles.subLinesBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///Plan Parameter
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// Actual Goal
                      Column(
                        children: [
                          Icon(
                            ValueConstants.goalObjects.firstWhere((element) => element['titel'] == myGoal!.trainingsProgramms[0].fitnesstype)['icon'],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            myGoal!.trainingsProgramms[0].fitnesstype,
                            style: Styles.smallLinesBold.copyWith(color: Styles.darkGrey),
                          ),
                        ],
                      ),

                      /// Trainings Level
                      Column(
                        children: [
                          ValueConstants.trainingPlanDifficultyIcons[myGoal!.trainingsProgramms[0].difficultyLevel]!,
                          const SizedBox(height: 4.0),
                          Text(
                            ValueConstants.trainingPlanDifficulty[myGoal!.trainingsProgramms[0].difficultyLevel],
                            style: Styles.smallLinesBold.copyWith(color: Styles.darkGrey),
                          ),
                        ],
                      ),

                      /// Goal Duration
                      Column(
                        children: [
                          IconConstants.timeIcon,
                          const SizedBox(height: 4.0),
                          Text(
                            '${myGoal!.trainingsProgramms[0].durationWeeks.toString()} Weeks',
                            style: Styles.smallLinesBold.copyWith(color: Styles.darkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Shadow Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Styles.white,
                      boxShadow: <BoxShadow>[BoxShadow(blurRadius: 10, offset: Offset(0, 13), color: Styles.grey, spreadRadius: -7)],
                    ),
                  ),
                ),

                /// Trainings Programms
                Expanded(
                  child: myGoal == null
                      ? const LoadingWidget()

                      /// Trainings Programs List
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: ListView.builder(
                              padding: const EdgeInsets.only(top: 50.0, bottom: 100.0),
                              itemCount: myGoal!.trainingsProgramms[0].plans.length,
                              itemBuilder: (context, index) {
                                /// One Trainings Program
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: ExpansionTile(
                                    // trailing: Icon(Icons.arrow_drop_down_circle_rounded),
                                    // onExpansionChanged: ,
                                    tilePadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 10),
                                    collapsedIconColor: Styles.darkGrey,
                                    collapsedTextColor: Styles.darkGrey,
                                    iconColor: Styles.primaryColor,
                                    initiallyExpanded: activeExerciseCheck(index),
                                    backgroundColor: Colors.transparent,

                                    /// TrainingsProgramm Name
                                    title: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            /// Name
                                            Text(
                                              helper_utils.truncatePlanName(
                                                myGoal!.trainingsProgramms[0].plans[index].name,
                                                Styles.subLinesBold,
                                                MediaQuery.of(context).size.width,
                                              ),
                                              style: Styles.subLinesBold,
                                            ),

                                            /// Name Underline
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
                                      /// Trainings PLAN
                                      ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                                          itemCount: myGoal!.trainingsProgramms[0].plans[index].exercises.length,
                                          itemBuilder: (context, exeIndex) {
                                            /// One Exercise
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

  /// Check Goal or User Null to Avoid Error
  bool goalNotNullTester() {
    if (myGoal == null) {
      dev.log('Goal NULL', name: 'TrainingProgram_Screen');
      return false;
    }
    if (myGoal!.trainingsProgramms.isEmpty) {
      dev.log('TrainingProgram NULL', name: 'TrainingProgram_Screen');
      return false;
    }
    dev.log('Goal and TrainingProgram OK', name: 'TrainingProgram_Screen');
    return true;
  }

  /// Check If the selected Exercise is the Actual Plan
  bool activeExerciseCheck(int index) {
    if (myGoal!.trainingsProgramms[0].actualPlan == myGoal!.trainingsProgramms[0].plans[index].name) {
      return true;
    } else {
      return false;
    }
  }

  /// Open Exercise Info
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
