import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/screen_widgets/settings_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Goal myGoal = Goal(
    info: 'Hier stehen paar informationen über das Goal',
    name: 'So heißt mein Goal',
    trainingsProgramms: [
      TrainingsProgramms(
        name: 'Generel Fitness',
        info: 'Trainingsprogramm Info',
        fitnesstype: 'Kraft',
        difficultyLevel: 1,
        durationWeeks: 12,
        actualPhase: 2,
        actualPlan: 'Full Body Plan',
        plans: [
          Plans(
            name: 'Full Body Plan',
            time: 0,
            exercises: [
              Exercises(
                name: 'Military Press',
                info: 'Info über Military Press',
                media: 'military_press',
                pk: 229,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 300,
                  'rangeTo': 180,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Squats',
                media: 'squats',
                info: 'Info über Squats',
                pk: 111,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 300,
                  'rangeTo': 180,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Deadlifts',
                media: 'deadlifts',
                info: 'Info über Deadlifts',
                pk: 105,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 300,
                  'rangeTo': 180,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Rudern Stehend',
                media: 'rudern_stehend',
                info: 'Info über Rudern Stehend',
                pk: 106,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 300,
                  'rangeTo': 180,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Bankdrücken',
                media: 'bankdruecken',
                info: 'Info über Bankdrücken',
                pk: 102,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 300,
                  'rangeTo': 180,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// User Name and Badge
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
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
                    child: Image.asset('assets/badges/weight_nike_badge.png', height: 75),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height/10),

            /// Goals Button it will go
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.gymyGrey,
                        child: Icon(Icons.flag_outlined, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                      Text('My Goals', style: Styles.profileItemText),
                    ],
                  ),
                  ShadowIconButtonWidget(
                      buttonIcon: Icons.chevron_right_rounded,
                      onPressFunction: () {
                        DatabaseService(uid: user.uid!).addGoal(myGoal);
                      }),
                ],
              ),
            ),

            /// My Body Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.gymyGrey,
                        child: Icon(Icons.accessibility_new_rounded, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                      Text('My Body', style: Styles.profileItemText),
                    ],
                  ),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),

            /// Talk to AI Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.gymyGrey,
                        child: Icon(Icons.surround_sound_outlined, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                      Text('Talk AI', style: Styles.profileItemText),
                    ],
                  ),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),

            /// Settings Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.gymyGrey,
                        child: Icon(Icons.settings_outlined, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                      Text('Settings', style: Styles.profileItemText),
                    ],
                  ),
                  ShadowIconButtonWidget(
                      buttonIcon: Icons.chevron_right_rounded,
                      onPressFunction: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      }),
                ],
              ),
            ),

            /// Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.gymyGrey,
                        child: Icon(Icons.logout_rounded, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                      Text('Log Out', style: Styles.profileItemText),
                    ],
                  ),
                  ShadowIconButtonWidget(
                      buttonIcon: Icons.chevron_right_rounded,
                      onPressFunction: () async {
                        dev.log('Open Logout Screen');

                        await _auth.signOut();
                      }),
                ],
              ),
            ),
            const SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
}
