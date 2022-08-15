import 'package:flutter/material.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/app_utils/styles.dart';
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

  Color modeColor = Styles.backgroundActivity;

  Exercises? selectedExercise;

  late VideoPlayerController _vpController;

  @override
  void initState() {
    selectedExercise = Exercises.exercisesFromJson(widget.selectedExercise);

    _vpController = VideoPlayerController.asset('assets/videos/${selectedExercise!.video}.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) => _vpController.play());

    modeColor = widget.modeColor;

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
                            selectedExercise!.name!,
                            style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
                          ),
                          Text(
                            //  selectedExercise!.name!,
                            'Exercise',
                            style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
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
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  int sensitivity = 8;
                  if (details.delta.dy > sensitivity) {
                    // Down Swipe
                    dev.log('Down Swipe');
                    setState(() {
                      swipeText = 'Swipe Up';
                    });
                  } else if (details.delta.dy < -sensitivity) {
                    // Up Swipe
                    dev.log('Up Swipe');
                    setState(() {
                      swipeText = 'Swipe Down';
                    });
                  }
                },
                child: SizedBox(
                  height: gestureHeigth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [
                     const  Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Styles.gymyGrey,
                        size: 32.0,
                      ),
                      Text(
                        swipeText,
                        style: const TextStyle(color: Styles.gymyGrey, fontSize: 26.0, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        swipeSupText,
                        style: const TextStyle(color: Styles.gymyGrey, fontSize: 22.0, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.0,
            minChildSize: 0.0,
            maxChildSize: 0.8,
            builder: ((context, scrollController) {
              // print(draggableScrollableController);

              return Container(
                color: Colors.white70,
                child: ListView(
                  padding: const EdgeInsets.only(left: 32.0, top: 8.0, right: 32.0, bottom: 32.0),
                  controller: scrollController,
                  children: [
                    // const Icon(
                    //   Icons.keyboard_arrow_up_rounded,
                    //   color: Styles.gymyGrey,
                    //   size: 32.0,
                    // ),
                    // Text(
                    //   'swipe down',
                    //   // draggableScrollableController.size >= (1 / (size.height / 113)) ? 'swipe up': 'swipe down',
                    //   style: const TextStyle(color: Styles.gymyGrey, fontSize: 26.0, fontWeight: FontWeight.w300),
                    //   textAlign: TextAlign.center,
                    // ),
                    // const Text(
                    //   'for more informations',
                    //   style: TextStyle(color: Styles.gymyGrey, fontSize: 22.0, fontWeight: FontWeight.w400),
                    //   textAlign: TextAlign.center,
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Text(
                      '1.) Be carefull!',
                      style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
                    ),
                    Text(
                      '2.) Train Hard!',
                      style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
                    ),
                    Text(
                      '3.) Train Good!',
                      style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
                    ),
                  ],
                ),
              );
            }),
          ),
          // Container(height: 105,
          // child: GestureDetector(

          // ),
          // )
        ],
      ),
    );
  }

  void setHeigth(){

  }

}
