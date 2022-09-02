import 'package:flutter/material.dart';

class Styles {
  ///Color Styles
  static const Color primaryColor = Color(0xFFffcd16);
  // static const Color primaryColor = Color(0xFF49AD33);
  static const Color secondaryColor = Color(0xFFF7A70B);

  static const Color tertiaryColor = Color.fromRGBO(26, 31, 36, 1);
  static const Color grey = Colors.grey;

  static const Color white = Color(0xFFFFFFFF);
  static const Color gymyGrey = Color(0xFF555453);
  static const Color tertiaryDark = Color(0xFF131619);
  static const Color tertiaryTransparent = Color(0x801A1F24);

    static const Color pastelBlue = Color(0xFF7DB3BC);
    static const Color pastelGreen = Color(0xFF92AF5B);
    static const Color pastelYellow = Color(0xFFDEB55C);
    static const Color pastelRed = Color(0xFFC15959);

  static const Color backgroundPause = Color(0xFF7DB3BC);
  static const Color backgroundActivity = Color(0xFF8EA569);
  static const Color backgroundYellow = Color(0xFFDEB55C);

  static const Color progressCircleBackground = Color(0xFFe7e7e7);
  static const Color progressCircleBig = Color(0xFFf68b00);
  static const Color progressCircleSmall = Color(0xFF49a9e5);

  // static const Color backgroundActivityTrans = Color(0x508EA569);
  // static const Color backgroundActivity = Color(0xFF52751B);

  ///Text Styles
  static TextStyle get title => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.normal,
        fontSize: 36,
      );
  static TextStyle get exercisingTitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 24,
      );
  static TextStyle get exercisingSubTitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      );
  static TextStyle get trainingsplanTitle => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  static TextStyle get trainingsplanSubTitle => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  static TextStyle get trainingsplanIconTitle => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      );
  static TextStyle get trainingsplanCardExeTitle => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  static TextStyle get trainingsplanCardExeSubTitle => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  static TextStyle get trainingsplanCardExeinfo => TextStyle(
        color: Colors.grey[400],
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  static TextStyle get rpeScaleTitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  static TextStyle get homeCardName => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w300,
        fontSize: 28,
      );
  static TextStyle get homeCardText => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  static TextStyle get homeProgressText => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  static TextStyle get navBarMenuText => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  static TextStyle get profileItemText => const TextStyle(
        color: gymyGrey,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get goalsCardTitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.w500,
        fontSize: 30,
      );

  //   static TextStyle get subtitle1 => GoogleFonts.getFont(
  //   'Montserrat',
  //   color: white,
  //   fontWeight: FontWeight.w500,
  //   fontSize: 18,
  // );

  ///Icon Styles
  static Icon get closeIcon => const Icon(
        Icons.close_rounded,
        color: white,
      );
  static Icon get skipIcon => const Icon(
        Icons.fast_forward_rounded,
        color: white,
      );
  static Icon get emergencyIcon => Icon(
        Icons.emergency_rounded,
        color: Colors.red[400],
        size: 32.0,
      );
  static Icon get fitnessIcon => const Icon(
        Icons.fitness_center_rounded,
        color: gymyGrey,
        size: 28.0,
      );
  static Icon get bodyIcon => const Icon(
        Icons.boy_rounded,
        color: gymyGrey,
        size: 30.0,
      );
  static Icon get timerIcon => const Icon(
        Icons.timer_rounded,
        color: gymyGrey,
        size: 28.0,
      );

  static Icon getIcons(String myIcon) {
    Icon returnIcon = fitnessIcon;
    switch (myIcon) {
      case 'fitnessIcon':
        returnIcon = fitnessIcon;
        break;
      case 'bodyIcon':
        returnIcon = bodyIcon;
        break;
      case 'timerIcon':
        returnIcon = timerIcon;
        break;
    }
    return returnIcon;
  }

  //       double width = MediaQuery.of(context).size.width;
  // double height = MediaQuery.of(context).size.height;
}
