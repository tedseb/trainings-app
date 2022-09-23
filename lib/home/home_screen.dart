import 'package:flutter/material.dart';
import 'package:higym/app_utils/circle_painter.dart';
import 'package:higym/app_utils/styles.dart';

import 'dart:developer' as dev;

import 'package:higym/models/app_user.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? activityPercentage;
  AppUser? user;

  @override
  Widget build(BuildContext context) {
    
    user = Provider.of<AppUser?>(context);
    Size screenSize = MediaQuery.of(context).size;
    calculateActivity();

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
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text('Du musst diese Woche noch einmal trainieren.', style: Styles.homeCardText),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Parameter',
                                style: Styles.homeCardText,
                              ),
                              Text(
                                'Parameter',
                                style: Styles.homeCardText,
                              ),
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
                          progressBigPercent: activityPercentage!,
                          progressBigReachPercent: 16 / 16,
                          progressSmallPercet: 6 / 16,
                          progressSmallReachPercet: 9 / 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                    color: Styles.progressCircleBig,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('50', style: Styles.homeProgressText),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                    color: Styles.progressCircleSmall,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('32', style: Styles.homeProgressText),
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
    
    int lvlBronzeLimit = 1000;
    int lvlSilverLimit = 1699;
    int lvlGoldLimit = 2899;
    int lvlPlatinLimit = 4799;
    double totalActivityPoints = 0.0;

    if (user!.activityPoints != null) {
      ActivityCalculator.updateActivityMap(user!.activityPoints!,user!.uid!);
      user!.activityPoints!.forEach((key, value) {
        totalActivityPoints += value;
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
