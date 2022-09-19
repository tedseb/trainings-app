class ActivityCalculator {
  final double weight = 90.0;
  final double size = 174.0;
  final int age = 32;
  final bool man = true;
// double? broccaWeigth;
  final int fitnessLevel = 1;
  final int frequenzy = 3;

  final int trainingTime;
  final double activityPoints;

   ActivityCalculator({
    required this.trainingTime,
    required this.activityPoints,
  });

  double getWeigth() {
    double bmi= weight / (size * size);

    if (bmi >= 30 && fitnessLevel < 2) {
      return 0.75 * (size - 100) + 0.25 * weight;
    } else {
      return weight;
    }
  }

  double calculateBasalMetabolicRate() {

    double calculatedWeight = getWeigth();

    if(man){
      return  (66.5 + (13.8 * calculatedWeight) + (5.0 * size) - (6.8 *age));
    }else{
     return (655 + (9.5 * calculatedWeight) + (1.9 * size) - (4.7 *age));
    }
  
  
  }


  double calculateActiveMetabolicRate(){

    double basalMetabolicRate = calculateBasalMetabolicRate();
    double palFactor;

    if(frequenzy<4){
      palFactor = 1.4;
    }else{
      palFactor = 1.7;
    }

    return (basalMetabolicRate * palFactor);


  }



  double getActivityPoints (){

    double activMetabolicRate = calculateActiveMetabolicRate();
    double oneMET = activMetabolicRate/(24*60);

    double energyUseDuringWorkout = 7*weight * trainingTime;

    double actualActivityPoints = energyUseDuringWorkout / oneMET;
    double totalActivityPoints = activityPoints + actualActivityPoints;

    return totalActivityPoints;
    
  }













}
