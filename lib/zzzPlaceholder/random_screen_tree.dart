import 'package:flutter/material.dart';

import 'package:higym/app_utils/styles.dart';

class RandomScreenTree extends StatefulWidget {
  const RandomScreenTree({Key? key}) : super(key: key);

  @override
  State<RandomScreenTree> createState() => _RandomScreenTreeState();
}

class _RandomScreenTreeState extends State<RandomScreenTree> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.white,
      body: Center(child: Text('Training Plans Screen'),),
    );
  }
}