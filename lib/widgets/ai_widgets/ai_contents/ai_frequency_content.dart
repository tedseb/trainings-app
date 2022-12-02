import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/widgets/ai_widgets/textfield_user_modifier_widget.dart';

import 'dart:developer' as dev;

class AiFrequencyContent extends StatefulWidget {
  const AiFrequencyContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiFrequencyContent> createState() => _AiFrequencyContentState();
}

class _AiFrequencyContentState extends State<AiFrequencyContent> {
  final daysController = TextEditingController();
  final minutesController = TextEditingController();


  List<String> daysList = ['Spontan','2','3','4','5'];
  // List<int> daysList = [1,2,3,4,5,6];
  List<String> minutesList = ['30-40','40-50', '50-60'];


  @override
  void initState() {
    widget.appUser.dayFrequenz != null ? daysController.text = widget.appUser.dayFrequenz.toString() : daysController.text = '';
    widget.appUser.minutesFrequenz != null ? minutesController.text = widget.appUser.minutesFrequenz! : minutesController.text = '';
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Stack(
            children: [
              TextFieldUserModifierWidget(controller: daysController, label: 'Tage', hintText: 'Anzahl Trainigs Tage', changeVal: changeDay),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Trainings Tage pro Woche',
                            valueUnit: '',
                            pickerList: daysList,
                            valueUpdater: changeDay,
                            initValue: daysController.text,
                          ));
                },
              ),
            ],
          ),
        ),
        Container(
          height: 68,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Stack(
            children: [
              TextFieldUserModifierWidget(controller: minutesController, label: 'Dauer', hintText: 'Dauer des Trainings', changeVal: changeMinutes),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Dauer pro Training',
                            valueUnit: 'min',
                            pickerList: minutesList,
                            valueUpdater: changeMinutes,
                            initValue: minutesController.text,
                          ));
                },
              ),
            ],
          ),
        ),
       
      ],
    );
  }

  changeDay(String val) {
    String returnValue = val;
    setState(() {
      if(val == 'Spontan'){
        returnValue = '1';
      }
      widget.appUser.dayFrequenz = int.tryParse(returnValue) ?? 1;
      daysController.text = val;
    });
  }

 

  changeMinutes(String val) {
    setState(() {
      widget.appUser.minutesFrequenz = val;
      minutesController.text = val;
    });
  }
}
