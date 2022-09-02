import 'package:flutter/material.dart';

class ButtonOptions {
  const ButtonOptions({
    required this.textStyle,
    required this.color,
  });

  final TextStyle textStyle;
  final Color color;
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.options,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final ButtonOptions options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.0,
      height: 30,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            // side: options.borderSide ?? BorderSide.none,
          ),
          primary: options.color,
          onPrimary: options.textStyle.color,
          elevation: 0.0,
        ),
        child: Text(text, style: options.textStyle,),
      ),
    );
  }
}
