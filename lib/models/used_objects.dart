import 'package:flutter/material.dart';

enum PossibleAiScreens {
  talkToAiContent,
  aiNameContent,
  aiPersonalDataContent,
  aiGoalContent,
  aiFrequenzyContent,
  aiReminderContent,
  aiGymEquipmentContent,
}

final List<Map<String, dynamic>> navBarIcons = [
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

final List<Map<String, dynamic>> goalObjects = [
  {
    'icon': Icons.sports_gymnastics_rounded,
    'titel': 'Generell Fitness',
    'subTitel': 'Gesund beleiben',
  },
  {
    'icon':Icons.fitness_center_rounded,
    'titel': 'Muskel Aufbau',
    'subTitel': 'Muskelwachstum Maximieren',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
  {
    'icon': Icons.monitor_weight_outlined,
    'titel': 'Abnehmen',
    'subTitel': 'Gewicht verlieren und Muskel erhalten',
  },
];
