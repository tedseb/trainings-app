import 'package:flutter/material.dart';
import 'package:higym/app_utils/validation_utils.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/widgets/general_widgets/text_form_field_widget.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),

            /// Deload Input Form
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Deload Headline
                  Text(
                    'How many repetitions did you do?',
                    style: Styles.subLinesBold,
                    textAlign: TextAlign.center,
                  ),

                  // Deload Input and Confirm
                  Column(
                    children: [
                      /// Done Repetitions Input
                      TextFormFieldWidget(
                        textEditingController: repetitonsController,
                        labelText: 'Repetitions',
                        hintText: 'Repetitions count',
                        textInputType: TextInputType.number,
                        validator: ValidationUtils().positiveNumberCheck,
                      ),

                      /// Spacer
                      const SizedBox(height: 30),

                      /// Confirm Button
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
