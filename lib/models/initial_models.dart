import 'package:higym/models/goal.dart';

class InitialModels {
  static Goal initialGoal = Goal(
    info: 'Goal Info is Loading...',
    name: 'Goal Name is Loading...',
    trainingsProgramms: [
      TrainingsProgramms(
        name: 'Training Programm Name is Loading...',
        info: 'Training Programm Info is Loading...',
        fitnesstype: 'Fitness Type is Loading...',
        difficultyLevel: 1,
        durationWeeks: 24,
        actualPhase: 1,
        phases: {
          '1':'2022-09-20',
          '2':'2022-12-20',
          '3':'2023-03-20',
        },
        actualPlan: 'Plan name is Loading...',
        plans: [
          Plans(
            name: 'Plan name is Loading...',
            time: 0,
            exercises: [
              Exercises(
                name: 'Exercise Name is Loading...',
                info: 'Exercise Info is Loading...',
                media: 'noMedia',
                pk: 0,
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
}
