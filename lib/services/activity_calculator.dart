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


  static bool compareDateTimeOneMonth(String compareDate){

 DateTime date = DateTime.parse(compareDate);
 DateTime now = DateTime.now();
 DateTime oneMonthAgo = DateTime(now.year, now.month-1, now.day-1 );
 dev.log(oneMonthAgo.toString());
  return date.isBefore(oneMonthAgo);

  }


  Map<String, double> getActivityPoints() {
String toDay = DateFormat('yyyy-MM-dd').format(DateTime.now());

    double activMetabolicRate = calculateActiveMetabolicRate();
    double oneMET = activMetabolicRate / (24 * 60);

    double energyUseDuringWorkout = 7 * weight * trainingTime / 3600;

    double actualActivityPoints = energyUseDuringWorkout / oneMET;
    

//new
    // double totalActivityPoints = 0;
    // activityPoints.forEach((key, value) {
    //   totalActivityPoints += value;
    // });
    // old
    // double totalActivityPoints = activityPoints + actualActivityPoints;
    if (activityPoints[toDay] != null) {
  activityPoints[toDay] = activityPoints[toDay]!+actualActivityPoints*1000;
}else{
  activityPoints[toDay] = actualActivityPoints;
}



    return activityPoints;
  }

  static updateActivityMap(Map<String, double> activityMap, String uid){
    activityMap.keys
  .where((k) => compareDateTimeOneMonth(k)) // filter keys
  .toList() // create a copy to avoid concurrent modifications
  .forEach(activityMap.remove); //

     DatabaseService(uid:uid).updateActivityPoints(activityPoints: activityMap);

  }
}
