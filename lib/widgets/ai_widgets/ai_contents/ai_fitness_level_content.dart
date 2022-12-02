import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/used_objects.dart';

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
  List<String> fitnessLevelText = UsedObjects.fitnessLevelText;

  double sliderValue = 0.0;

  @override
  void initState() {
    widget.appUser.fitnessLevel ??= 0;
    sliderValue = widget.appUser.fitnessLevel!.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(fitnessLevelText[sliderValue.toInt()], style: Styles.subLinesLight, textAlign: TextAlign.center,),
          const SizedBox(height: 32.0),
          Column(
            children: [
              Slider(
                thumbColor: Styles.primaryColor,
                activeColor: Styles.grey,
                inactiveColor: Styles.lightGrey,
                value: widget.appUser.fitnessLevel!.toDouble(),
                min: 0,
                max: fitnessLevelText.length - 1,
                divisions: fitnessLevelText.length - 1,
                // label: widget.appUser.fitnessLevel.toString(),
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                    if (value > 1) {
                      if (value < 4) {
                        widget.appUser.fitnessLevel = 2;
                      } else {
                        widget.appUser.fitnessLevel = (value ~/ 1) - 1;
                      }
                    } else {
                      widget.appUser.fitnessLevel = value ~/ 1;
                    }
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nicht Fit', style: Styles.subLinesLight),
                  Text('Sehr Fit', style: Styles.subLinesLight),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
