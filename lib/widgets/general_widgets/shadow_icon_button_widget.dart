import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

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
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      onTap: () {
        dev.log('Open $loggerText Screen');
        onPressFunction();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            ///bottom right
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        child: Icon(
          buttonIcon,
          color: Styles.hiGymText,
        ),
      ),
    );
  }
}
