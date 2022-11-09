import 'package:flutter/material.dart';
import 'package:higym/app_utils/circle_painter.dart';
import 'package:higym/app_utils/styles.dart';

import 'dart:developer' as dev;

import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double activityPercentage = 0.0;
  int doneWeeks = 0;
  int allWeeks = 0;
  double weekPercentage = 0.0;
  double weekNextPhasePercentage = 0.0;
  AppUser? user;
  Goal? goal;
  double totalActivityPoints = 0.0;
  int timesTrainedThisWeek = 0;
  int toTrainThisWeek = 0;
  String welcomeCardText = ' ';

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    goal = Provider.of<Goal?>(context);
    Size screenSize = MediaQuery.of(context).size;
    calculateActivity();
    calculateManyTimesTrainedThisWeek();
    calculateActualWeekAndPhase();
    dev.log('Width:  ${screenSize.width}');
    dev.log('Heigth:  ${screenSize.height}');
    return Scaffold(
        backgroundColor: Styles.white,
        body: userTester()
            ? ListView(
                padding: EdgeInsets.zero,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Home Welcome Card height ca 195
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 96.0, 32.0, 0.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Styles.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          ///bottom right
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(3, 3),
                            blurRadius: 3,
                          ),

                          ///top left
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(-3, -3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// Name and Badge
                          /// User Name and Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    style: Styles.homeCardName,
                                    children: [
                                      TextSpan(text: 'Hi ', style: Styles.title.copyWith(fontWeight: FontWeight.w500)),
                                      TextSpan(text: user!.name.toString(), style: Styles.title.copyWith(fontWeight: FontWeight.w300)),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset('assets/badges/${user!.activityLevel}.png', height: 75),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            children: [
                              Flexible(
                                child: Text(welcomeCardText, style: Styles.homeCardText),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'TE $timesTrainedThisWeek/$toTrainThisWeek',
                                      style: Styles.homeCardText,
                                    ),
                                  ),
                                  timesTrainedThisWeek < toTrainThisWeek
                                      ? Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: const BoxDecoration(
                                            color: Styles.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              // Text(
                              //   'Parameter',
                              //   style: Styles.homeCardText,
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                    child: SizedBox(
                      height: screenSize.width,
                      width: screenSize.width,
                      child: CustomPaint(
                        foregroundPainter: BackgroundCirclePainter(
                          progressBigPercent: activityPercentage,
                          progressBigReachPercent: 16 / 16,
                          progressSmallPercet: weekPercentage,
                          progressSmallReachPercet: weekNextPhasePercentage,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 2.0),
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: const BoxDecoration(
                                    color: Styles.progressCircleBig,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 56.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Points', style: Styles.homeProgressText),
                                      Text(totalActivityPoints.round().toString(), style: Styles.homeProgressText),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 2.0),
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: const BoxDecoration(
                                    color: Styles.progressCircleSmall,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 56.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Weeks', style: Styles.homeProgressText),
                                      Text('$doneWeeks/$allWeeks', style: Styles.homeProgressText),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const LoadingWidget());
  }

  bool userTester() {
    if (user != null) {
      if (user!.activityLevel != null) {
        dev.log('user!.activityLevel != null');
        return true;
      } else {
        dev.log('user!.activityLevel IST null');
        return false;
      }
    } else {
      dev.log('User IST null');
      return false;
    }
  }

  void calculateActivity() {
    if (user!.uid != '') {
      int lvlBronzeLimit = 1000;
      int lvlSilverLimit = 1699;
      int lvlGoldLimit = 2899;
      int lvlPlatinLimit = 4799;

      totalActivityPoints = 0.0;

      if (user!.activityPoints != null) {
        ActivityCalculator.updateActivityMap(user!.activityPoints!, user!.uid!);
        user!.activityPoints!.forEach((key, value) {
          setState(() {
            totalActivityPoints += value;
          });
        });
      }

      if (user != null) {
        setState(() {
          if (user!.activityLevel != null) {
            if (totalActivityPoints < lvlBronzeLimit) {
              setState(() {
                activityPercentage = totalActivityPoints / lvlBronzeLimit;
              });
              if (user!.activityLevel != 0) {
                DatabaseService(uid: user!.uid).updateActivityLevel(activityLevel: 0);
              }
            } else if (totalActivityPoints < lvlSilverLimit) {
              activityPercentage = (totalActivityPoints - lvlBronzeLimit) / (lvlSilverLimit - lvlBronzeLimit);
              if (user!.activityLevel != 1) {
                DatabaseService(uid: user!.uid).updateActivityLevel(activityLevel: 1);
              }
            } else if (totalActivityPoints < lvlGoldLimit) {
              activityPercentage = (totalActivityPoints - lvlSilverLimit) / (lvlGoldLimit - lvlSilverLimit);
              if (user!.activityLevel != 2) {
                DatabaseService(uid: user!.uid).updateActivityLevel(activityLevel: 2);
              }
            } else if (totalActivityPoints < lvlPlatinLimit) {
              activityPercentage = (totalActivityPoints - lvlGoldLimit) / (lvlPlatinLimit - lvlGoldLimit);
              if (user!.activityLevel != 3) {
                DatabaseService(uid: user!.uid).updateActivityLevel(activityLevel: 3);
              }
            } else {
              activityPercentage = 0.9999;
              if (user!.activityLevel != 4) {
                DatabaseService(uid: user!.uid).updateActivityLevel(activityLevel: 4);
              }
            }
          }
        });
      }
      dev.log('Activity Points and Level Updated');
    }
  }

  void calculateManyTimesTrainedThisWeek() {
    if (goal != null && user != null) {
      if (goal!.trainingsProgramms.isNotEmpty) {
        toTrainThisWeek = user!.dayFrequenz ?? goal!.trainingsProgramms[0].plans.length;
        timesTrainedThisWeek = 0;
        if (user!.activityPoints != null) {
          timesTrainedThisWeek = ActivityCalculator.manyTimesThisWeek(user!.activityPoints!);
        }

        if (timesTrainedThisWeek < toTrainThisWeek) {
          String zahlText = '';
          switch (toTrainThisWeek - timesTrainedThisWeek) {
            case 1:
              zahlText = 'ein';
              break;
            case 2:
              zahlText = 'zwei';
              break;
            case 3:
              zahlText = 'drei';
              break;
            case 4:
              zahlText = 'vier';
              break;
            case 5:
              zahlText = 'fünf';
              break;
            case 6:
              zahlText = 'sechs';
              break;
            case 7:
              zahlText = 'sieben';
              break;
            default:
              zahlText = 'ein';
              break;
          }
          welcomeCardText = 'Du solltest diese Woche noch $zahlText trainieren.';
        } else if (timesTrainedThisWeek == toTrainThisWeek) {
          welcomeCardText = 'Gratulation! Du hast dies Woche dein Trainingsziel erreicht!';
        } else {
          welcomeCardText = 'Zu viel trainieren ist nicht immer gut =)';
        }
      }
    }
  }

  /// Calculate actual Week->BluePercentageHomeScreen and actual Phase->DarkgreyPercentageHomeScreen
  /// Also Update Phase, if the Week is over!
  void calculateActualWeekAndPhase() {
    if (goal != null && user!.uid != '') {
      if (goal!.trainingsProgramms.isNotEmpty) {
        Map<String, int> weekCalculates = ActivityCalculator.calculateActualWeekAndPhase(goal!.trainingsProgramms[0], user!.uid!);
        doneWeeks = weekCalculates['passedWeeks']!;
        allWeeks = weekCalculates['allWeeks']!;

        double actualWeekFromAllWeeks = doneWeeks / allWeeks;
        double nextMileStoneWeekFromAllWeeks = weekCalculates['nextMileStone']! / allWeeks;

        if (actualWeekFromAllWeeks <= 1) {
          weekPercentage = actualWeekFromAllWeeks;
        } else {
          weekPercentage = 0.9999;
        }

        if (nextMileStoneWeekFromAllWeeks <= 1) {
          weekNextPhasePercentage = nextMileStoneWeekFromAllWeeks;
        } else {
          weekNextPhasePercentage = 0.9999;
        }
      }
    }
  }
}
