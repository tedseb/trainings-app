import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/widgets/ai_widgets/textfield_user_modifier_widget.dart';
import 'package:higym/widgets/general_widgets/textfield_widget.dart';

import 'dart:developer' as dev;

class AiPersonalDataContent extends StatefulWidget {
  const AiPersonalDataContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiPersonalDataContent> createState() => _AiPersonalDataContentState();
}

class _AiPersonalDataContentState extends State<AiPersonalDataContent> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final sizeController = TextEditingController();
  final genderController = TextEditingController();

  List<int> ageList = List<int>.generate(100, (i) => i);
  List<double> weightList = List<double>.generate(320, (i) => ((i / 2) + 40));
  List<double> sizeList = List<double>.generate(180, (i) => ((i / 2) + 130));
  List<String> genderList = ['Male', 'Female', 'Diverse'];

  @override
  void initState() {
    widget.appUser.age != null ? ageController.text = widget.appUser.age.toString() : ageController.text = 30.toString();
    widget.appUser.weigth != null ? weightController.text = widget.appUser.weigth.toString() : weightController.text = 70.0.toString();
    widget.appUser.size != null ? sizeController.text = widget.appUser.size.toString() : sizeController.text = 183.0.toString();
    widget.appUser.gender != null ? genderController.text = widget.appUser.gender.toString() : genderController.text = 'Male';
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
              TextFieldUserModifierWidget(controller: ageController, label: 'Alter', hintText: 'Dein Alter', changeVal: changeAge),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Alter',
                            valueUnit: '',
                            pickerList: ageList,
                            valueUpdater: changeAge,
                            initValue: ageController.text,
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
              TextFieldUserModifierWidget(controller: weightController, label: 'Gewicht', hintText: 'Dein Gewicht', changeVal: changeWeigth),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Gewicht',
                            valueUnit: 'kg',
                            pickerList: weightList,
                            valueUpdater: changeWeigth,
                            initValue: weightController.text,
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
              TextFieldUserModifierWidget(controller: sizeController, label: 'Größe', hintText: 'Deine Größe', changeVal: changeWeigth),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Größe',
                            valueUnit: 'cm',
                            pickerList: sizeList,
                            valueUpdater: changeSize,
                            initValue: sizeController.text,
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
              TextFieldUserModifierWidget(controller: genderController, label: 'Geschlecht', hintText: 'Dein Geschlecht', changeVal: changeWeigth),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AiVerticalPickerWidget(
                            dialogName: 'Geschlecht',
                            valueUnit: '',
                            pickerList: genderList,
                            valueUpdater: changeGender,
                            initValue: genderController.text,
                          ));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  changeAge(int val) {
    setState(() {
      widget.appUser.age = val;
      ageController.text = val.toString();
    });
  }

  changeWeigth(double val) {
    setState(() {
      widget.appUser.weigth = val;
      weightController.text = val.toString();
    });
  }

  changeSize(double val) {
    setState(() {
      widget.appUser.size = val;
      sizeController.text = val.toString();
    });
  }

  changeGender(String val) {
    setState(() {
      widget.appUser.gender = val;
      genderController.text = val;
    });
  }
}
