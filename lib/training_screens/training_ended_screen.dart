import 'package:flutter/material.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/services/database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class TrainingEndedScreen extends StatefulWidget {
  const TrainingEndedScreen({Key? key, required this.selectedPlan, required this.user}) : super(key: key);

  final Map<String, dynamic> selectedPlan;
  final AppUser user;

  @override
  State<TrainingEndedScreen> createState() => _TrainingEndedScreenState();
}

class _TrainingEndedScreenState extends State<TrainingEndedScreen> {
  Color modeColor = Styles.white;

  late Plans selectedPlan;

  @override
  void initState() {
    selectedPlan = Plans.plansFromJson(widget.selectedPlan);
    updatePlan(selectedPlan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('Mein Name ist ${widget.user.name} und meine Punktzahl: ${widget.user.activityPoints}');
    return Scaffold(
      backgroundColor: modeColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Text(
                  'Great Workout !',
                  style: TextStyle(
                    color: Styles.hiGymText,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'nicely done.',
                  style: TextStyle(color: Styles.hiGymText, fontSize: 32),
                ),
              ],
            ),

            /// Progress Indicator
            // Stack(
            //   children: [
            //     const Center(
            //       child: SizedBox(
            //         height: 200.0,
            //         width: 200.0,
            //         child: CircularProgressIndicator(
            //           value: 0.75,
            //           color: Styles.hiGymText,
            //           strokeWidth: 6.0,
            //         ),
            //       ),
            //     ),
            //     Center(
            //       child: SizedBox(
            //         height: 200.0,
            //         width: 200.0,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: const [
            //             Text(
            //               '100%',
            //               style: TextStyle(color: Styles.hiGymText, fontSize: 62.0),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     dev.log(user!.uid.toString());
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16.0),
            //       side: BorderSide.none,
            //     ),
            //     primary: Styles.hiGymText,
            //     onPrimary: Styles.white,
            //     elevation: 0.0,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Text(
            //       'Analyze Workout / test',
            //       style: TextStyle(
            //         color: modeColor,
            //         fontWeight: FontWeight.normal,
            //         fontSize: 22,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: double.infinity,
              height: 110,
              child: IconButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  iconSize: 72,
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    color: Styles.hiGymText,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void updatePlan(Plans plan) {
    Map<String, double> updatedActivityPoints = ActivityCalculator(activityPoints: widget.user.activityPoints!,trainingTime: plan.time).getActivityPoints();
    DatabaseService(uid: widget.user.uid).updateActivityPoints(activityPoints: updatedActivityPoints);
    DatabaseService(uid: widget.user.uid).updateTrainingsProgramm(plan);

    dev.log('Update Plan');
  }
}
