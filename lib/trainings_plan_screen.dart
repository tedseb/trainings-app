import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class TrainingsPlanScreen extends StatefulWidget {
  const TrainingsPlanScreen({Key? key}) : super(key: key);

  @override
  State<TrainingsPlanScreen> createState() => _TrainingsPlanScreenState();
}

class _TrainingsPlanScreenState extends State<TrainingsPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.white,
      body: Center(child: Text('Training Plans Screen'),),
    );
  }
}
