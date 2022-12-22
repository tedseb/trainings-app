import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

import 'dart:developer' as dev;

class ExerciseInfoTextScreen extends StatefulWidget {
  const ExerciseInfoTextScreen({
    Key? key,
    required this.exeInfo,
  }) : super(key: key);

  final String exeInfo;

  @override
  State<ExerciseInfoTextScreen> createState() => _ExerciseInfoTextScreenState();
}

class _ExerciseInfoTextScreenState extends State<ExerciseInfoTextScreen> {
  @override
  Widget build(BuildContext context) {
    dev.log(MediaQuery.of(context).size.height.toString());
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (context, scrollController) => Container(
            decoration: const BoxDecoration(
              color: Styles.whiteTransparent,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              controller: scrollController,
              children: [
                // Text(
                //   'Stelle dich mit den Füßen schulterbreit auseinander.',
                //   style: Styles.subLinesBold,
                // ),
                // SizedBox(height: 16,),
                // Text(
                //  ' Behalte die natürliche Wölbung deines Rückens bei.',
                //   style: Styles.subLinesBold,
                // ),
                // SizedBox(height: 16,),

                // Text(
                //  'Drücke deine Schulterblätter zusammen und hebe deinen Brustkorb.',
                //   style: Styles.subLinesBold,
                // ),
                // Text(
                //  'Greife die Hantel quer über die Schultern und stütze sie auf deinem oberen Rücken ab. Löse die Hantel, indem du die Beine streckst, und mache einen Schritt zurück.',
                //   style: Styles.normalLinesLight,
                // ),
                // Text(
                //   'Beuge die Knie, während du das Gewicht senkst, ohne die Form deines Rückens zu verändern, bis deine Hüfte unter den Knien ist.',
                //   style: Styles.normalLinesLight,
                // ),
                // Text(
                //   'Hebe die Hantel wieder in die Ausgangsposition, hebe sie mit den Beinen an und atme oben aus.',
                //   style: Styles.normalLinesLight,
                // ),
                Text(
                  widget.exeInfo,
                  style: Styles.normalLinesLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
