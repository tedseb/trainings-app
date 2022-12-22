import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

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

  final Color modeColor = Styles.pastelYellow;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: modeColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),

          /// RPE Scale Question and Answer
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// RPE Headline
              Text(
                'How Hard was your Exercise?',
                style: Styles.headLinesLight.copyWith(color: Styles.exercisingWhite),
                textAlign: TextAlign.center,
              ),

              /// Easy Button
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(1, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.exercisingWhite,
                  onPrimary: Styles.exercisingWhite,
                  elevation: 0.0,
                ),
                child: Text(
                  'easy',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),

              /// Okay Button
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(2, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.exercisingWhite,
                  onPrimary: Styles.exercisingWhite,
                  elevation: 0.0,
                ),
                child: Text(
                  'okay',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),

              /// Hard Button
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(3, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.exercisingWhite,
                  onPrimary: Styles.exercisingWhite,
                  elevation: 0.0,
                ),
                child: Text(
                  'hard',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
