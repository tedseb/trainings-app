import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

import 'dart:developer' as dev;

class ShadowIconButtonWidget extends StatelessWidget {
  const ShadowIconButtonWidget({
    Key? key,
    required this.buttonIcon,
    required this.onPressFunction,
    required this.loggerText,
  }) : super(key: key);

  final IconData buttonIcon;
  final Function onPressFunction;
  final String loggerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Styles.veryLightGrey,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          ///bottom right
          BoxShadow(
            color: Styles.lightGrey,
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          dev.log('Open $loggerText Screen', name: 'Shadow_Icon_Button');
          onPressFunction();
          // Styles.lightGrey = Colors.red;
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          primary: Styles.veryLightGrey,
          onPrimary: Styles.darkGrey,
          // onPrimary: Styles.primaryColor,//To Make the Splashcolor of the Button
          elevation: 0.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            buttonIcon,
            color: Styles.darkGrey,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
