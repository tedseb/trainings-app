import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class ShadowButtonWidget extends StatelessWidget {
  const ShadowButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonWidth,
    required this.onPressFunction,
  }) : super(key: key);

  final String buttonText;
  final double buttonWidth;
  final Function onPressFunction;

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
        onPressed: () => onPressFunction(),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: options.borderSide ?? BorderSide.none,
          ),
          primary: Colors.grey[200],
          onPrimary: Styles.hiGymText,
          elevation: 0.0,
        ),
        child: Text(buttonText),
      ),
    );
  }
}
