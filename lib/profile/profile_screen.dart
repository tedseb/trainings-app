import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/widgets/general_widgets/row_item_with_select_widget.dart';
import 'package:higym/widgets/screen_widgets/about_screen.dart';
import 'package:higym/widgets/screen_widgets/talk_to_ai_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';
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
        phases: {
          '1': '2022-09-20',
          '2': '2022-10-20',
          '3': '2022-11-20',
        },
        actualPlan: 'Full Body Plan',
        plans: [
          Plans(
            name: 'Full Body Plan',
            time: 0,
            exercises: [
              Exercises(
                name: 'Military Press',
                subName: 'Sub Name',
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
                subName: 'Sub Name',
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
                subName: 'Sub Name',
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
                subName: 'Sub Name',
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
                subName: 'Sub Name',
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

  // Standard Exercises and Biceps
  // Standard Exercises and Triceps
  // Niche Exercises

  final Goal shawanGoal = Goal(
    name: 'General Fitness',
    info: 'Shawans Goal',
    trainingsProgramms: [
      TrainingsProgramms(
        name: '3TE Full Body 40-50',
        info: 'Drei Trainingseinheiten pro Woche, jeweils 40 bis 50 Minuten, für den ganzen Körper',
        fitnesstype: 'Kraft',
        difficultyLevel: 1,
        durationWeeks: 12,
        actualPhase: 2,
        phases: {
          '1': '2022-09-20',
          '2': '2022-10-20',
          '3': '2022-11-20',
        },
        actualPlan: 'Standard Exercises and Biceps',
        plans: [
          Plans(
            name: 'Standard Exercises and Biceps',
            exercises: [
              Exercises(
                name: 'Rumänisches Kreuzheben',
                subName: 'Langhantel',
                info: 'Info Rumänisches Kreuzheben',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
                  'stepWidth': 1,
                  'actualToDo': 10,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 70.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Latzug',
                subName: 'Kabelzug - breit',
                info: 'Info Latzug',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 9,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 75.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Positiv Brust',
                subName: 'Schrägbank - Kurzhantel',
                info: 'Info Positiv Brust',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 25.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Fliegende',
                subName: 'Schrägbank - Kurzhantel',
                info: 'Info Fliegende',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 20.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Facepulls',
                subName: 'Kabelzug - T-Seil',
                info: 'Info Facepulls',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 10,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 36.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Trizeps Seil',
                subName: 'Kabelzug - T-Seil',
                info: 'Info Trizeps Seil',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 7,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 41.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
            ],
          ),
          Plans(
            name: 'Standard Exercises and Triceps',
            exercises: [
              Exercises(
                name: 'Kniebeuger',
                subName: 'Langhantel',
                info: 'Info Kniebeuger',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
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
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 80.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Rudern',
                subName: 'Kabelzug - eng',
                info: 'Info Rudern',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
                  'stepWidth': 1,
                  'actualToDo': 10,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 59.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Bankdrücken',
                subName: 'Flachbank',
                info: 'Info Bankdrücken',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 90.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Klimmzüge',
                subName: 'Turm - Breit',
                info: 'Info Klimmzüge',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': -23.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Over Head Press',
                subName: 'Flachbank - Schulterbreit',
                info: 'Info Over Head Press',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 25.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Bizeps Curls',
                subName: 'Kurzhantel',
                info: 'Info Bizeps Curls',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 9,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 12.5,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
            ],
          ),
          Plans(
            name: 'Niche Exercises',
            exercises: [
              Exercises(
                name: 'Normales Kreuzheben',
                subName: 'Langhantel',
                info: 'Info Normales Kreuzheben',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 80.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Rudern',
                subName: 'Langhantel',
                info: 'Info Rudern',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 10,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 75.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Dips',
                subName: 'Turm',
                info: 'Info Dips',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 12,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 120,
                  'rangeTo': 120,
                  'stepWidth': 0,
                  'actualToDo': 120,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 0.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Seitenheber',
                subName: 'Kurzhantel',
                info: 'Info Seitenheber',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 8.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Stirndrücken',
                subName: 'Flachbank, SZ-Stange - eng',
                info: 'Info Stirndrücken',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 8,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 15.0,
                },
                sets: [
                  Sets(),
                  Sets(),
                  Sets(),
                ],
              ),
              Exercises(
                name: 'Bizeps',
                subName: 'SZ-Stange - Schulterbreit',
                info: 'Info Bizeps',
                media: 'noMedia',
                pk: -1,
                repetitionsScale: {
                  'rangeFrom': 8,
                  'rangeTo': 12,
                  'stepWidth': 1,
                  'actualToDo': 10,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 90,
                  'rangeTo': 90,
                  'stepWidth': 0,
                  'actualToDo': 90,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 5.0,
                  'actualToDo': 20.0,
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
      ),
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
            SizedBox(height: screenSize.height / 10),

            /// Goals Button it will go
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.flag_outlined,
                widgetText: 'My Goals',
                onPressFunction: () {
                  DatabaseService(uid: user.uid!).addGoal(shawanGoal);
                },
              ),
            ),

            /// My Body Button
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: RowItemWithSelectWidget(
                  leadingIcon: Icons.accessibility_new_rounded,
                  widgetText: 'My Body',
                  onPressFunction: () {},
                )),

            /// Talk to AI Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.surround_sound_outlined,
                widgetText: 'Talk AI',
                onPressFunction: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalkToAiScreen(appUser: user),
                    ),
                  );
                },
              ),
            ),

            /// Settings Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.settings_outlined,
                widgetText: 'About',
                onPressFunction: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),
            ),

            /// Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.logout_rounded,
                widgetText: 'Log Out',
                onPressFunction: () async {
                  await _auth.signOut();
                },
              ),
            ),
            const SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
}
