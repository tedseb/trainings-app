import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

import 'dart:developer' as dev;

class ShadowButtonWidget extends StatelessWidget {
  const ShadowButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonWidth,
    required this.onPressFunction,
    required this.loggerText,
    this.buttonTextColor = Styles.darkGrey,
  }) : super(key: key);

  final String buttonText;
  final double buttonWidth;
  final Function onPressFunction;
  final String loggerText;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: buttonWidth,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          ///bottom right
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          dev.log('Open $loggerText Screen');
          onPressFunction();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: options.borderSide ?? BorderSide.none,
          ),
          primary: Colors.grey[200],
          onPrimary: buttonTextColor,
          elevation: 0.0,
        ),
        child: Text(buttonText, style: Styles.normalText,),
      ),
    );
  }
}
