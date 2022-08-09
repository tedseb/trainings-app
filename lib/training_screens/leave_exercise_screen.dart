import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class LeaveExerciseScreen extends StatelessWidget {
  const LeaveExerciseScreen({
    Key? key,
    required this.leaveTraining,
    this.nextExercise,
    required this.endTraining,
  }) : super(key: key);

  final bool leaveTraining;
  final Function? nextExercise;
  final Function endTraining;



  @override
  Widget build(BuildContext context) {
    String leaveText = '';

    if (leaveTraining) {
      leaveText = 'Are you sure to leave the training?';
    } else {
      leaveText = 'Are you sure to skip?';
    }

    void yesPress() {
      if (leaveTraining) {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pop(context);
        endTraining();
        // Navigator.popUntil(context, (route) {
        //   return pagepop++ == 2;
        // });
      } else {
        nextExercise!();
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              leaveText,
              style: const TextStyle(
                color: Styles.gymyGrey,
                fontWeight: FontWeight.normal,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => yesPress(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide.none,
                    ),
                    primary: Colors.transparent,
                    onPrimary: Styles.white,
                    elevation: 0.0,
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Styles.gymyGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 36,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
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
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Styles.gymyGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 36,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
