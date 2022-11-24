import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';


class WeightChartWidget extends StatefulWidget {
  const WeightChartWidget({
    required this.userWeigth,
    required this.xAxisLength,
    Key? key,
  }) : super(key: key);

 final List<Map<String, double>> userWeigth;
 final int xAxisLength;
  // final List<WeigthScore> weigthScores;

  @override
  State<WeightChartWidget> createState() => _WeightChartWidgetState();
}


class _WeightChartWidgetState extends State<WeightChartWidget> {
  late double min, max;
  late List<double> _y;
  late List<String> _x;

  @override
  void initState() {
    var newMin = double.maxFinite;
    var newMax = -double.maxFinite;

    List<Map<String, double>> showableWeigthList = [];
    if(widget.userWeigth.length < widget.xAxisLength){
      showableWeigthList = List.from(widget.userWeigth);
    }else{
      int weightListLength = widget.userWeigth.length;
      for (var i = 0; i < widget.xAxisLength; i++) {
        showableWeigthList.add(widget.userWeigth[weightListLength-1-i]);
      }
    }

    for (var p in showableWeigthList) {
      newMin = newMin > p.entries.first.value ?  p.entries.first.value : newMin;
      newMax = newMax <  p.entries.first.value?  p.entries.first.value : newMax;
    }
    if(newMin == newMax){
      newMax = newMax~/1+1.0;
      newMin = newMin~/1-1.0;
    }

    setState(() {
      min = newMin;
      max = newMax;
      
      _y = showableWeigthList.map((p) =>  p.entries.first.value).toList();
       _x = showableWeigthList.map((p) => p.entries.first.key).toList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 90,
      width: screenSize.width - 98, //padding of the Parent Widget
      child: CustomPaint(
        painter: ChartPainter(_x, _y, min, max),
        child: Container(),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  ChartPainter(this.x, this.y, this.min, this.max);

  final List<String> x;
  final List<double> y;
  final double min, max;

  final Color backgroundColor = Styles.white;
  // final Color backgroundColor = const Color(0xff1a1e23);

  final linePaint = Paint()
    ..color = Styles.darkGrey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;
    // ..strokeWidth = 1.0;
  final dotLinePaint = Paint()
    ..color = Styles.darkGrey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  final yLabelStyle = Styles.smalText;
  final xLabelStyle = Styles.normalText;
  // final yLabelStyle = const TextStyle(color: Colors.white38, fontSize: 14);
  // final xLabelStyle = const TextStyle(color: Colors.white38, fontSize: 16, fontWeight: FontWeight.bold);

  // final dotPaintFill = Paint()
  //   ..color = Colors.white
  //   ..style = PaintingStyle.stroke
  //   ..strokeWidth = 1.0;

  static double border = 10.0;
  static double radius = 3.0;
  // static double radius = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaintFill = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = backgroundColor);

    // compute the drawable chart width and height
    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / x.length.toDouble();

    final height = hd * 3.0;
    final width = drawableWidth;

    // escape if values are invalid
    if (height <= 0.0 || width <= 0.0) return;
    if (max - min < 1.0e-6) return;

    final hr = height / (max - min); // height per unit value

    final left = border;
    final top = border;
    final c = Offset(left + wd / 2.0, top + height / 2.0);

    // _drawOtline(canvas, c, wd, height);

    final points = _computePoints(c, wd, height, hr);
    final path = _computePath(points);
    final labels = _computeLabels();

    // draw data points and labels
    canvas.drawPath(path, linePaint);
    _drawDataPoints(canvas, points, dotPaintFill);
    _drawYLabels(canvas, labels, points, wd, top);

    // draw x labels
    final c1 = Offset(c.dx, top + 4.5 * hd);
    _drawXLabels(canvas, c1, wd);
  }

  void _drawXLabels(Canvas canvas, Offset c, double wd) {
    for (var xp in x) {
      drawTextCentered(canvas, c, xp, xLabelStyle, wd);
      c += Offset(wd, 0);
    }
  }

  void _drawYLabels(Canvas canvas, List<String> labels, List<Offset> points, double wd, double top) {
    var i = 0;
    for (var label in labels) {
      final dp = points[i];
      final dy = (dp.dy - 15.0) < top ? 15.0 : -15.0;
      final ly = dp + Offset(0, dy);
      drawTextCentered(canvas, ly, label, yLabelStyle, wd);
      i++;
    }
  }

  void _drawDataPoints(Canvas canvas, List<Offset> points, Paint dotPaintFill) {
    for (var dp in points) {
      canvas.drawCircle(dp, radius, dotPaintFill);
      // canvas.drawCircle(dp, radius, linePaint);
      canvas.drawCircle(dp, radius, dotLinePaint);
    }
  }

  Path _computePath(List<Offset> points) {
    final path = Path();

    for (var i = 0; i < points.length; i++) {
      final p = points[i];
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }

  List<Offset> _computePoints(Offset c, double width, double height, double hr) {
    List<Offset> points = [];

    for (var yp in y) {
      final yy = height - (yp - min) * hr;
      final dp = Offset(c.dx, c.dy - height / 2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    }
    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final Paint outlinePaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke
    ..color = Colors.black;

  void _drawOtline(Canvas canvas, Offset c, double width, double height) {
    for (var p in y) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect, outlinePaint);

      c += Offset(width, 0);
    }
  }

  List<String> _computeLabels() {
    return y.map((yp) => yp.toStringAsFixed(1)).toList();
  }

  TextPainter measureText(String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, offset);
    return tp.size;
  }
}
