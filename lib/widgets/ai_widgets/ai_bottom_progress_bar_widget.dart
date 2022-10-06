import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class AiBottomProgressBarWidget extends StatefulWidget {
  const AiBottomProgressBarWidget({
    required this.pagesLength,
    required this.currentPage,
    required this.onPressedLeft,
    required this.onPressedRight,
    Key? key,
  }) : super(key: key);

  final int pagesLength;
  final int currentPage;
  final Function onPressedLeft;
  final Function onPressedRight;

  @override
  State<AiBottomProgressBarWidget> createState() => _AiBottomProgressBarWidgetState();
}

class _AiBottomProgressBarWidgetState extends State<AiBottomProgressBarWidget> {
  int screenCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShadowIconButtonWidget(
            buttonIcon: Icons.arrow_back_ios_new_rounded,
            onPressFunction: () => widget.onPressedLeft(),
            loggerText: 'back_onboarding',
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              value: screenCounter / (widget.pagesLength),
              color: Styles.primaryColor,
              backgroundColor: Styles.grey,
            ),
          ),
          const SizedBox(width: 16.0),
          ShadowIconButtonWidget(
            buttonIcon: Icons.arrow_forward_ios_rounded,
            onPressFunction: () => widget.onPressedRight(),
            loggerText: 'forward_onboarding',
          ),
        ],
      ),
    );
  }
}
