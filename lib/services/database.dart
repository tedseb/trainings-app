import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'dart:developer' as developer;

class DatabaseService {
  final String? uid;

  DatabaseService({
    required this.uid,
  });

  /// Collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  // START - User Related Data------------------------------------------------------------------------------------------------
  /// Update User
  Future updateUserData(String userName, String userMail) {
    return usersCollection.doc(uid).set({
      'userName': userName,
      'userMail': userMail,
    });
  }

  /// Get User-Data
  Stream<AppUser> get getUserData {
    final docUser = usersCollection.doc(uid);
    return docUser.snapshots().map(
          (event) => AppUser(
            name: event.get('userName'),
            uid: uid,
            // email: event.get('userMail'),
          ),
        );
  }
  // END - User Related Data------------------------------------------------------------------------------------------------

  // -----------------------------------------START - ADD My Goal--------------------------------
  /// Add Goal
  Future addGoal(Goal goal) async {
    usersCollection.doc(uid).update({
      'userGoal': {
        'goalName': goal.name,
        'goalInfo': goal.info,
      },
    });
    // Map<String, Plans> addPlanAsMap
    for (var trainingsProgramm in goal.trainingsProgramms) {
      Map<String, dynamic> addTraningsProgramm = {
        'name': trainingsProgramm.name,
        'info': trainingsProgramm.info,
        'fitnesstype': trainingsProgramm.fitnesstype,
        'difficultyLevel': trainingsProgramm.difficultyLevel,
        'durationWeeks': trainingsProgramm.durationWeeks,
        'actualPhase': trainingsProgramm.actualPhase,
        'actualPlan': trainingsProgramm.actualPlan,
        'plans': addPlanAsMap(trainingsProgramm.plans),
        // 'plans': trainingsProgramm.plans.map((plan) => mapPlan(plan)),
      };

      usersCollection.doc(uid).collection('Goal').doc('TrainingsProgramm').set(addTraningsProgramm);
    }
  }

  Map<String, Object> addPlanAsMap(List<Plans> allPlans) {
    Map<String, Object> plansAsMap = {};
    for (var plan in allPlans) {
      plansAsMap[plan.name] = mapPlan(plan);
    }
    return plansAsMap;
  }

  Map<String, Object> mapPlan(Plans planObject) {
    return {
      'name': planObject.name,
      'time': planObject.time,
      'exercises': planObject.exercises
          .map((exercise) => {
                'name': exercise.name,
                'info': exercise.info,
                'media': exercise.media,
                'pk': exercise.pk,
                'repetitionsScale': exercise.repetitionsScale,
                'setDoTimeScale': exercise.setDoTimeScale,
                'setRestTimeScale': exercise.setRestTimeScale,
                'weigthScale': exercise.weigthScale,
                'exerciseRestTime': exercise.exerciseRestTime,
                'rpeScale': exercise.rpeScale,
                'sets': exercise.sets
                    .map((sets) => {
                          'repetitions': sets.repetitions,
                          'setTime': sets.setTime,
                          'weight': sets.weight,
                          'setRestTime': sets.setRestTime,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  // -----------------------------------------END - ADD My Goal--------------------------------

  // -----------------------------------------START - Update My Goal--------------------------------

  Future updateTrainingsProgramm(Plans updatePlan) {
    
    return usersCollection.doc(uid).collection('Goal').doc('TrainingsProgramm').update({
      'plans.${updatePlan.name}': mapPlan(updatePlan),
      // 'plans': FieldValue.arrayUnion([mapPlan(updatePlan)]),
    });
  }
  // -----------------------------------------END - Update My Goal--------------------------------

  // -----------------------------------------START - Get My Goal--------------------------------
  Stream<Goal> get getGoal {
    return usersCollection.doc(uid).collection('Goal').snapshots().map(_goalFromSnapshot);
  }

  // Get All Plans Data
  Goal _goalFromSnapshot(QuerySnapshot snapshot) {
    Map<String, String> goalNameAndInfo = {
      'name': 'ERROR Goal Name',
      'info': 'ERROR Goal Info',
    };

    usersCollection.doc(uid).snapshots().map((event) {
      goalNameAndInfo['name'] = event.get('userGoal.goalName');
      goalNameAndInfo['info'] = event.get('userGoal.goalInfo');
    });
    return Goal(
        name: goalNameAndInfo['name'] ?? 'ERROR Goal Name',
        info: goalNameAndInfo['info'] ?? 'ERROR Goal Info',
        trainingsProgramms: snapshot.docs
            .map((doc) => TrainingsProgramms(
                  name: doc.get('name'),
                  info: doc.get('info'),
                  fitnesstype: doc.get('fitnesstype'),
                  difficultyLevel: doc.get('difficultyLevel'),
                  durationWeeks: doc.get('durationWeeks'),
                  actualPhase: doc.get('actualPhase'),
                  actualPlan: doc.get('actualPlan'),
                  plans: _fillPlans(doc.get("plans")),
                ))
            .toList());
  }

  // // Convert all Plans
  // List<Plans> _fillPlans(List plans) {
  //   return plans
  //       .map((plan) => Plans(
  //             name: plan['name'],
  //             planIndex: plan['planIndex'],
  //             time: plan['time'],
  //             exercises: _fillExercises(plan['exercises']),
  //           ))
  //       .toList();
  // }

    // Convert all Plans
  List<Plans> _fillPlans(Map plans) {
    return plans.entries
        .map((plan) => Plans(
              name: plan.value['name'],
              time: plan.value['time'],
              exercises: _fillExercises(plan.value['exercises']),
            ))
        .toList();
  }

  // Convert all Exercises
  List<Exercises> _fillExercises(List exercises) {
    return exercises
        .map((exercise) => Exercises(
            name: exercise['name'],
            info: exercise['info'],
            media: exercise['media'],
            pk: exercise['pk'],
            repetitionsScale: _fillStringIntMaps(exercise['repetitionsScale']),
            setDoTimeScale: _fillStringIntMaps(exercise['setDoTimeScale']),
            setRestTimeScale: _fillStringIntMaps(exercise['setRestTimeScale']),
            weigthScale: _fillStringDoubleMaps(exercise['weigthScale']),
            exerciseRestTime: _fillStringIntMaps(exercise['exerciseRestTime']),
            rpeScale: _fillStringIntMaps(exercise['rpeScale']),
            sets: _fillSets(exercise['sets'])))
        .toList();
  }

  // Convert all Sets
  List<Sets> _fillSets(List sets) {
    return sets.map((set) {
      return Sets(
        repetitions: _fillStringIntMaps(set['repetitions']),
        setTime: _fillStringIntMaps(set['setTime']),
        weight: _fillStringDoubleMaps(set['weight']),
        setRestTime: _fillStringIntMaps(set['setRestTime']),
      );
    }).toList();
  }

  // Convert Map<dynamic, dynamic> to Map<String, int>
  Map<String, int> _fillStringIntMaps(Map<dynamic, dynamic> map) {
    Map<String, int> returnMap = {};

    map.forEach((key, value) {
      returnMap[key] = value;
    });

    return returnMap;
  }

  // Convert Map<dynamic, dynamic> to Map<String, double>
  Map<String, double> _fillStringDoubleMaps(Map<dynamic, dynamic> map) {
    Map<String, double> returnMap = {};

    map.forEach((key, value) {
      returnMap[key] = value;
    });

    return returnMap;
  }

  // -----------------------------------------END - Get My Goal--------------------------------

}
