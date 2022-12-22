import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:higym/constants/styles.dart';

class PiePainter extends CustomPainter {
  double kraftPercent;
  double koordinationPercent;
  double cardioPercent;
  double beweglichkeitPercent;
  PiePainter({
    required this.kraftPercent,
    required this.koordinationPercent,
    required this.cardioPercent,
    required this.beweglichkeitPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    const center = Offset(0, 0);
    // final center = Offset(size.width / 2, size.height / 2);

    // final screenMid = size.width / 2;

    double durchmesser = size.width - 8;
    double durchmesserWhite = size.width;

    double kraftStart = -pi / 2;
    double kraftMove = (pi * 2) * kraftPercent;
    double koordinationStart = kraftStart + kraftMove;
    double koordinationMove = (pi * 2) * koordinationPercent;
    double cardioStart = koordinationStart + koordinationMove;
    double cardioMove = (pi * 2) * cardioPercent;
    double beweglichkeitStart = cardioStart + cardioMove;
    double beweglichkeitMove = (pi * 2) * beweglichkeitPercent;

    final paintWhite = Paint()
      ..color = Styles.white
      ..style = PaintingStyle.fill;
    final paintLine = Paint()
      ..color = Styles.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintKraft = Paint()
      ..color = Styles.pastelGreen
      ..style = PaintingStyle.fill;
    final paintKoordination = Paint()
      ..color = Styles.pastelYellow
      ..style = PaintingStyle.fill;
    final paintCardio = Paint()
      ..color = Styles.pastelRed
      ..style = PaintingStyle.fill;
    final paintBeweglichkeit = Paint()
      ..color = Styles.pastelBlue
      ..style = PaintingStyle.fill;

    final rectWhite = Rect.fromCenter(center: center, height: durchmesserWhite, width: durchmesserWhite);
    // final rectLine = Rect.fromCenter(center: center, height: radius, width: radius);
    final rect = Rect.fromCenter(center: center, height: durchmesser, width: durchmesser);

    canvas.drawArc(rectWhite, pi, pi * 2, true, paintWhite);

    /// Draw Kraft
    canvas.drawArc(rect, kraftStart, kraftMove, true, paintKraft);

    /// Draw Koordination
    canvas.drawArc(rect, koordinationStart, koordinationMove, true, paintKoordination);

    /// Draw Cardio
    canvas.drawArc(rect, cardioStart, cardioMove, true, paintCardio);

    /// Draw Beweglichkeit
    canvas.drawArc(rect, beweglichkeitStart, beweglichkeitMove, true, paintBeweglichkeit);

    ///Draw Lines between pie charts
    canvas.drawLine(center, Offset.fromDirection(kraftStart, durchmesserWhite / 2), paintLine);
    canvas.drawLine(center, Offset.fromDirection(koordinationStart, durchmesserWhite / 2), paintLine);
    canvas.drawLine(center, Offset.fromDirection(cardioStart, durchmesserWhite / 2), paintLine);
    canvas.drawLine(center, Offset.fromDirection(beweglichkeitStart, durchmesserWhite / 2), paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
