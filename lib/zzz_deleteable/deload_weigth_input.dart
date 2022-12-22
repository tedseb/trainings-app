import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';



class DeloadWeigthInput extends StatefulWidget {
  const DeloadWeigthInput({
    Key? key,
    required this.weigthUpdater,
  }) : super(key: key);
  final Function weigthUpdater;

  @override
  State<DeloadWeigthInput> createState() => _DeloadWeigthInputState();
}

class _DeloadWeigthInputState extends State<DeloadWeigthInput> {
  final Color modeColor = Styles.pastelYellow;

  final repetitonsController = TextEditingController();

  /// Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: modeColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'We are calculating your start weigth. \n How many repetitions did you do?',
                          style: Styles.subLinesBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
        
                  // Text
                  Column(
                    children: [
                      TextFormField(
                        controller: repetitonsController,
                         style: Styles.normalLinesLight,
                        decoration: InputDecoration(
                          labelText: 'Repetitions',
                          labelStyle: Styles.subLinesBold.copyWith(color: Styles.white),
                          hintText: 'Repetitions count',
                          hintStyle: Styles.smallLinesBold.copyWith(color: Styles.white),
                          isDense: true,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.white, width: 2.0),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.error, width: 2.0),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || !RegExp(r'^(\d+)$').hasMatch(value)) {
                            return 'Please enter only Positiv number of repetitions';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      ShadowButtonWidget(
                        buttonText: 'Okay',
                        buttonWidth: 120.0,
                        onPressFunction: enterRepetitions,
                        loggerText: 'First Repetitons',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  enterRepetitions() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      // int repetitionsCount = int.parse(repetitonsController.text);
      
      widget.weigthUpdater();
      Navigator.pop(context);
    }
  }
}
