import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/services/activity_calculator.dart';
import 'dart:developer' as developer;

import 'package:intl/intl.dart';

class TrainingProgramsDatabase {
  final String userGoalGroup;
  final String userGoal;
  final int userLevel;
  final String userDayFrequenz;
  final String userAdditionalMusclegroup;
  final String userMinutesFrequenz;
  final AppUser appUser;

  TrainingProgramsDatabase({
    required this.userGoalGroup,
    required this.userGoal,
    required this.userLevel,
    required this.userDayFrequenz,
    required this.userAdditionalMusclegroup,
    required this.userMinutesFrequenz,
    required this.appUser,
  });

  /// Collection reference
  final CollectionReference trainingProgramsCollection = FirebaseFirestore.instance.collection('TrainingPrograms');

  Future<Goal> getNewGoal() async {
    CollectionReference<Map<String, dynamic>> goalLocation;
    if (userLevel == 0) {
      goalLocation = trainingProgramsCollection.doc(userGoalGroup).collection('Noob').doc('General').collection(userMinutesFrequenz);
    } else {
      goalLocation = trainingProgramsCollection
          .doc(userGoalGroup)
          .collection(userDayFrequenz)
          .doc(UsedObjects.additionalMusclegroupObject
              .firstWhere((element) => element['titel'] == userAdditionalMusclegroup)[userAdditionalMusclegroup])
          .collection(userMinutesFrequenz);
    }

    Goal newGoal = Goal.goalFromJson(InitialModels.goalJson);

    await goalLocation.get().then((QuerySnapshot snapshot) {
      int plansCounter = 0;

      final infoDoc = snapshot.docs.firstWhere((infoDoc) => infoDoc.id == 'info');
      newGoal.name = userGoal;
      newGoal.info = 'Goal Info';
      // newGoal.info = UsedObjects.goalObjects.firstWhere((element) => element['title'] == userGoal)['subTitel'];
      newGoal.trainingsProgramms[0].actualPhase = 0;
      newGoal.trainingsProgramms[0].actualPlan = 'Split ${infoDoc.get('splitOrder')[0]}';
      newGoal.trainingsProgramms[0].difficultyLevel = userLevel;
      newGoal.trainingsProgramms[0].durationWeeks = int.tryParse(infoDoc.get('tpDuration')) ?? 12;
      newGoal.trainingsProgramms[0].fitnesstype = userGoal;
      newGoal.trainingsProgramms[0].info = 'Trainingsprogram Info';
      newGoal.trainingsProgramms[0].name = 'Trainingsprogram';
      newGoal.trainingsProgramms[0].phases[0] = DateFormat('yyyy-MM-dd').format(ActivityCalculator.thisWeekStart(addWeeks: 0));
      newGoal.trainingsProgramms[0].phases[1] = DateFormat('yyyy-MM-dd').format(ActivityCalculator.thisWeekStart(addWeeks: 2));
      newGoal.trainingsProgramms[0].phases[2] = DateFormat('yyyy-MM-dd').format(ActivityCalculator.thisWeekStart(addWeeks: 6));
      newGoal.trainingsProgramms[0].phases[3] = DateFormat('yyyy-MM-dd').format(ActivityCalculator.thisWeekStart(addWeeks: 10));

      while (newGoal.trainingsProgramms[0].plans.length != infoDoc.get('splitOrder').length) {
        newGoal.trainingsProgramms[0].plans.add(Plans.plansFromJson(InitialModels.plansJson));
      }

      for (var splitOrderElement in infoDoc.get('splitOrder')) {
        final exeListDoc = snapshot.docs.firstWhere((planDocs) => planDocs.id == splitOrderElement);
        newGoal.trainingsProgramms[0].plans[plansCounter].name = 'Split $splitOrderElement';
        newGoal.trainingsProgramms[0].plans[plansCounter].exercises = _fillExercises(exeListDoc.get('exercises'));
        plansCounter++;
      }
    });
    return newGoal;
  }

  // Convert all Exercises
  List<Exercises> _fillExercises(List exercises) {
    return exercises
        .map((exercise) => Exercises(
              name: exercise['name'] ?? 'Exercise Name',
              subName: exercise['subName'] ?? 'Exercise SubName',
              info: exercise['info'] ?? 'Exercise Info',
              media: exercise['eId'].toString() != null.toString() ? checkMedia(exercise['eId']) : 'noMedia',
              eID: exercise['eId'].toInt() ?? -1,
              alternativeExercises: _convertIntListsFromDynamic(exercise['alternativeExercises']),
              station: _convertStringListsFromDynamic(exercise['station']),
              stationShort: _convertStringListsFromDynamic(exercise['stationShort']),
              handle: _convertStringListsFromDynamic(exercise['handle']),
              handleShort: _convertStringListsFromDynamic(exercise['handleShort']),
              ratio: ratioList(exercise['ratios']),
              repetitionsScale: {
                'rangeFrom': exercise['repetitions'][0],
                'rangeTo': exercise['repetitions'][1],
                'stepWidth': 1,
                'actualToDo': 15,
              },

              /// ToDo: Later check if its a repetitions ecercise or time ecercise
              setDoTimeScale: {
                'rangeFrom': 0,
                'rangeTo': 0,
                'stepWidth': 0,
                'actualToDo': 0,
              },
              setRestTimeScale: {
                'rangeFrom': exercise['restTime'][0],
                'rangeTo': exercise['restTime'][1],
                'stepWidth': exercise['restTimeInc'] ?? 0,
                'actualToDo': exercise['restTime'][0],
              },
              weigthScale: {
                'rangeFrom':
                    startWeight(ratioList(exercise['ratios']), double.tryParse(exercise['warmupWeight']), double.tryParse(exercise['weightInc'])),
                'rangeTo': 9999.0,
                'stepWidth': double.tryParse(exercise['weightInc']) ?? 0.0,
                'actualToDo':
                    startWeight(ratioList(exercise['ratios']), double.tryParse(exercise['warmupWeight']), double.tryParse(exercise['weightInc'])),
              },
              warmupInfo: exercise['warmupInfo'] ?? 'warmupInfo',
              warmupWeigth: double.tryParse(exercise['warmupWeight']) ?? 0.0,

              sets: [Sets(), Sets(), Sets()],
            ))
        .toList();
  }

  String checkMedia(num exeID) {
    if (exeID == 1 || exeID == 8 || exeID == 18 || exeID == 27 || exeID == 39) {
      return exeID.round().toString();
    } else {
      return 'noMedia';
    }
  }

  /// Ratio to list here
  List<double> ratioList(Map<dynamic, dynamic>? ratio) {
    int lvlOverEstimateProtection = userLevel != 0 ? userLevel - 1 : userLevel;
    if (ratio != null) {
      return [
        (ratio[(lvlOverEstimateProtection + 1).toString()][0]).toDouble(),
        (ratio[(lvlOverEstimateProtection + 1).toString()][1]).toDouble(),
      ];
    }
    return [-1, -1];
  }

  /// Start Weight Calculator
  double startWeight(List<double> ratioList, double? warmupWeight, double? weightInc) {
    double ratio = appUser.gender == 'Male' ? ratioList[0] : ratioList[1];
    double userWeight = appUser.weigth != null ? appUser.weigth!.last.entries.first.value : 70.0;
    double userSize = appUser.size ?? 175.0;
    double userBMI = (userWeight / (userSize * userSize)) * 10000;

    if (userBMI > 24) {
      userWeight = (24 / 10000) * userSize * userSize;
    }

    warmupWeight ??= 0.0;
    weightInc ??= 0.0;

    double startWeight = 0.0;

    if (weightInc != 0.0) {
      startWeight = userWeight * ratio * 0.6;

      ///check if negative
      if (startWeight < 0) {
        startWeight = startWeight * (-1);
        startWeight = startWeight - userWeight;
        // startWeight = startWeight +(startWeight* 0.4);
        startWeight = startWeight - (startWeight % 2.5);
        return startWeight;
      }

      /// If it is a positiv ratio
      // startWeight = startWeight * 0.6;

      if (startWeight < warmupWeight) {
        startWeight = warmupWeight;
      }

      startWeight = startWeight - (startWeight % 2.5);
    }

    return startWeight;
  }

  /// Convert List<dynamic> to List<String>
  List<String> _convertStringListsFromDynamic(List<dynamic>? list) {
    List<String> returnList = [];

    if (list != null) {
      if (list.isNotEmpty) {
        for (String element in list) {
          returnList.add(element);
        }
      }
    }

    return returnList;
  }

  /// Convert List<dynamic> to List<int>
  List<int> _convertIntListsFromDynamic(List<dynamic>? list) {
    List<int> returnList = [];

    if (list != null) {
      for (int element in list) {
        returnList.add(element);
      }
    }
    if (returnList.isEmpty) {
      returnList.add(-1);
      returnList.add(-1);
    }
    return returnList;
  }
}
