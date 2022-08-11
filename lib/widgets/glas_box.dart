import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';

class GlasBox extends StatelessWidget {
  GlasBox({
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
        width: 80.0,
        height: 80.0,
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
