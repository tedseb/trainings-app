import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/shadow_icon_button.dart';

import 'glas_box.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 0.0, right: 26.0, bottom: 32.0),
      child: SizedBox(
        height: 80.0,
        // color: Colors.grey[50],
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlasBox(exerciseImage: 'squats'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 4.0, right: 26.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 25.0,
                      child: Divider(height: 10.0, thickness: 4, color: Styles.primaryColor),
                    ),
                    const Expanded(child: SizedBox()),
                    Text('Straight', style: Styles.trainingsplanCardExeTitle),
                    Text('Squat', style: Styles.trainingsplanCardExeSubTitle),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text('2 Set | 20 kg | 15 sec', style: Styles.trainingsplanCardExeinfo),
                  ],
                ),
              ),
            ),
            ShadowIconButton(buttonInput: 'buttonInput', onPressFunction: () {}),
          ],
        ),
      ),
    );
  }
}
