import 'package:higym/models/goal.dart';

class TrainingsplanUpdater {
  String getNextPlanName(TrainingsProgramms trainingsProgramm) {
    String nextPlanName = '';
    int actualPlanIndex = -1;

    actualPlanIndex = trainingsProgramm.plans.indexWhere((element) => element.name == trainingsProgramm.actualPlan);

    actualPlanIndex++;

    if (actualPlanIndex == trainingsProgramm.plans.length) {
      actualPlanIndex = 0;
    }
    nextPlanName = trainingsProgramm.plans[actualPlanIndex].name;

    return nextPlanName;
  }

  Plans getAndUpdateSelectedPlan(Plans myPlan) {
    for (Exercises exe in myPlan.exercises) {
      if (exe.rpeScale.isNotEmpty) {
        int rpeLength = exe.rpeScale.entries.length;

        if (exe.rpeScale.entries.last.value != -1) {
          if (exe.rpeScale.entries.last.value != 3) {
            if (exe.setDoTimeScale['actualToDo'] != 0 && exe.setDoTimeScale['actualToDo']! < exe.setDoTimeScale['rangeTo']!) {
              /// Increase Set Do Time
              exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['actualToDo']! + exe.setDoTimeScale['stepWidth']!;
            } else if (exe.repetitionsScale['actualToDo']! < exe.repetitionsScale['rangeTo']!) {
              /// Increase Repetition
              exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! + exe.repetitionsScale['stepWidth']!;
            } else if (exe.setRestTimeScale['actualToDo']! > exe.setRestTimeScale['rangeTo']!) {
              /// Decrease Rest Time
              exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['actualToDo']! - exe.setRestTimeScale['stepWidth']!;
            } else {
              /// Increase Weigth
              exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! + exe.weigthScale['stepWidth']!;

              /// Decrease
              exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['rangeFrom']!;
              exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['rangeFrom']!;
              exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['rangeFrom']!;
            }
          } else if (rpeLength > 2) {
            ///IF last 3 RPEs smaller -> reverse scale
            if (exe.rpeScale.entries.elementAt(rpeLength - 2).value == 3 && exe.rpeScale.entries.elementAt(rpeLength - 3).value == 3) {
              if (exe.repetitionsScale['actualToDo']! == exe.repetitionsScale['rangeFrom']! &&
                  exe.setDoTimeScale['actualToDo']! == exe.setDoTimeScale['rangeFrom']! &&
                  exe.setRestTimeScale['actualToDo']! == exe.setRestTimeScale['rangeFrom']!) {
                /// Decrease Weigth
                exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! - exe.weigthScale['stepWidth']!;

                /// Increase
                exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['rangeFrom']!;
                exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['rangeFrom']!;
                exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['rangeFrom']!;
              } else if (exe.setRestTimeScale['actualToDo']! < exe.setRestTimeScale['rangeFrom']!) {
                /// Increase Rest Time
                exe.setRestTimeScale['actualToDo'] = exe.setRestTimeScale['actualToDo']! + exe.setRestTimeScale['stepWidth']!;
              } else if (exe.setDoTimeScale['actualToDo'] != 0) {
                /// Decrease Set Do Time
                exe.setDoTimeScale['actualToDo'] = exe.setDoTimeScale['actualToDo']! - exe.setDoTimeScale['stepWidth']!;
              } else {
                /// Decrease Repetition
                exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! - exe.repetitionsScale['stepWidth']!;
              }
            }
          }
        }
      }
    }
    return myPlan;
  }
}
