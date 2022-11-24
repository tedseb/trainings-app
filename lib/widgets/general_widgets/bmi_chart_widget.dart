import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/activity_calculator.dart';

class BmiChartWidget extends StatefulWidget {
  const BmiChartWidget({
    required this.user,
    Key? key,
  }) : super(key: key);

  final AppUser user;
  // final List<WeigthScore> weigthScores;

  @override
  State<BmiChartWidget> createState() => _BmiChartWidgetState();
}

class _BmiChartWidgetState extends State<BmiChartWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 70,
      width: screenSize.width - 98, //padding of the Parent Widget
      child: CustomPaint(
        painter: ChartPainter(widget.user.weigth!.last.entries.first.value, widget.user.size!),
        child: Container(),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final double userWeigth;
  final double userSize;
  ChartPainter(this.userWeigth, this.userSize);

  final Color backgroundColor = Styles.white;

  final progressBackground = Paint()
    ..color = Styles.progressBackground
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16.0;
  final underweightBmiLinePaint = Paint()
    ..color = Colors.lightGreen
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10.0;

  final healthyBmiLinePaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10.0;
  final overweightBmiLinePaint = Paint()
    ..color = Styles.orange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10.0;
  final obeseBmiLinePaint = Paint()
    ..color = Styles.error
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    const double underweightBmiLimit = 18.5;
    const double healthyBmiLimit = 24.99;
    const double overweightBmiLimit = 29.99;
    const double obeseBmiLimit = 39.99;

    double height = (size.height / 2) + 10.0;

    // double bmi = 30.09;
    double bmi = (userWeigth / (userSize * userSize)) * 10000;

    // Draw Background
    canvas.drawLine(Offset(0, height), Offset(size.width, height), progressBackground);

    drawTextCentered(canvas, Offset(bmi * (size.width / 40), height - 20), bmi.toStringAsFixed(1), Styles.smalText, size.width);

    /// Draw Obese BMI Line
    if (bmi > overweightBmiLimit) {
      if (bmi > obeseBmiLimit) {
        bmi = 39.9999;
      }

      canvas.drawLine(Offset(0, height), Offset(bmi * (size.width / 40), height), obeseBmiLinePaint);
      bmi = overweightBmiLimit;
    }

    /// Draw Overweight BMI Line
    if (bmi > healthyBmiLimit) {
      canvas.drawLine(Offset(0, height), Offset(bmi * (size.width / 40), height), overweightBmiLinePaint);
      bmi = healthyBmiLimit;
    }

    /// Draw Underweight BMI Line
    if (bmi > underweightBmiLimit) {
      canvas.drawLine(Offset(0, height), Offset(underweightBmiLimit * (size.width / 40), height), underweightBmiLinePaint);
    } else {
      canvas.drawLine(Offset(0, height), Offset(bmi * (size.width / 40), height), underweightBmiLinePaint);
      return;
    }

    /// Draw Healthy BMI Line
    if (bmi > underweightBmiLimit) {
      canvas.drawLine(Offset(underweightBmiLimit * (size.width / 40), height), Offset(bmi * (size.width / 40), height), healthyBmiLinePaint);
    }
  }

  ///Text Size
  TextPainter measureText(String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  /// Draw BMI Point
  Size drawTextCentered(Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, offset);
    return tp.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
