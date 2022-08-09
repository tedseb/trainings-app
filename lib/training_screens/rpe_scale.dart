
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RPEScale extends StatelessWidget {
  const RPEScale({
    Key? key,
    required this.rpeScaleUpdater,
    required this.exeScore,
    
  }) : super(key: key);

  final Function rpeScaleUpdater;
  final int exeScore;

  final Color modeColor = Styles.backgroundActivity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundActivity,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'How Hard was your Exercise?',
                style: Styles.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
             shape: const CircleBorder(),
              padding: const EdgeInsets.all(32.0),
              primary: Styles.white,
              onPrimary: Styles.white,
              elevation: 0.0,
            ),
            child: Text(
              'easy',
              style: TextStyle(
                color: modeColor,
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
               shape: const CircleBorder(),
              padding: const EdgeInsets.all(32.0),
              primary: Styles.white,
              onPrimary: Styles.white,
              elevation: 0.0,
            ),
            child: Text(
              'okay',
              style: TextStyle(
                color: modeColor,
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
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(32.0),
              primary: Styles.white,
              onPrimary: Styles.white,
              elevation: 0.0,
            ),
            child: Text(
              'hard',
              style: TextStyle(
                color: modeColor,
                fontWeight: FontWeight.normal,
                fontSize: 36,
              ),
            ),
          ),
          Column(
            children: [
              const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Styles.white,
                size: 52.0,
              ),
              Text(
                'Score $exeScore%',
                style: Styles.title,
              )
            ],
          ),
        ],
      ),
    );
  }
}
