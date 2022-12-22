import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

class BorderButtonWidget extends StatelessWidget {
  const BorderButtonWidget({
    required this.buttonFunction,
    required this.primaryColor,
    this.onPrimaryColor,
    required this.buttonIcon,
    Key? key,
  }) : super(key: key);

  final Function buttonFunction;
  final Color primaryColor;
  final Color? onPrimaryColor;
  final Icon buttonIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => buttonFunction(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          side: BorderSide.none,
        ),
        primary: primaryColor,
        onPrimary: onPrimaryColor ?? Styles.white,
        elevation: 0.0,
        minimumSize: Size.zero,
      ),
      child: Padding(
       padding: const EdgeInsets.all(8.0),
        child: buttonIcon,
      ),
    );
  }
}