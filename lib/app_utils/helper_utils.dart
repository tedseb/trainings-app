import 'package:flutter/material.dart';


DateTime get getCurrentTimestamp => DateTime.now();

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

Future<dynamic> myBottomSheet(BuildContext context, Widget driveScreenUp) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: driveScreenUp,
        ),
      );
    },
  );
}

String truncateExerciseName(String myString, TextStyle myTextStyle, double screensize) {
  double maxSize = screensize/2.16;
  int stringCounter = 1;
  int myStringLength = myString.length;
  String newMyString = myString;

  TextPainter textPainter = TextPainter(
    text: TextSpan(text: myString, style: myTextStyle),
    textDirection: TextDirection.ltr,
    textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
  )..layout();

  while (textPainter.size.width > maxSize) {
    newMyString = '${myString.substring(0, myStringLength - stringCounter)}...';
    textPainter = TextPainter(
      text: TextSpan(text: newMyString, style: myTextStyle),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    stringCounter++;
  }

  return newMyString;
}

