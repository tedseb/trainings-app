import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/widgets/ai_widgets/textfield_user_modifier_widget.dart';

import 'dart:developer' as dev;

import 'package:intl/intl.dart';

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

  List<int> ageList = List<int>.generate(90, (i) => i + 10);
  List<double> weightList = List<double>.generate(320, (i) => ((i / 2) + 40));
  List<double> sizeList = List<double>.generate(180, (i) => ((i / 2) + 130));
  List<String> genderList = ['Male', 'Female'];
  
  @override
  void initState() {
    widget.appUser.age != null ? ageController.text = widget.appUser.age.toString() : ageController.text = '';
    widget.appUser.weigth!.isNotEmpty
        ? weightController.text = widget.appUser.weigth!.last.entries.first.value.toString()
        : weightController.text = '';
    widget.appUser.size != null ? sizeController.text = widget.appUser.size.toString() : sizeController.text = '';
    widget.appUser.gender != null ? genderController.text = widget.appUser.gender! : genderController.text = '';
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
                            dialogName: 'Dein medizinisches Geschlecht',
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
    String now = DateFormat('dd.MM').format(DateTime.now());
    setState(() {
      if (widget.appUser.weigth!.isEmpty) {
        widget.appUser.weigth!.add({now: val});
      } else {
        widget.appUser.weigth!.last.entries.first.key != now ? widget.appUser.weigth!.add({now: val}) : widget.appUser.weigth!.last = {now: val};
      }
      // widget.appUser.weigth = val;
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
