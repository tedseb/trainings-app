import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/goal.dart';

import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'package:higym/models/used_objects.dart';
import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/exercise_card_widget.dart';

class AiPresentTrainingsProgrammContent extends StatefulWidget {
  const AiPresentTrainingsProgrammContent({
    required this.getNewGoal,
    Key? key,
  }) : super(key: key);

  // final Goal? goal;
  final Function getNewGoal;

  @override
  State<AiPresentTrainingsProgrammContent> createState() => _AiPresentTrainingsProgrammContentState();
}

class _AiPresentTrainingsProgrammContentState extends State<AiPresentTrainingsProgrammContent> {
  late Goal goal;

  @override
  void initState() {
    goal = widget.getNewGoal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    dev.log('Width:  ${screenSize.width}');
    dev.log('Heigth:  ${screenSize.height}');
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Transform.scale(
            scale: 0.55,
            alignment: Alignment.topCenter,
            child: Container(
                height: screenSize.height,
                width: screenSize.width,
                // padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                decoration: BoxDecoration(
                  color: Styles.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    ///bottom right
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(10, 10),
                      blurRadius: 10,
                    ),

                    ///top left
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-3, -3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Column(
                      children: [
                        ///Plan Name
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, top: 32.0, right: 16.0, bottom: 16.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Workout',
                                    style: Styles.subLine.copyWith(color: Styles.darkGrey),
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
                                  Icon(
                                    UsedObjects.goalObjects
                                        .firstWhere((element) => element['titel'] == goal.trainingsProgramms[0].fitnesstype)['icon'],
                                    color: Styles.darkGrey,
                                    size: 30.0,
                                  ),
                                  Text(goal.trainingsProgramms[0].fitnesstype, style: Styles.smalText.copyWith(color: Styles.darkGrey)),
                                ],
                              ),
                              Column(
                                children: [
                                  Styles.levelIcon,
                                  Text(UsedObjects.trainingPlanDifficulty[goal.trainingsProgramms[0].difficultyLevel],
                                      style: Styles.smalText.copyWith(color: Styles.darkGrey)),
                                ],
                              ),
                              Column(
                                children: [
                                  Styles.timerIcon,
                                  Text('${goal.trainingsProgramms[0].durationWeeks.toString()} Weeks',
                                      style: Styles.smalText.copyWith(color: Styles.darkGrey)),
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
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ListView.builder(
                                padding: const EdgeInsets.only(top: 50.0, bottom: 100.0),
                                itemCount: goal.trainingsProgramms[0].plans.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 30.0),
                                    child: ExpansionTile(
                                      // trailing: Icon(Icons.arrow_drop_down_circle_rounded),
                                      // onExpansionChanged: ,
                                      tilePadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 10),
                                      collapsedIconColor: Styles.darkGrey,
                                      collapsedTextColor: Styles.darkGrey,
                                      iconColor: Styles.primaryColor,
                                      initiallyExpanded: index == 0,
                                      backgroundColor: Colors.transparent,
                                      title: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                helper_utils.truncatePlanName(
                                                  goal.trainingsProgramms[0].plans[index].name,
                                                  Styles.normalTextBold,
                                                  MediaQuery.of(context).size.width,
                                                ),
                                                style: Styles.normalTextBold,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(top: 4.0),
                                                width: 30.0,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: index == 0 ? Styles.primaryColor : Styles.grey,
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
                                            itemCount: goal.trainingsProgramms[0].plans[index].exercises.length,
                                            itemBuilder: (context, exeIndex) {
                                              //Exercise Name is Loading...
                                              return ExerciseCardWidget(
                                                selectedExercise: goal.trainingsProgramms[0].plans[index].exercises[exeIndex],
                                                showInfoScreen: () {},
                                                active: index == 0,
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          height: screenSize.height / 30,
                          decoration: const BoxDecoration(
                            color: Styles.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, -50),
                                blurRadius: 50,
                                spreadRadius: 100,
                              ),
                            ],
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0), bottomLeft: Radius.circular(50.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
        Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
