import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';

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
                      color: Colors.white70,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      )),
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Text(
                       widget.exeInfo,
                        style: Styles.exercisingTitle.copyWith(color: Styles.gymyGrey),
                      ),
                     
                    ],
                  ),
                )),
      ],
    );
  }
}
