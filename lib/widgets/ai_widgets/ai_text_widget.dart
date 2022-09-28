import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';

class AiTextWidget extends StatefulWidget {
  const AiTextWidget({
    Key? key,
    required this.aiText,
  }) : super(key: key);

  final String aiText;

  @override
  State<AiTextWidget> createState() => _AiTextWidgetState();
}

class _AiTextWidgetState extends State<AiTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /// heighth is needed, to prevent the page movement if text is double lined
      height: 112,
      padding: const EdgeInsets.all(26.0),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            widget.aiText,
            textAlign: TextAlign.center,
            speed: const Duration(milliseconds: 100),
            textStyle: Styles.logInScreenWelcomeText
          )
        ],
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,

      ),
    );
  }
}
