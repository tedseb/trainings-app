import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/services/database.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

class ActivityCalculator {
  double weight = 90.0;
  double size = 174.0;
  int age = 32;
  String gender = 'Male';

  int fitnessLevel = 1;
  int frequenzy = 3;

  final int trainingTime;
  final Map<String, double> activityPoints;

  ActivityCalculator({
    required this.trainingTime,
    required this.activityPoints,
  });

  double getWeigth() {
    double bmi = (weight / (size * size))*10000;

    if (bmi >= 30 && fitnessLevel < 2) {
      return 0.75 * (size - 100) + 0.25 * weight;
    } else {
      return weight;
    }
  }

  double calculateBasalMetabolicRate() {
    double calculatedWeight = getWeigth();

    if (gender != 'Female') {
      return (66.5 + (13.8 * calculatedWeight) + (5.0 * size) - (6.8 * age));
    } else {
      return (655 + (9.5 * calculatedWeight) + (1.9 * size) - (4.7 * age));
    }
  }

  double calculateActiveMetabolicRate() {
    double basalMetabolicRate = calculateBasalMetabolicRate();
    double palFactor;

    /// Here we have to calculate better so calculate the real "weakly done Frequenz"
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

  Map<String, double> getActivityPoints(AppUser user) {
    String toDay = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    weight = user.weigth!;
    size = user.size!;
    age = user.age!;
    gender = user.gender!;
    fitnessLevel = user.fitnessLevel!;
    frequenzy = user.dayFrequenz!;

    double activMetabolicRate = calculateActiveMetabolicRate();
    dev.log('Active MEtabolic rate:  $activMetabolicRate');
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

    activityMap.keys.where((k) => compareDateTimeThisWeek(k)).toList().forEach((activityKey) {
      if(activityMap[activityKey]! > 3) {
        timesThisWeek++;
      }
    }); //

    return timesThisWeek;
  }

  static bool compareDateTimeThisWeek(String compareDate) {
    DateTime date = DateTime.parse(compareDate);

    DateTime weekStart = thisWeekStart(addWeeks: 0);

    return date.isAfter(weekStart);
  }

  static DateTime thisWeekStart({required int addWeeks}) {
    DateTime now = DateTime.now();
    int nowWeekday = DateTime.now().weekday - 1;
    DateTime weekStart = DateTime(now.year, now.month, now.day - nowWeekday).add(Duration(days: addWeeks * 7));
    return weekStart;
  }

  static Map<String, int> calculateActualWeekAndPhase(TrainingPrograms trainingsprogram, String uid) {
    List<String> phases = trainingsprogram.phases;
    int passedDays = 0;
    int passedWeeks = 0;
    int nextMileStone = 4;

    DateTime phase1Start = DateTime.parse(phases[0]);
    DateTime phase2Start = DateTime.parse(phases[1]);
    DateTime phase3Start = DateTime.parse(phases[2]);
    DateTime goalEnding = DateTime.parse(phases[3]);
    DateTime now = DateTime.now();
    int allWeeks = goalEnding.difference(phase1Start).inDays ~/ 7;
    passedDays = now.difference(phase1Start).inDays;
    passedWeeks = passedDays ~/ 7;
    
    int actualPhase = 1;

    if (now.isBefore(phase2Start)) {
      nextMileStone = phase2Start.difference(phase1Start).inDays ~/ 7;
      actualPhase = 1;
    } else if (now.isBefore(phase3Start)) {
      nextMileStone = phase3Start.difference(phase1Start).inDays ~/ 7;
      actualPhase = 2;
    } else {
      nextMileStone = allWeeks;
      actualPhase = 3;
    }

    if(actualPhase != trainingsprogram.actualPhase){
       DatabaseService(uid: uid).updateActualPhase(actualPhase: actualPhase);
    }

    return {
      'passedWeeks': passedWeeks,
      'nextMileStone': nextMileStone,
      'allWeeks': allWeeks,
    };
  }
}
