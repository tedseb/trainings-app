import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:higym/constants/styles.dart';

class SpellingTextWidget extends StatefulWidget {
  const SpellingTextWidget({
    required this.spellingText,
    Key? key,
  }) : super(key: key);

  final String spellingText;


  @override
  State<SpellingTextWidget> createState() => _SpellingTextWidgetState();
}

class _SpellingTextWidgetState extends State<SpellingTextWidget> {
  TextStyle aiTextStyle = Styles.subLinesBold;




  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      /// heighth is needed, to prevent the page movement if text is double lined so I need to know possible place for my Text
      height: 200.0,
      // height: textSize(screenSize.width - 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              widget.spellingText,
              textAlign: TextAlign.center,
              speed: const Duration(milliseconds: 50),
              textStyle: aiTextStyle,
            )
          ],
          isRepeatingAnimation: false,
          displayFullTextOnTap: true,
        ),
      ),
    );
  }

  double textSize(double possibleWidth) {
    double containerHeight = 0;
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.spellingText, style: aiTextStyle),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    containerHeight = ((textPainter.size.width / possibleWidth).ceil() * textPainter.size.height) + 20.0;

    return containerHeight;
  }
}
