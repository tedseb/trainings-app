import 'package:flutter/material.dart';
import 'package:higym/gymion_icons_1_0_icons.dart';

class Styles {
  /// --- Color Sheet ---

  static const Color primaryColor = Color(0xFFffcd16);

  static const Color white = Color(0xFFFFFFFF);
  static Color lightGrey = Colors.grey.shade400;
  static const Color grey = Colors.grey;
  static Color midleDarkGrey = Colors.grey.shade700;
  static const Color darkGrey = Color(0xFF333333);

  static const Color error = Colors.red;

  static const Color orange = Color(0xFFf68b00);
  static const Color blue = Color(0xFF49a9e5);
  static const Color progressCircleBackground = Color(0xFFe7e7e7);

  static const Color pastelBlue = Color(0xFF7DB3BC);
  static const Color pastelGreen = Color(0xFF92AF5B);
  static const Color pastelYellow = Color(0xFFDEB55C);
  static const Color pastelRed = Color(0xFFC15959);
  static const Color exercisingWhite = Color(0xFFFFFFFF);


  /// --- Color Sheet ---


  /// --- Text Sheet ---

  static TextStyle get numbers => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 35.01,
      );

  static TextStyle get headline => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 35,
      );

  static TextStyle get headlineLigth => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 35,
      );
  static TextStyle get subLine => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  static TextStyle get subLineLigth => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 22.0,
      );
  static TextStyle get normalText => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      );
  static TextStyle get normalTextBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      );
  static TextStyle get fliessTextBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  static TextStyle get smalText => const TextStyle(
        color: grey,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );

  /// --- Text Sheet ---


 /// --- Icon Sheet ---
  static Icon get closeIcon => const Icon(
        Icons.close_rounded,
        color: white,
      );
  static Icon get skipIcon => const Icon(
        Icons.fast_forward_rounded,
        color: white,
      );
  static Icon get fitnessIcon => const Icon(
        Icons.fitness_center_rounded,
        color: darkGrey,
        size: 30.0,
      );
  static Icon get bodyIcon => const Icon(
        Icons.boy_rounded,
        color: darkGrey,
        size: 30.0,
      );
  static Icon get levelIcon => const Icon(
        Icons.signal_cellular_alt_2_bar,
        color: darkGrey,
        size: 30.0,
      );
  static Icon get timerIcon => const Icon(
        GymionIcons_1_0.zeit,
        color: darkGrey,
        size: 30.0,
      );

 /// --- Icon Sheet ---

}
