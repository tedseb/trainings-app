import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RandomScreenOne extends StatefulWidget {
  const RandomScreenOne({Key? key}) : super(key: key);

  @override
  State<RandomScreenOne> createState() => _RandomScreenOneState();
}

class _RandomScreenOneState extends State<RandomScreenOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.white,
      body: Center(child: Text('Training Plans Screen'),),
    );
  }
}