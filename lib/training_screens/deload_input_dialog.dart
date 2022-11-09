import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

class DeloadInputDialog extends StatefulWidget {
  const DeloadInputDialog({
    required this.weigthUpdater,
    required this.weigth,
    required this.exeIndexUpdate,
    Key? key,
  }) : super(key: key);

  final double weigth;
  final int exeIndexUpdate;
  final Function weigthUpdater;

  @override
  State<DeloadInputDialog> createState() => _DeloadInputDialogState();
}

class _DeloadInputDialogState extends State<DeloadInputDialog> {
  final repetitonsController = TextEditingController();

  /// Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
        child: Container(
          padding: const EdgeInsets.all(0.0),
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 32.0),
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
                          'How many repetitions did you do?',
                          style: Styles.rpeScaleTitle.copyWith(color: Styles.hiGymText),
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
                        decoration: InputDecoration(
                          labelText: 'Repetitions',
                          labelStyle: Styles.textFormFieldLabel,
                          hintText: 'Repetitions count',
                          hintStyle: Styles.textFormFieldHintText,
                          isDense: true,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.hiGymText, width: 2.0),
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
      int repetitionsCount = int.parse(repetitonsController.text);

      widget.weigthUpdater(widget.weigth, repetitionsCount, widget.exeIndexUpdate);
      Navigator.pop(context);
    }
  }
}
