import 'package:flutter/material.dart';
import 'package:higym/constants/icon_constants.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/training_screens/exercise_info_text_screen.dart';
import 'package:higym/widgets/general_widgets/border_button_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:higym/app_utils/helper_utils.dart' as helper_utils;

import 'dart:developer' as dev;

class ExerciseInfoScreen extends StatefulWidget {
  const ExerciseInfoScreen({
    Key? key,
    required this.selectedExercise,
    required this.modeColor,
  }) : super(key: key);
  final Map<String, dynamic> selectedExercise;
  final Color modeColor;

  @override
  State<ExerciseInfoScreen> createState() => _ExerciseInfoScreenState();
}

class _ExerciseInfoScreenState extends State<ExerciseInfoScreen> {
  bool swipeVisibility = true;
  late Exercises selectedExercise;
  late VideoPlayerController _vpController;

  @override
  void initState() {
    selectedExercise = Exercises.exercisesFromJson(widget.selectedExercise);

    _vpController = VideoPlayerController.asset('assets/videos/${selectedExercise.media}.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) => _vpController.play());

    super.initState();
  }

  @override
  void dispose() {
    _vpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Spacer
          const SizedBox(height: 100),

          /// Exercise Informations
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Back Button
              BorderButtonWidget(
                buttonFunction: () => Navigator.pop(context, true),
                primaryColor: widget.modeColor,
                buttonIcon: IconConstants.arrowLeftIcon,
              ),

              /// Exercise Informations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(selectedExercise.name, style: Styles.subLinesBold),
                    Visibility(
                      visible: selectedExercise.station.isNotEmpty,
                      child: Text(helper_utils.listToString(selectedExercise.station), style: Styles.normalLinesLight),
                    ),
                    Visibility(
                      visible: selectedExercise.handle.isNotEmpty,
                      child: Text(helper_utils.listToString(selectedExercise.handle), style: Styles.normalLinesLight),
                    )
                  ],
                ),
              ),

              /// Spacer to give the same hight like exercising Screen
              const SizedBox(height: 125)
            ],
          ),

          /// Exercise Video
          Expanded(
            child: Center(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(Styles.white, BlendMode.modulate),
                child: AspectRatio(
                  aspectRatio: _vpController.value.aspectRatio,
                  child: VideoPlayer(_vpController),
                ),
              ),
            ),
          ),

          /// Swipe Up Widget
          SizedBox(
            height: 105.0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dy > sensitivity) {
                  // Down Swipe
                  dev.log('Down Swipe');
                  setState(() {});
                } else if (details.delta.dy < -sensitivity) {
                  // Up Swipe
                  dev.log('Up Swipe');
                  setState(() {
                    swipeVisibility = false;
                  });
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => ExerciseInfoTextScreen(exeInfo: selectedExercise.info),
                  ).then((_) => setState(() {
                        swipeVisibility = true;
                      }));
                }
              },
              child: Visibility(
                visible: swipeVisibility,
                child: Column(
                  children: [
                    IconConstants.arrowUpIcon,
                    Text('Swipe Up', style: Styles.subLinesLight),
                    Text('for more informations', style: Styles.smallLinesBold),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
