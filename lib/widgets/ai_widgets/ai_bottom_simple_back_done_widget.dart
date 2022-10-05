import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

class AiBottomSimpleBackDoneWidget extends StatelessWidget {
  const AiBottomSimpleBackDoneWidget({
    required this.onPressedBack,
    required this.onPressedConfirm,
    Key? key,
  }) : super(key: key);

  final Function onPressedBack;
  final Function onPressedConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShadowButtonWidget(
            buttonText: 'back',
            buttonWidth: 120.0,
            onPressFunction: () => onPressedBack(),
            loggerText: 'Settings',
          ),
          ShadowButtonWidget(
            buttonText: 'confirm',
            buttonWidth: 120.0,
            onPressFunction: () => onPressedConfirm(),
            loggerText: 'Settings #confirm#',
          ),
        ],
      ),
    );
  }
}
