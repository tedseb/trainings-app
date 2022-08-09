import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RandomScreenTwo extends StatefulWidget {
  const RandomScreenTwo({Key? key}) : super(key: key);

  @override
  State<RandomScreenTwo> createState() => _RandomScreenTwoState();
}

class _RandomScreenTwoState extends State<RandomScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.white,
      body: Center(child: Text('Training Plans Screen'),),
    );
  }
}