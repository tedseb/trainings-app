import 'package:flutter/cupertino.dart';

class RoundedDotPainter extends StatelessWidget {
  const RoundedDotPainter({
    required this.radius,
    required this.dotColor,
    this.topMargin,
    Key? key,
  }) : super(key: key);

  final double radius;
  final Color dotColor;
  final double? topMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin ?? 0.0),
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
