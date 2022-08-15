
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RPEScale extends StatelessWidget {
  const RPEScale({
    Key? key,
    required this.rpeScaleUpdater,
    required this.exerciseIndex,
    required this.exeScore,
    
  }) : super(key: key);

  final Function rpeScaleUpdater;
  final int exerciseIndex;
  final int exeScore;

  final Color modeColor = Styles.backgroundYellow;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: modeColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'How Hard was your Exercise?',
                  style: Styles.rpeScaleTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                rpeScaleUpdater(1, exerciseIndex, false);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
               shape: const CircleBorder(),
                padding: const EdgeInsets.all(28.0),
                primary: Styles.white,
                onPrimary: Styles.white,
                elevation: 0.0,
              ),
              child: Text(
                'easy',
                style: TextStyle(
                  color: modeColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 28,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                rpeScaleUpdater(2, exerciseIndex, false);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                 shape: const CircleBorder(),
                padding: const EdgeInsets.all(28.0),
                primary: Styles.white,
                onPrimary: Styles.white,
                elevation: 0.0,
              ),
              child: Text(
                'okay',
                style: TextStyle(
                  color: modeColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 28,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                rpeScaleUpdater(3, exerciseIndex, false);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(28.0),
                primary: Styles.white,
                onPrimary: Styles.white,
                elevation: 0.0,
              ),
              child: Text(
                'hard',
                style: TextStyle(
                  color: modeColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 28,
                ),
              ),
            ),
            // Column(
            //   children: [
            //     const Icon(
            //       Icons.keyboard_arrow_up_rounded,
            //       color: Styles.white,
            //       size: 52.0,
            //     ),
            //     Text(
            //       'Score $exeScore%',
            //       style: Styles.title,
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
