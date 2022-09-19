
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:higym/app_utils/styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 50,
          height: 50,
          child: SpinKitChasingDots(
            color: Styles.primaryColor,
            size: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Loading...',
                speed: const Duration(milliseconds: 500),
                textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Styles.hiGymText),
              )
            ],
            isRepeatingAnimation: true,
            totalRepeatCount: 10,
          ),
        ),
      ],
    );
  }
}
