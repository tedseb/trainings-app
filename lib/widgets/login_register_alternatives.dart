import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';

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
        Text('$registerSignIn $platform', style: Styles.loginWithAlternativText),
        const Expanded(child: SizedBox()),
        ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: onPressFunction),
      ],
    );
  }
}
