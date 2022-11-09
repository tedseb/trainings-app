import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';

class TrainingsplanUpdater {
  String getNextPlanName(TrainingPrograms trainingsProgramm) {
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

  Plans getAndUpdateSelectedPlan({required Plans selectedPlan, required AppUser appUser, required int plansQuantity}) {
    for (Exercises exe in selectedPlan.exercises) {
      if (exe.rpeScale.isNotEmpty) {
        int rpeLength = exe.rpeScale.entries.length;
        int exeIndex = selectedPlan.exercises.indexOf(exe);

        ///check exercise in deloadPhase

        if (isDelooadPhaseDone(appUser: appUser, exeIndex: exeIndex, plansQuantity: plansQuantity, selectedPlan: selectedPlan)) {
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
            } else if (rpeLength > 1) {
              ///IF last 2 RPEs smaller -> reverse scale
              if (exe.rpeScale.entries.elementAt(rpeLength - 2).value == 3 /*&& exe.rpeScale.entries.elementAt(rpeLength - 3).value == 3*/) {
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
        } else {
          if (exe.rpeScale.entries.last.value != -1 && exe.rpeScale.entries.last.value != 2) {
            if (exe.weigthScale['stepWidth'] != 0.0) {
              if (exe.rpeScale.entries.last.value == 3) {
                exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! - (exe.weigthScale['stepWidth']! * 2);
              }
              if (exe.rpeScale.entries.last.value == 1) {
                exe.weigthScale['actualToDo'] = exe.weigthScale['actualToDo']! + exe.weigthScale['stepWidth']!;
              }
            }else{
               if (exe.rpeScale.entries.last.value == 3) {
                exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! - (exe.repetitionsScale['stepWidth']!*2);
              }
              if (exe.rpeScale.entries.last.value == 1) {
                 exe.repetitionsScale['actualToDo'] = exe.repetitionsScale['actualToDo']! + exe.repetitionsScale['stepWidth']!;
              }
            }
          }
        }
      }
    }
    return selectedPlan;
  }

  bool isDelooadPhaseDone({required int exeIndex, required Plans selectedPlan, required AppUser appUser, required int plansQuantity}) {
    int fitnessLevel = appUser.fitnessLevel ?? 0;
    int deloadCounter = 0;
    // int plansQuantity = trainingsProgramm.plans.length;
    int dailyFrequanz = appUser.dayFrequenz ?? 1;

    int deloadDuration = fitnessLevel > 0 ? 1 : 2;
    int deloadShouldBeQuantity = (dailyFrequanz / plansQuantity).round() * deloadDuration;

    selectedPlan.exercises[exeIndex].rpeScale.forEach((key, value) {
      if (value > -1) {
        deloadCounter++;
      }
    });

    if (deloadShouldBeQuantity >= deloadCounter) {
      return false;
    }
    return true;
  }
}
