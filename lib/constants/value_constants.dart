import 'package:flutter/cupertino.dart';
import 'package:higym/constants/icon_constants.dart';

enum PossibleAiScreens {
  signInScreen,
  signUpScreen,
  aiOnboardingScreen,
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

class ValueConstants {
  static final List<Map<String, dynamic>> navBarIcons = [
    {
      'icon': IconConstants.home,
      'text': 'HOME',
    },
    {
      'icon': IconConstants.plans,
      'text': 'PLANS',
    },
    {
      'icon': IconConstants.body,
      'text': 'BODY',
    },
    {
      'icon': IconConstants.adjust,
      'text': 'ADJUST',
    },
  ];

  static final List<Map<String, dynamic>> goalObjects = [
    {
      'icon': IconConstants.loseWeight,
      'titel': 'Abnehmen',
      'subTitel': 'Gewicht verlieren und Muskel erhalten',
      'goalGroup': 'Muskelwachstum',
      // 'goalGroup': 'Abnehmen',
    },
    {
      'icon': IconConstants.muscleBuilding,
      'titel': 'Muskel Aufbau',
      'subTitel': 'Muskelwachstum Maximieren',
      'goalGroup': 'Muskelwachstum',
    },
    {
      'icon': IconConstants.generalFitness,
      'titel': 'Generell Fitness',
      'subTitel': 'Stärke deinen Körper um angenehmer durch den Tag zu kommen',
      'goalGroup': 'Muskelwachstum',
      // 'goalGroup': 'Abnehmen',
    },
    {
      'icon': IconConstants.strengthenHealth,
      'titel': 'Gesundheit stärken',
      'subTitel': 'Bringe dein Imunsystem auf trap',
      'goalGroup': 'Muskelwachstum',
      // 'goalGroup': 'Abnehmen',
    },
    {
      'icon': IconConstants.tightenSkin,
      'titel': 'Haut straffen',
      'subTitel': 'Eine schönere und straffere Haut',
      'goalGroup': 'Muskelwachstum',
    },
  ];

  static final List<String> fitnessLevelText = [
    'Im Alltag gerate ich schnell in Atemnot.',
    'Damals habe ich viel Sport gemacht, aber ich bin schon lange davon abgekommen.',
    'Ab und zu versuche ich, Sport zu treiben, was mich zum Schwitzen bringt.',
    'Ich treibe zurzeit regelmäßig Fitness, mindestens 2 Mal pro Woche.',
    'Ich treibe fast jeden Tag Fitness.',
    'Ich bin ein Atleht!',
  ];

  static final List<Map<String, dynamic>> fitnessMethodObjects = [
    {
      'icon': IconConstants.machineTraining,
      'titel': 'Machinentraining',
    },
    {
      'icon': IconConstants.freeWeightsTraining,
      'titel': 'Training mit freien Gewichten',
    },
    {
      'icon': IconConstants.cardio,
      'titel': 'Cardio',
    },
    {
      'icon': IconConstants.all,
      'titel': 'Mix',
    },
  ];
  static final List<Map<String, dynamic>> additionalMusclegroupObject = [
    {
      'icon': IconConstants.fullBody,
      'titel': 'General',
      'General': 'General',
    },
    {
      'icon': IconConstants.po,
      'titel': 'Po/Beine',
      'Po/Beine': 'Po_Bein',
    },
    {
      'icon': IconConstants.shoulders,
      'titel': 'Schultern',
      'Schultern': 'Schulter',
    },
    {
      'icon': IconConstants.belly,
      'titel': 'Bauch',
      'Bauch': 'Bauch',
    },
    {
      'icon': IconConstants.arms,
      'titel': 'Arme',
      'Arme': 'Arm',
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

  static final List<String> trainingPlanDifficulty = [
    'Novice',
    'Beginners',
    'Intermediate',
    'Advanced',
    'Professional',
  ];
  static final Map<int, Icon> trainingPlanDifficultyIcons = {
    0: IconConstants.levelEasyIcon,
    1: IconConstants.levelEasyIcon,
    2: IconConstants.levelMediumIcon,
    3: IconConstants.levelMediumIcon,
    4: IconConstants.levelHardIcon,
  };

  static final List<int> ageList = List<int>.generate(90, (i) => i + 10);
  static final List<double> weightList = List<double>.generate(320, (i) => ((i / 2) + 40));
  static final List<double> sizeList = List<double>.generate(180, (i) => ((i / 2) + 130));
  static final List<String> genderList = ['Male', 'Female'];
}
