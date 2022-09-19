import 'package:flutter/material.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/exercise_info_text_screen.dart';
import 'package:video_player/video_player.dart';

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
  String swipeText = 'Swipe Up';
  String swipeSupText = 'for more informations';
  IconData upDownarrow = Icons.keyboard_arrow_up_rounded;
  double gestureHeigth = 105.0;
  double initialHight = 0.0;

  bool swipeVisibility = true;

  // late AnimationController _controller;
  // Duration _duration = Duration(milliseconds: 500);
  // Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  Color modeColor = Styles.backgroundActivity;

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

    modeColor = widget.modeColor;
    // _controller = AnimationController(vsync: this, duration: _duration);

    super.initState();
  }

  @override
  void dispose() {
    _vpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double normalMinHeight = 1 / (size.height / 113);

    return Scaffold(
      backgroundColor: Styles.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(left: 16.0, top: 26.0, right: 16.0, bottom: 30.0),
              ),

              /// Exercise Informations
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40.0,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                            side: BorderSide.none,
                          ),
                          primary: modeColor,
                          onPrimary: Styles.white,
                          elevation: 0.0,
                          minimumSize: Size.zero,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '<',
                            style: TextStyle(
                              color: Styles.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 38,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedExercise.name,
                            style: Styles.exercisingTitle.copyWith(color: Styles.hiGymText),
                          ),
                          Text(
                            //  selectedExercise!.name!,
                            'Exercise',
                            style: Styles.exercisingTitle.copyWith(color: Styles.hiGymText),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox(height: 125)),
                  ],
                ),
              ),

              /// Progress Indicator
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
              SizedBox(
                height: gestureHeigth,
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
                        builder: (context) =>  ExerciseInfoTextScreen(exeInfo: selectedExercise.info),
                      ).then((_) => setState(() {
                            swipeVisibility = true;
                          }));
                    }
                  },
                  child: Visibility(
                    visible: swipeVisibility,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: Styles.hiGymText,
                          size: 32.0,
                        ),
                        Text(
                          swipeText,
                          style: const TextStyle(color: Styles.hiGymText, fontSize: 26.0, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          swipeSupText,
                          style: const TextStyle(color: Styles.hiGymText, fontSize: 22.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}