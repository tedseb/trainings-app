import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:higym/models/plans.dart';
import 'dart:developer' as developer;

class DatabaseService {
  final String? uid;
  final String? planID;
  final String? oldPlanName;
  final Plans? selectedPlan;
  final String? planNameOrDate;
  final String? planProvider;
  final String? collectionPlansOrDonePlans; // .collection("UserExercisePlans")
  final String? rpeScalePlanName;

  DatabaseService(
      {this.uid,
      this.planID,
      this.oldPlanName,
      this.selectedPlan,
      this.planNameOrDate,
      this.planProvider,
      this.collectionPlansOrDonePlans,
      this.rpeScalePlanName});

  // collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  final CollectionReference gymCollections = FirebaseFirestore.instance.collection('Gyms');
  final CollectionReference exerciseCollection = FirebaseFirestore.instance.collection('TrainerAI_Exercises');

  // Update User
  Future updateUserData(String userName, int userWeight, String studioName) async {
    return await usersCollection.doc(uid).set({
      'userName': userName,
      'userWeight': userWeight,
      'studioName': studioName,
    });
  }

  // Delete Plan
  Future deleteUserPlan() async {
    return await usersCollection.doc(uid).collection(collectionPlansOrDonePlans!).doc(oldPlanName).delete();
  }

  // Add Plan
  Future addUserPlan() async {
    Map<String, dynamic> tempPlanMap = {};

    tempPlanMap['kcal'] = selectedPlan!.kcal ?? 0;
    tempPlanMap['name'] = selectedPlan!.name ?? 'database.ErrorPlanName';
    tempPlanMap['score'] = selectedPlan!.score ?? 0;
    tempPlanMap['success'] = selectedPlan!.success ?? 0;
    tempPlanMap['time'] = selectedPlan!.time ?? 0;

    Map<String, dynamic> tempExercisesMap = {};

    int counter = 0;
    for (var element in selectedPlan!.exercises!) {
      Map<String, dynamic> tempOneExerciseMap = {};
      counter++;
      tempOneExerciseMap['name'] = element.name ?? 'database.ErrorExerciseName';
      tempOneExerciseMap['img'] = element.img ?? 'default';
      tempOneExerciseMap['video'] = element.video ?? 'default';
      tempOneExerciseMap['info'] = element.info ?? 'default';
      tempOneExerciseMap['muscleGroup'] = element.muscleGroup ?? 'Muscle GroupssS';
      tempOneExerciseMap['pk'] = element.pk ?? 00;
      tempOneExerciseMap['exePauseTime'] = element.exePauseTime ?? 90;
      tempOneExerciseMap['exePauseTimeDone'] = element.exePauseTimeDone ?? 0;
      tempOneExerciseMap['rpeScale'] = element.rpeScale ?? [];

      List<Map<String, dynamic>> tempSetsList = [];
      for (var setsElement in element.sets!) {
        Map<String, dynamic> tempSetsMap = {};

        tempSetsMap['repetitions'] = setsElement.repetitions ?? 0;
        tempSetsMap['time'] = setsElement.time ?? 0;
        tempSetsMap['weight'] = setsElement.weight ?? 0;
        tempSetsMap['pause'] = setsElement.pause ?? 45;
        tempSetsMap['pauseDone'] = setsElement.pauseDone ?? 0;
        tempSetsMap['success'] = setsElement.success ?? 0;
        tempSetsList.add(tempSetsMap);
      }

      tempOneExerciseMap['sets'] = tempSetsList;
      tempExercisesMap['$counter-${element.name}'] = tempOneExerciseMap;
    }

    tempPlanMap['exercises'] = tempExercisesMap;
    return await usersCollection.doc(uid).collection(collectionPlansOrDonePlans!).doc(planNameOrDate).set(tempPlanMap);
  }

  // Update Plan
  updateUserPlan() {
    deleteUserPlan();
    addUserPlan().whenComplete(() => developer.log('Database could save Plan on firebase'));
    developer.log('Save started');
  }

  addToEndedPlans() {
    addUserPlan().whenComplete(() => developer.log('Database could save ENDEDPlan on firebase'));
  }

  // -----------------------------------------START - Get All Plans--------------------------------
  Stream<List<Plans>> get allPlans {
    return usersCollection.doc(uid).collection(collectionPlansOrDonePlans!).snapshots().map(_planListFromSnapshot);
  }

  // Fill All Plans Data
  List<Plans> _planListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Plans(
          name: doc.get('name') ?? 'Error Plan Name',
          time: doc.get('time') ?? 0,
          kcal: doc.get('kcal') ?? 0,
          score: doc.get('score') ?? 0,
          success: doc.get('success') ?? 0,
          exercises: _selectedPlanExercises(doc.get('exercises')));
    }).toList();
  }

  // Fill All Exercises
  List<Exercises> _selectedPlanExercises(Map? myExercises) {
    if (myExercises != null) {
      var filledTempList = List<Exercises>.filled(myExercises.length, Exercises(), growable: true);

      myExercises.forEach((k, v) {
        Exercises comingExercise = Exercises(
          name: v['name'] ?? 'Error Exercise Name',
          img: v['image'] ?? 'default',
          video: v['video'] ?? 'default',
          info: v['info'] ?? 'default',
          muscleGroup: v['muscleGroup'] ?? 'Muscle GroupssS',
          pk: v['pk'] ?? 00,
          exePauseTime: v['pause'] ?? 90,
          exePauseTimeDone: v['pauseDone'] ?? 0,
          rpeScale: _rpeScaleList(v['rpeScale']),
          exerciseFinished: false,
          exercisePauseFinished: false,
          sets: _selectedExerciseSets(v['sets']) ?? [],
        );

        filledTempList[int.parse(k.split('-')[0]) - 1] = comingExercise;
      });

      return filledTempList;
    } else {
      return [];
    }
  }

  List<int> _rpeScaleList(List? rpeScale) {
    List<int> rpeScaleReturn = [];

    if (rpeScale != null) {
      for (var element in rpeScale) {
        rpeScaleReturn.add(element);
      }
    }
    return rpeScaleReturn;
  }

  // Fill all Sets
  List<Sets>? _selectedExerciseSets(List? mySets) {
    if (mySets != null) {
      return mySets.map((setItem) {
        return Sets(
          repetitions: setItem['repetitions'] ?? 0,
          weight: setItem['weight'].toDouble() ?? 0,
          time: setItem['time'] ?? 0,
          pause: setItem['pause'] ?? 45,
          repetitionsDone: setItem['repetitionsDone'] ?? 0,
          weightDone: setItem['weightDone'] != null ? setItem['weightDone'].toDouble() : 0,
          timeDone: setItem['timeDone'] ?? 0,
          pauseDone: setItem['pauseDone'] ?? 0,
          success: setItem['success'] ?? 0,
          setFinished: false,
          setPauseFinished: false,
        );
      }).toList();
    } else {
      return [];
    }
  }

  // -----------------------------------------END - Get All Plans----------------------------------

  // -----------------------------------------START - Get Done Plans-----------------------------------------
  Stream<List<Map<DateTime, List<Plans>>>> get donePlans {
    return usersCollection.doc(uid).collection(collectionPlansOrDonePlans!).snapshots().map(_datedPlanListFromSnapshot);
  }

  List<Map<DateTime, List<Plans>>> _datedPlanListFromSnapshot(QuerySnapshot snapshot) {
    Map<DateTime, List<Plans>> tempMapDonePlans = {};

    for (var doc in snapshot.docs) {
      DateTime tempDate = DateTime.parse(doc.id.split('_')[0]);
      String tempTime = doc.id.split('_')[1];

      if (tempMapDonePlans.containsKey(tempDate)) {
        tempMapDonePlans[tempDate]!.add(Plans(
            name: doc.get('name') ?? 'Error Plan Name',
            time: doc.get('time') ?? 0,
            kcal: doc.get('kcal') ?? 0,
            score: doc.get('score') ?? 0,
            success: doc.get('success') ?? 0,
            planDoneTime: tempTime,
            exercises: _selectedPlanExercises(doc.get('exercises'))));
      } else {
        tempMapDonePlans[tempDate] = [
          Plans(
              name: doc.get('name') ?? 'Error Plan Name',
              time: doc.get('time') ?? 0,
              kcal: doc.get('kcal') ?? 0,
              score: doc.get('score') ?? 0,
              success: doc.get('success') ?? 0,
              planDoneTime: tempTime,
              exercises: _selectedPlanExercises(doc.get('exercises')))
        ];
      }
    }

    return [tempMapDonePlans];
  }

  // -----------------------------------------END - Get Done Plans-------------------------------------------

  // -----------------------------------------START - Get Done Plans NEWWWWWWWWWWWWW-----------------------------------------
  Stream<Map<DateTime, Plans>> get donePlansNew {
    return usersCollection.doc(uid).collection(collectionPlansOrDonePlans!).snapshots().map(_datedPlanListFromSnapshotNew);
  }

  Map<DateTime, Plans> _datedPlanListFromSnapshotNew(QuerySnapshot snapshot) {
    Map<DateTime, Plans> tempMapDonePlans = {};

    for (var doc in snapshot.docs) {
      developer.log(DateTime.parse(doc.id).toString());
      tempMapDonePlans[DateTime.parse(doc.id)] = Plans(
          name: doc.get('name') ?? 'Error Plan Name',
          time: doc.get('time') ?? 0,
          kcal: doc.get('kcal') ?? 0,
          score: doc.get('score') ?? 0,
          success: doc.get('success') ?? 0,
          exercises: _selectedPlanExercises(doc.get('exercises')));
    }

    return tempMapDonePlans;
  }

  // -----------------------------------------END - Get Done Plans NEWWWWWWWWWWWWW-------------------------------------------

  // -----------------------------------------START - Get All Exercises--------------------------------------------------
  Stream<List<Exercises>> get exerciseDatabase {
    return exerciseCollection.snapshots().map(_allExercises);
  }

  List<Exercises> _allExercises(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Exercises(
        name: doc['fields']['name'].toString(),
        exePauseTime: 90,
        exePauseTimeDone: 90,
        exerciseFinished: false,
        exercisePauseFinished: false,
        sets: [
          Sets(
            repetitions: 0,
            time: 0,
            weight: 0,
            pause: 45,
            repetitionsDone: 0,
            timeDone: 0,
            weightDone: 0,
            pauseDone: 45,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
        muscleGroup: 'Muscle GroupssS',
        pk: doc.get('pk') ?? 00,
      );
    }).toList();
  }

  // -----------------------------------------END - Get All Exercises----------------------------------------------------

}
