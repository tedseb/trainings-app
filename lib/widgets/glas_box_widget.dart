import 'dart:ui';

import 'package:flutter/material.dart';

class GlasBoxWidget extends StatelessWidget {
  GlasBoxWidget({
    Key? key,
    required this.exerciseImage,
  }) : super(key: key);

  final String exerciseImage;

  final borderRadius = BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: 75.0,
        height: 75.0,
        child: Stack(
          children: [
            ///blurr effect
            BackdropFilter(
                filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            )),

            ///gradient effect
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade300.withOpacity(0.2),
                    Colors.grey.shade300.withOpacity(0.4),
                  ],
                ),
              ),
            ),

            ///child
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/exercises/$exerciseImage.png'),
            ),
          ],
        ),
      ),
    );
  }
}
