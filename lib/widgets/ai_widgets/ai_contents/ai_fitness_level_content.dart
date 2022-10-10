import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';

class AiFitnessLevelContent extends StatefulWidget {
  const AiFitnessLevelContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiFitnessLevelContent> createState() => _AiFitnessLevelContentState();
}

class _AiFitnessLevelContentState extends State<AiFitnessLevelContent> {
  
  
  List<String> fitnessLevelText = [
    '',
    '',
    '',
    '',
    '',
  ];

  double sliderValue = 0.0;


  @override
  void initState() {
    widget.appUser.fitnessLevel ??= 0;
    sliderValue = widget.appUser.fitnessLevel!.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Slider(
            thumbColor: Styles.primaryColor,
            activeColor: Styles.grey,
            inactiveColor: Styles.grey,
            value: widget.appUser.fitnessLevel!.toDouble(),
            min: 0,
            max: 13,
            divisions: 12,
            // label: _currentSliderValue.toString(),
            onChanged: (double value) {
              setState(() {
                widget.appUser.fitnessLevel = value ~/ 1;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Nicht Fit', textAlign: TextAlign.center,),
              Text('Sehr Fit'),
            ],
          )
        ],
      ),
    );
  }
}
