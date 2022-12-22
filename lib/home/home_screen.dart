import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/paintings/circle_painter.dart';
import 'package:higym/paintings/rounded_dot_painter.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/general_widgets/shadow_card_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/user_name_badge_widget.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

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

    dev.log('Width:  ${screenSize.width}');
    dev.log('Heigth:  ${screenSize.height}');
    return Scaffold(
      backgroundColor: Styles.white,
      body: userTester()
          ? ListView(
              padding: EdgeInsets.zero,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Spacer
                const SizedBox(height: 96),

                /// Home Welcome Card height ca 195
                ShadowCardWidget(
                  cardChild: Column(
                    children: [
                      /// User Name and Badge
                      UserNameBadgeWidget(userName: user!.name.toString(), userLvl: user!.activityLevel!),

                      /// Spacer
                      const SizedBox(height: 24.0),

                      /// Welcome Card Text
                      Text(welcomeCardText, style: Styles.normalLinesLight),

                      /// Spacer
                      const SizedBox(height: 24.0),

                      /// Training Unit Counter
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
                                  style: Styles.smallLinesLight,
                                ),
                              ),
                              timesTrainedThisWeek < toTrainThisWeek
                                  ? const RoundedDotPainter(radius: 7.0, dotColor: Styles.primaryColor)
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      )
                    ],
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

                      /// Activity Points and Goal Weeks
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Activity Points
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Activity Points Orange Dot
                              const RoundedDotPainter(radius: 15.0, dotColor: Styles.orange, topMargin: 2.0),

                              /// Spacer
                              const SizedBox(width: 4),

                              /// Activity Points Text
                              SizedBox(
                                width: 56.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Points', style: Styles.normalLinesLight),
                                    Text(totalActivityPoints.round().toString(), style: Styles.normalLinesLight),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          /// Spacer
                          const SizedBox(height: 5),

                          /// Goal Weeks
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Goal Weeks Blue Dot
                              const RoundedDotPainter(radius: 15.0, dotColor: Styles.blue, topMargin: 2.0),

                              /// Spacer
                              const SizedBox(width: 4),

                              /// Goal Weeks Text
                              SizedBox(
                                width: 56.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Weeks', style: Styles.normalLinesLight),
                                    Text('$doneWeeks/$allWeeks', style: Styles.normalLinesLight),
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
          : const LoadingWidget(),
    );
  }

  bool userTester() {
    if (user == null) {
      dev.log('User NULL', name: 'Home_Screen');
      return false;
    }

    if (user!.activityLevel == null) {
      dev.log('Activity_Level NULL', name: 'Home_Screen');
      return false;
    }

    dev.log('User OK', name: 'Home_Screen');
    calculateActivity();
    calculateManyTimesTrainedThisWeek();
    calculateActualWeekAndPhase();

    return true;
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
          welcomeCardText = 'Du solltest diese Woche noch $zahlText mal trainieren.';
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
