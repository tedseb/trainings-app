import 'package:higym/services/database.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

class ActivityCalculator {
  final double weight = 90.0;
  final double size = 174.0;
  final int age = 32;
  final bool man = true;
// double? broccaWeigth;
  final int fitnessLevel = 1;
  final int frequenzy = 3;

  final int trainingTime;
  final Map<String, double> activityPoints;

  ActivityCalculator({
    required this.trainingTime,
    required this.activityPoints,
  });

  double getWeigth() {
    double bmi = weight / (size * size);

    if (bmi >= 30 && fitnessLevel < 2) {
      return 0.75 * (size - 100) + 0.25 * weight;
    } else {
      return weight;
    }
  }

  double calculateBasalMetabolicRate() {
    double calculatedWeight = getWeigth();

    if (man) {
      return (66.5 + (13.8 * calculatedWeight) + (5.0 * size) - (6.8 * age));
    } else {
      return (655 + (9.5 * calculatedWeight) + (1.9 * size) - (4.7 * age));
    }
  }

  double calculateActiveMetabolicRate() {
    double basalMetabolicRate = calculateBasalMetabolicRate();
    double palFactor;

    if (frequenzy < 4) {
      palFactor = 1.4;
    } else {
      palFactor = 1.7;
    }

    return (basalMetabolicRate * palFactor);
  }

  static bool compareDateTimeOneMonth(String compareDate) {
    DateTime date = DateTime.parse(compareDate);
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day - 1);
    dev.log(oneMonthAgo.toString());
    return date.isBefore(oneMonthAgo);
  }

  Map<String, double> getActivityPoints() {
    String toDay = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

    double activMetabolicRate = calculateActiveMetabolicRate();
    double oneMET = activMetabolicRate / (24 * 60);

    double energyUseDuringWorkout = 7 * weight * trainingTime / 3600;

    double actualActivityPoints = energyUseDuringWorkout / oneMET;

    if (activityPoints[toDay] != null) {
      activityPoints[toDay] = activityPoints[toDay]! + actualActivityPoints;
    } else {
      activityPoints[toDay] = actualActivityPoints;
    }

    return activityPoints;
  }

  static updateActivityMap(Map<String, double> activityMap, String uid) {
    activityMap.keys
        .where((k) => compareDateTimeOneMonth(k)) // filter keys
        .toList() // create a copy to avoid concurrent modifications
        .forEach(activityMap.remove); //

    DatabaseService(uid: uid).updateActivityPoints(activityPoints: activityMap);
  }

  static int manyTimesThisWeek(Map<String, double> activityMap) {
    int timesThisWeek = 0;

    activityMap.keys.where((k) => compareDateTimeThisWeek(k)).toList().forEach((_) {
      timesThisWeek++;
    }); //

    return timesThisWeek;
  }

  static bool compareDateTimeThisWeek(String compareDate) {
    DateTime date = DateTime.parse(compareDate);
    DateTime now = DateTime.now();
    int nowWeekday = DateTime.now().weekday - 1;
    DateTime weekStart = DateTime(now.year, now.month, now.day - nowWeekday);

    return date.isAfter(weekStart);
  }

  static Map<String, int> calculateWeeksOver(Map<String, String> phases) {
    int passedDays = 0;
    int passedWeeks = 0;
    int nextMileStone = 4;
    
    

    DateTime phase1 = DateTime.parse(phases['1']!);
    DateTime phase2 = DateTime.parse(phases['2']!);
    DateTime phase3 = DateTime.parse(phases['3']!);
    DateTime phase4 =DateTime(phase3.year, phase3.month+1, phase3.day);
    DateTime now = DateTime.now();
    int allWeeks = phase4.difference(phase1).inDays~/7;
    passedDays = now.difference(phase1).inDays;
    passedWeeks = passedDays ~/ 7;

if(passedDays < phase2.difference(phase1).inDays){
  nextMileStone = phase2.difference(phase1).inDays ~/7;
}else if(passedDays < phase3.difference(phase1).inDays){
nextMileStone = phase3.difference(phase1).inDays ~/7;
}else {
  nextMileStone = allWeeks;
}
    

    return {
      'passedWeeks': passedWeeks,
      'nextMileStone': nextMileStone,
      'allWeeks': allWeeks,
    };
  }
}
