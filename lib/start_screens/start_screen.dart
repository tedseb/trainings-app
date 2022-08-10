import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/services/database.dart';
import 'package:higym/training_screens/exercise_start.dart';
import 'package:higym/training_screens/exercising_screen.dart';

import 'dart:developer' as dev;

import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final AuthService _auth = AuthService();

  Plans selectedPlan = Plans(
    name: 'ShowRoomTestPlan',
    exercises: [
      Exercises(
        name: 'Military Press',
        img: '',
        video: 'military_press',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 229,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Squats',
        img: '',
        video: 'squats',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 111,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Deadlifts',
        img: '',
        video: 'deadlifts',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 105,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Rudern Stehend',
        img: '',
        video: 'rudern_stehend',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 106,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Bankdrücken',
        img: '',
        video: 'bankdruecken',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 102,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
    ],
    kcal: 0,
    time: 0,
    higymAutomated: true,
  );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    List<Plans> myPlans = Provider.of<List<Plans>>(context);

    return Scaffold(
      backgroundColor: Styles.white,
      // backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      dev.log('Exercising Screen');
                      // DatabaseService(
                      //         oldPlanName: selectedPlan.name,
                      //         uid: user?.uid,
                      //         planNameOrDate: selectedPlan.name,
                      //         collectionPlansOrDonePlans: 'UserExercisePlans',
                      //         selectedPlan: selectedPlan)
                      //     .updateUserPlan();
                      selectedPlan = myPlans.firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExercisingScreen(selectedPlan: selectedPlan.plansToJson()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide.none,
                      ),
                      primary: Colors.transparent,
                      onPrimary: Styles.white,
                      elevation: 0.0,
                    ),
                    child: Text(
                      'Start Training',
                      style: Styles.title.copyWith(color: Styles.gymyGrey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      dev.log('Open Workout Screen');

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseStart(selectedPlan: selectedPlan.plansToJson()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide.none,
                      ),
                      primary: Colors.transparent,
                      onPrimary: Styles.white,
                      elevation: 0.0,
                    ),
                    child: Text(
                      'Workout',
                      style: Styles.title.copyWith(color: Styles.gymyGrey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      dev.log('Open Logout Screen');

                      await _auth.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide.none,
                      ),
                      primary: Colors.transparent,
                      onPrimary: Styles.white,
                      elevation: 0.0,
                    ),
                    child: Text(
                      'Logout',
                      style: Styles.title.copyWith(color: Styles.gymyGrey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
