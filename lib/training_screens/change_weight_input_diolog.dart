import 'package:flutter/material.dart';
import 'package:higym/app_utils/validation_utils.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/widgets/general_widgets/text_form_field_widget.dart';

class ChangeWeightInputDiolog extends StatefulWidget {
  const ChangeWeightInputDiolog({
    required this.weigthUpdater,
    required this.exeIndexUpdate,
    Key? key,
  }) : super(key: key);

  final int exeIndexUpdate;
  final Function weigthUpdater;

  @override
  State<ChangeWeightInputDiolog> createState() => _ChangeWeightInputDiologState();
}

class _ChangeWeightInputDiologState extends State<ChangeWeightInputDiolog> {
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
                    'What weight do you want to change it to?',
                    style: Styles.subLinesBold,
                    textAlign: TextAlign.center,
                  ),

                  // Deload Input and Confirm
                  Column(
                    children: [
                      /// Done Repetitions Input
                      TextFormFieldWidget(
                        textEditingController: repetitonsController,
                        labelText: 'Weight',
                        hintText: 'New Weight',
                        textInputType: TextInputType.number,
                        validator: ValidationUtils().doubleNumberCheck,
                      ),

                      /// Spacer
                      const SizedBox(height: 30),

                      /// Confirm Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShadowButtonWidget(
                            buttonText: 'Cancel',
                            buttonWidth: 100.0,
                            onPressFunction: () async => Navigator.pop(context),
                            loggerText: 'Cancel WeightChange',
                          ),
                          ShadowButtonWidget(
                            buttonText: 'Okay',
                            buttonWidth: 100.0,
                            onPressFunction: enterNewWeight,
                            loggerText: 'New Weight',
                          ),
                        ],
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

  enterNewWeight() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      String newWeightString = repetitonsController.text.replaceAll(',', '.');
      double newWeight = double.parse(newWeightString);

      widget.weigthUpdater(newWeight, widget.exeIndexUpdate);
      Navigator.pop(context);
    }
  }
}
