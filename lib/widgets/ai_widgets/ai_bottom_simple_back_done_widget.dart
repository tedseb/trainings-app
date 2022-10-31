import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

class AiBottomSimpleBackDoneWidget extends StatelessWidget {
  const AiBottomSimpleBackDoneWidget({
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onPressedLeft,
    required this.onPressedRight,
    Key? key,
  }) : super(key: key);

  final String leftButtonText;
  final String rightButtonText;

  final Function onPressedLeft;
  final Function onPressedRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShadowButtonWidget(
            buttonText: leftButtonText,
            buttonWidth: 120.0,
            onPressFunction: () => onPressedLeft(),
            loggerText: leftButtonText,
          ),
          ShadowButtonWidget(
            buttonText: rightButtonText,
            buttonWidth: 120.0,
            onPressFunction: () => onPressedRight(),
            loggerText: rightButtonText,
          ),
        ],
      ),
    );
  }
}
