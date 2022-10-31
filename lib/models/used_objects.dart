import 'package:flutter/material.dart';
import 'package:higym/models/goal.dart';

enum PossibleAiScreens {
  talkToAiContent,
  aiNameContent,
  aiPersonalDataContent,
  aiGoalContent,
  aiFrequenzyContent,
  aiReminderContent,
  aiGymEquipmentContent,
  aiFitnessLevelContent,
  aiFitnessMethodsContent,
  aiAdditionalMusclegroupContent,
  aiPresentTrainingsProgrammContent,
}

enum OnBoardingBottomNavBar {
  startScreen,
  contentScreen,
  planScreen,
  registerScreen,
}

class UsedObjects {
  static final List<Map<String, dynamic>> navBarIcons = [
    {
      'icon': Icons.home_outlined,
      'text': 'Home',
    },
    {
      'icon': Icons.person_outline_rounded,
      'text': 'Profile',
    },
    {
      'icon': Icons.phone_iphone_rounded,
      'text': 'Plans',
    },
    {
      'icon': Icons.widgets_rounded,
      'text': 'Status',
    },
  ];

  static final List<Map<String, dynamic>> goalObjects = [
  
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Abnehmen',
      'subTitel': 'Gewicht verlieren und Muskel erhalten',
    },
    {
      'icon': Icons.fitness_center_rounded,
      'titel': 'Muskel Aufbau',
      'subTitel': 'Muskelwachstum Maximieren',
    },
      {
      'icon': Icons.sports_gymnastics_rounded,
      'titel': 'Generell Fitness',
      'subTitel': 'Stärke deinen Körper um angenehmer durch den Tag zu kommen',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Gesundheit stärken',
      'subTitel': 'Bringe dein Imunsystem auf trap',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Haut straffen',
      'subTitel': 'Eine schönere und straffere Haut',
    },
  ];

 static final List<String> fitnessLevelText = [
    'Gar kein Sport',
    'Gelegenheits Sport',
    'Regelmäßig Sport',
    'Sehr oft Sport',
    'Athlet',
  ];

  static final List<Map<String, dynamic>> fitnessMethodObjects = [
    {
      'icon': Icons.sports_gymnastics_rounded,
      'titel': 'Machinentraining',
    },
    {
      'icon': Icons.fitness_center_rounded,
      'titel': 'Training mit freien Gewichten',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Cardio',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Mix',
    },
  ];
  static final List<Map<String, dynamic>> additionalMusclegroupObject = [
    {
      'icon': Icons.sports_gymnastics_rounded,
      'titel': 'Generel',
    },
    {
      'icon': Icons.sports_gymnastics_rounded,
      'titel': 'Po/Beine',
    },
    {
      'icon': Icons.fitness_center_rounded,
      'titel': 'Schultern',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Bauch',
    },
    {
      'icon': Icons.monitor_weight_outlined,
      'titel': 'Arme',
    },
  ];

  static final List<Map<String, bool>> gymEquipment = [
    {'Langhantel': true},
    {'Kabelzug': true},
    {'Schrägbank': true},
    {'Kurzhantel': true},
    {'T-Seil': true},
    {'Flachbank': true},
    {'Turm': true},
    {'SZ-Stange': true},
  ];


 static final Goal shawanGoal = Goal(
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
        phases: [
          '2022-09-20',
          '2022-10-20',
          '2022-11-20',
          '2022-12-20',
        ],
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


}
