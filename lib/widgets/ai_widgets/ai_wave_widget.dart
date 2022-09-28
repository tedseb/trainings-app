import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AiWaveWidget extends StatefulWidget {
  const AiWaveWidget({Key? key}) : super(key: key);

  @override
  State<AiWaveWidget> createState() => _AiWaveWidgetState();
}

class _AiWaveWidgetState extends State<AiWaveWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.0,
      color: Colors.blue[100],
    );
  }
}