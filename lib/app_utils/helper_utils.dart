import 'package:flutter/material.dart';

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
  double maxSize = screensize / 2.16;
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

String truncatePlanName(String myString, TextStyle myTextStyle, double screensize) {
  double maxSize = screensize / 1.55;
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

String truncateWithEllipsis(String myString) {
  int cutoff = 13;
  return (myString.length <= cutoff) ? myString : '${myString.substring(0, cutoff)}...';
}

String truncateTrainingsProgrammExeCardName(String myString, TextStyle myTextStyle, double screensize) {
  double maxSize = (screensize - 190) / 1.28;
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

String listToString(List<String> handle) {
  String returnString = (handle.toString().replaceAll(']', ',')).replaceAll('[', '');

  returnString = returnString.substring(0, returnString.length - 1);

  return returnString;
}
