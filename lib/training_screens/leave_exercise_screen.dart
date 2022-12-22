import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

class LeaveExerciseScreen extends StatelessWidget {
  const LeaveExerciseScreen({
    Key? key,
    required this.leaveTraining,
    this.nextExercise,
    this.exerciseOccupied,
    required this.endTraining,
  }) : super(key: key);

  final bool leaveTraining;
  final Function? nextExercise;
  final Function? exerciseOccupied;
  final Function endTraining;

  @override
  Widget build(BuildContext context) {
    String leaveText = '';

    if (leaveTraining) {
      leaveText = 'Are you sure to leave the training?';
    } else {
      leaveText = 'Are you sure to skip the exercise?';
    }

    void yesPress() {
      if (leaveTraining) {
        Navigator.pop(context);
        endTraining();
      } else {
        nextExercise!();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: Styles.whiteTransparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Headline Leave or Next
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(leaveText, style: Styles.headLinesLight, textAlign: TextAlign.center),
          ),

          /// Decision Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Yes Button
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Styles.darkGrey,
                    textStyle: Styles.headLinesLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                  onPressed: () => yesPress(),
                  child: const Text('Yes'),
                ),

                /// No Button
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Styles.darkGrey,
                    textStyle: Styles.headLinesBold,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                  onPressed: () async => Navigator.pop(context),
                  child: const Text('No'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
