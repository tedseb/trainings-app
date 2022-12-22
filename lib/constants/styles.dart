import 'package:flutter/material.dart';

class Styles {
  /// --- Color Sheet ---

  static const Color primaryColor = Color(0xFFffcd16);

  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteTransparent = Colors.white70;
  static Color veryLightGrey = Colors.grey.shade200;
  static Color lightGrey = Colors.grey.shade400;
  static const Color grey = Color.fromARGB(255, 158, 158, 158);
  static Color midleDarkGrey = Colors.grey.shade700;
  static const Color darkGrey = Color(0xFF333333);
  static const Color blackTransparent = Colors.black87;
  static const Color black = Color(0xFF000000);

  static const Color error = Colors.red;

  static const Color orange = Color(0xFFf68b00);
  static const Color blue = Color(0xFF49a9e5);
  static const Color progressBackground = Color(0xFFe7e7e7);

  static const Color pastelBlue = Color(0xFF7DB3BC);
  static const Color pastelGreen = Color(0xFF92AF5B);
  static const Color pastelYellow = Color(0xFFDEB55C);
  static const Color pastelRed = Color(0xFFC15959);
  static const Color exercisingWhite = Color(0xFFFFFFFF);


  //   static const Color white = Color(0xFF333333);
  // static const Color whiteTransparent = Colors.black87;
  // static Color lightGrey = Colors.grey.shade400;
  // static const Color grey = Color.fromARGB(255, 158, 158, 158);
  // static Color midleDarkGrey = Colors.grey.shade700;
  // static const Color darkGrey = Color(0xFFCCCCCC);
  // static const Color blackTransparent = Colors.black87;
  // static const Color black = Color(0xFF000000);

  // static const Color progressBackground = Color(0xFF292929);

  /// --- Color Sheet ---

  /// --- Text Sheet ---

  static TextStyle get bigNumbers => const TextStyle(
        color: exercisingWhite,
        fontWeight: FontWeight.w900,
        fontSize: 60,
      );
  static TextStyle get headLinesBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 35,
      );
  static TextStyle get headLinesLight => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 35,
      );
  static TextStyle get subLinesBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 21.5,
      );
  static TextStyle get subLinesLight => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 21.5,
      );
  static TextStyle get normalLinesBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  static TextStyle get normalLinesLight => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  static TextStyle get smallLinesBold => const TextStyle(
        color: grey,
        fontWeight: FontWeight.w600,
        fontSize: 13.5,
      );
  static TextStyle get smallLinesLight => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w400,
        fontSize: 13.5,
      );
  static TextStyle get tinyLinesBold => const TextStyle(
        color: darkGrey,
        fontWeight: FontWeight.w700,
        fontSize: 9,
      );

  /// --- Text Sheet ---
  



  /// --- Fix Sizes --- ///
  static const double iconSize = 24.0;
  
  
  /// --- Fix Sizes --- ///
   

}
