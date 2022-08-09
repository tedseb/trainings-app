import 'package:flutter/material.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:video_player/video_player.dart';


class ExerciseInfoScreen extends StatefulWidget {
  const ExerciseInfoScreen({
    Key? key,
    required this.selectedExercise,
  }) : super(key: key);
  final Map<String, dynamic> selectedExercise;

  @override
  State<ExerciseInfoScreen> createState() => _ExerciseInfoScreenState();
}

class _ExerciseInfoScreenState extends State<ExerciseInfoScreen> {
  Color modeColor = Styles.backgroundActivity;

  late Exercises exercise;

   late VideoPlayerController _vpController;

  @override
  void initState() {
 _vpController = VideoPlayerController.asset('assets/videos/kniebeugen.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) =>  _vpController.play());

    exercise = Exercises.exercisesFromJson(widget.selectedExercise);


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
          /// TopBar Close - Skip - Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.transparent,
                    size: 32.0,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
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
                    onPressed: () => Navigator.pop(context),
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
                    children: const [
                      Text(
                        'Leg Curls',
                        style: TextStyle(fontSize: 28, color: Styles.gymyGrey),
                      ),
                      Text(
                        'Leg Curls',
                        style: TextStyle(fontSize: 28, color: Styles.gymyGrey),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),

          /// Progress Indicator
          Expanded(
            child: Center(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(Styles.white, BlendMode.modulate),
                child: VideoPlayer(_vpController),
                // child: AspectRatio(
                //   aspectRatio: _vpController.value.aspectRatio,
                //   child: VideoPlayer(_vpController),
                // ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Column(
            children: const [
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Styles.gymyGrey,
                size: 52.0,
              ),
              Text(
                'swipe up',
                style: TextStyle(
                  color: Styles.gymyGrey,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w300
                ),
              ),
              Text(
                'for more informations',
                style: TextStyle(
                  color: Styles.gymyGrey,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}
