import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:higym/constants/icon_constants.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class LoginRegisterAlternatives extends StatelessWidget {
  const LoginRegisterAlternatives({
    Key? key,
    required this.platform,
    required this.registerSignIn,
    required this.onPressFunction,
  }) : super(key: key);

  final String platform;
  final String registerSignIn;
  final Function onPressFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/logo/${platform}_login.png', height: 32),
        const SizedBox(width: 16.0),
        Text('$registerSignIn $platform', style: Styles.normalLinesLight),
        const Spacer(),
        ShadowIconButtonWidget(buttonIcon: IconConstants.arrowRightIconData, onPressFunction: onPressFunction, loggerText: '${platform}_login'),
      ],
    );
  }
}
