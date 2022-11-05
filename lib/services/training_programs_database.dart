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

  TrainingProgramsDatabase({
    required this.userGoalGroup,
    required this.userGoal,
    required this.userLevel,
    required this.userDayFrequenz,
    required this.userAdditionalMusclegroup,
    required this.userMinutesFrequenz,
  });

  /// Collection reference
  final CollectionReference trainingProgramsCollection = FirebaseFirestore.instance.collection('TrainingProgramsTest');

  Future<Goal> getNewGoal() async {
    CollectionReference<Map<String, dynamic>> goalLocation;
    if (userLevel == 0) {
      goalLocation =
          trainingProgramsCollection.doc(userGoalGroup).collection('Noob').doc('General').collection(userMinutesFrequenz);
    } else {
      goalLocation =
          trainingProgramsCollection.doc(userGoalGroup).collection(userDayFrequenz).doc(userAdditionalMusclegroup).collection(userMinutesFrequenz);
    }

    Goal newGoal = Goal.goalFromJson(InitialModels.goalJson);

    await goalLocation.get().then((QuerySnapshot snapshot) {
      int plansCounter = 0;

      final infoDoc = snapshot.docs.firstWhere((infoDoc) => infoDoc.id == 'info');
      newGoal.name = userGoal;
      newGoal.info = 'Goal Info';
      // newGoal.info = UsedObjects.goalObjects.firstWhere((element) => element['title'] == userGoal)['subTitel'];
      newGoal.trainingsProgramms[0].actualPhase = 0;
      newGoal.trainingsProgramms[0].actualPlan = infoDoc.get('splitOrder')[0];
      newGoal.trainingsProgramms[0].difficultyLevel = userLevel + 1;
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
        newGoal.trainingsProgramms[0].plans[plansCounter].name = splitOrderElement;
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
              media: exercise['eID'].toString() != null.toString() ? exercise['eID'] : 'noMedia',
              eID: exercise['eID'] ?? -1,
              alternativeExercises: _convertIntListsFromDynamic(exercise['alternativeExercises']),
              station: _convertStringListsFromDynamic(exercise['station'], 'station'),
              stationShort: _convertStringListsFromDynamic(exercise['stationShort'], 'stationShort'),
              handle: _convertStringListsFromDynamic(exercise['handle'], 'handle'),
              handleShort: _convertStringListsFromDynamic(exercise['handleShort'], 'handleShort'),
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
                'rangeFrom': double.tryParse(exercise['warmupWeight']) ?? 0.0,
                'rangeTo': 9999.0,
                'stepWidth': double.tryParse(exercise['weightInc']) ?? 0.0,
                'actualToDo': double.tryParse(exercise['warmupWeight']) ?? 0.0,
              },
              warmupInfo: exercise['warmupInfo'] ?? 'warmupInfo',
              warmupWeigth: double.tryParse(exercise['warmupWeight']) ?? 0.0,

              sets: [Sets(), Sets(), Sets()],
            ))
        .toList();
  }

  /// Ratio to list here
  List<double> ratioList(Map<dynamic, dynamic>? ratio) {
    if (ratio != null) {
      return [
        (ratio[(userLevel + 1).toString()][0]).toDouble(),
        (ratio[(userLevel + 1).toString()][1]).toDouble(),
      ];
    }
    return [-1, -1];
  }

  /// Convert List<dynamic> to List<String>
  List<String> _convertStringListsFromDynamic(List<dynamic>? list, String errorName) {
    List<String> returnList = [];

    if (list != null) {
      for (String element in list) {
        returnList.add(element);
      }
    }
    if (returnList.isEmpty) {
      returnList.add(errorName);
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
