import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:higym/app_utils/styles.dart';

class BackgroundCirclePainter extends CustomPainter {
  double progressBigPercent;
  double progressBigReachPercent;
  double progressSmallPercet;
  double progressSmallReachPercet;
  BackgroundCirclePainter({
    required this.progressBigPercent,
    required this.progressSmallPercet,
    required this.progressBigReachPercent,
    required this.progressSmallReachPercet,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final screenMid = size.width / 2;

    double radiusBig = size.width * (1 / 3);
    double radiusSmall = size.width * (16 / 64);

    final paint = Paint()
      ..color = Styles.progressCircleBackground
      ..strokeWidth = 23
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      radiusBig,
      paint,
    );
    canvas.drawCircle(
      center,
      radiusSmall,
      paint,
    );

    final rectBig = Rect.fromCircle(center: center, radius: radiusBig);

    final paintBig = Paint()
      ..color = Styles.progressCircleBig
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arcBig = Path();
    arcBig.moveTo(screenMid, screenMid - radiusBig);
    arcBig.arcTo(rectBig, 3 * pi / 2, 4 * pi / 2 * progressBigPercent, false);

    final paintReachBig = Paint()
      ..color = Styles.grey
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arcReachBig = Path();
    arcReachBig.moveTo(screenMid, screenMid - radiusBig);
    arcReachBig.arcTo(rectBig, 3 * pi / 2, 4 * pi / 2 * progressBigReachPercent, false);

    canvas.drawPath(arcReachBig, paintReachBig);
    canvas.drawPath(arcBig, paintBig);

    final rectSmall = Rect.fromCircle(center: center, radius: radiusSmall);

    final paintSmall = Paint()
      ..color = Styles.progressCircleSmall
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arcSmall = Path();
    arcSmall.moveTo(screenMid, screenMid - radiusSmall);
    arcSmall.arcTo(rectSmall, 3 * pi / 2, 4 * pi / 2 * progressSmallPercet, false);

    final paintReachSmall = Paint()
      ..color = Styles.grey
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final arcReachSmall = Path();
    arcReachSmall.moveTo(screenMid, screenMid - radiusSmall);
    arcReachSmall.arcTo(rectSmall, 3 * pi / 2, 4 * pi / 2 * progressSmallReachPercet, false);

    canvas.drawPath(arcReachSmall, paintReachSmall);
    canvas.drawPath(arcSmall, paintSmall);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
