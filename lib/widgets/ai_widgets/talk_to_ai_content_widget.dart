import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class TalkToAIContentWidget extends StatelessWidget {
  const TalkToAIContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pain Report', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Personal Data', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Goal', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trainings Frequenz', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Set Reminder', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gym Equipment', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
      ],
    );
  }
}