import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';

import 'glas_box_widget.dart';

class ExerciseCardWidget extends StatelessWidget {
  const ExerciseCardWidget({
    Key? key,
    required this.selectedExercise,
    required this.showInfoScreen,
  }) : super(key: key);

  final Exercises? selectedExercise;
  final Function showInfoScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 0.0, right: 26.0, bottom: 32.0),
      child: SizedBox(
        height: 75.0,
        // color: Colors.grey[50],
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlasBoxWidget(exerciseImage: selectedExercise!.video.toString()),
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
                    Text(selectedExercise!.name!, style: Styles.trainingsplanCardExeTitle),
                    Text('Exercise', style: Styles.trainingsplanCardExeSubTitle),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                        '${selectedExercise!.sets!.length} Sets | ${selectedExercise!.sets![0].weight} kg | ${selectedExercise!.sets![0].repetitions ?? selectedExercise!.sets![0].time} sec',
                        style: Styles.trainingsplanCardExeinfo),
                  ],
                ),
              ),
            ),
            ShadowIconButtonWidget(buttonInput: 'buttonInput', onPressFunction: () => showInfoScreen(selectedExercise)),
          ],
        ),
      ),
    );
  }
}
