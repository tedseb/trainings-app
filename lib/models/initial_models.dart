import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:intl/intl.dart';

class InitialModels {
  static Goal initialGoal = Goal(
    info: 'Goal Info is Loading...',
    name: 'Goal Name is Loading...',
    trainingsProgramms: [
      TrainingPrograms(
        name: 'Training Programm Name is Loading...',
        info: 'Training Programm Info is Loading...',
        fitnesstype: 'Fitness Type is Loading...',
        difficultyLevel: 1,
        durationWeeks: 24,
        actualPhase: 1,
        phases: [
          '2022-09-20',
          '2022-10-20',
          '2022-11-20',
          '2022-12-20',
        ],
        actualPlan: 'Plan name is Loading...',
        plans: [
          Plans(
            name: 'Plan name is Loading...',
            time: 0,
            exercises: [
              Exercises(
                name: 'Exercise Name is Loading...',
                subName: 'Exercise Sub Name is Loading...',
                info: 'Exercise Info is Loading...',
                media: 'noMedia',
                eID: 0,
                alternativeExercises: [0],
                handle: [],
                handleShort: [],
                station: [],
                stationShort: [],
                ratio: [],
                repetitionsScale: {
                  'rangeFrom': 6,
                  'rangeTo': 15,
                  'stepWidth': 1,
                  'actualToDo': 6,
                },
                setDoTimeScale: {
                  'rangeFrom': 0,
                  'rangeTo': 0,
                  'stepWidth': 0,
                  'actualToDo': 0,
                },
                setRestTimeScale: {
                  'rangeFrom': 180,
                  'rangeTo': 300,
                  'stepWidth': 30,
                  'actualToDo': 300,
                },
                weigthScale: {
                  'rangeFrom': 0.0,
                  'rangeTo': 9999.0,
                  'stepWidth': 2.5,
                  'actualToDo': 0.0,
                },
                warmupWeigth: 0,
                warmupInfo: '',
                sets: [
                  Sets(),
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );

  static  Map<String, dynamic> goalJson = initialGoal.goalToJson();
 static  Map<String, dynamic> plansJson = initialGoal.trainingsProgramms[0].plans[0].plansToJson();

  static AppUser initialAppUser = AppUser(
    uid: '',
    name: null,
    email: null,
    age: null,
    size: null,
    weigth: null,
    gender: null,
    goalName: null,
    dayFrequenz: null,
    minutesFrequenz: null,
    fitnessLevel: 0,
    additionalMusclegroup: 'General',
    reminder: null,
    fitnessMethod: null,
    activityLevel: 0,
    activityPoints: {DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()): 0.0},
  );
}
