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
  aiGCEQ,
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

  static final List<Map<String, String>> gceqList = [
    {
      'question': 'Die folgenden Fragen helfen der KI dich besser zu Unterstützen!',
      'answer': '',
    },
    {
      'question': 'Wie wichtig sind Ihnen die folgenden Ziele beim Sporttreiben?',
      'answer': '',
    },
    {
      'question': 'Mit Anderen in einer sinnvollen Art und Weise zusammen zu kommen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Das Erscheinungsbild meiner Körperform zu verbessern, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Meine Widerstandsfähigkeit gegen Unwohlsein und Krankheit zu verbessern, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Von Anderen günstig beurteilt zu werden, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Neue sportliche Fähigkeiten zu erwerben, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Meine sportlichen Erfahrungen mit Menschen zu teilen, die mich mögen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Mein Aussehen zu verbessern, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Mein Leistungsvermögen zu verbessern, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Bei Anderen sozial angesehen zu sein, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Neue Techniken zu lernen und zu üben, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Enge Freundschaften aufzubauen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Schlank zu sein, um attraktiver auszusehen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Meine Gesundheit insgesamt zu verbessern, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Von Anderen positive Anerkennung zu erfahren, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Bestimmte Übungen oder Aktivitäten kompetent ausführen zu können, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Enge Bindungen mit Anderen einzugehen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Mein Aussehen zu verbessern, in dem ich bestimmte Bereiche meines Körpers verändere, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Meine Ausdauerfähigkeit zu erhöhen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Dass Andere mich als Sporttreibenden erkennen, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Meine sportlichen Fähigkeiten zu entwickeln, ist mir ...',
      'answer': '',
    },
    {
      'question': 'Gratulation, du hast alle Fragen beantwortet!',
      'answer': '',
    },
  ];
  static final List<String> gceqAnswer = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];
}
