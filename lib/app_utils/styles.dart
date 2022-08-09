import 'package:flutter/material.dart';


class Styles {
  ///Color Styles
  static const Color primaryColor = Color(0xFF49AD33);
  static const Color secondaryColor = Color(0xFFF7A70B);
  static const Color tertiaryColor = Color(0xFF1A1F24);

  static const Color white = Color(0xFFFFFFFF);
  static const Color gymyGrey = Color(0xFF555453);
  static const Color tertiaryDark = Color(0xFF131619);
  static const Color tertiaryTransparent = Color(0x801A1F24);

  static const Color backgroundPause = Color(0xFF7DB3BC);
  static const Color backgroundActivity = Color(0xFF8EA569);

  static const Color backgroundActivityTrans = Color(0x508EA569);
  // static const Color backgroundActivity = Color(0xFF52751B);

  ///Text Styles
  static TextStyle get title => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 36,
      );
  static TextStyle get exercisingTitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 24,
      );
  static TextStyle get subtitle => const TextStyle(
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 20,
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
        size: 32.0,
      );
  static Icon get skipIcon => const Icon(
        Icons.fast_forward_rounded,
        color: white,
        size: 32.0,
      );
}
