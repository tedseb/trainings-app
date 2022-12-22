import 'package:flutter/material.dart';
import 'package:higym/app_utils/validation_utils.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/widgets/general_widgets/text_form_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  /// Form Key
  final formKey = GlobalKey<FormState>();

  /// Authentification Service
  final AuthService _auth = AuthService();

  /// Error Text
  bool resetResponse = false;
  Color resetResponseColor = Styles.error;
  String responseText = 'Something went wrong...';

  /// Text Editing Controller
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 110),
              Text(
                'Reset password',
                style: Styles.subLinesBold,
              ),
              const SizedBox(height: 30),
              Text(
                'Enter your HiGym account email and we\'ll send you instructions on how to reset your password',
                style: Styles.smallLinesBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormFieldWidget(
                textEditingController: emailController,
                labelText: 'E-mail',
                hintText: 'Your Email Address',
                textInputType: TextInputType.emailAddress,
                validator: ValidationUtils().mailValidation,
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: resetResponse,
                child: Text(
                  responseText,
                  style: Styles.smallLinesLight.copyWith(color: resetResponseColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ShadowButtonWidget(
                buttonText: 'reset',
                buttonWidth: double.infinity,
                onPressFunction: _resetPassword,
                loggerText: '#reset#',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButtonWidget(
              buttonText: 'zurück',
              buttonWidth: 120.0,
              onPressFunction: () => Navigator.pop(context),
              loggerText: 'Login',
            ),
          ],
        ),
      ),
    );
  }

  _resetPassword() async {
    // setState(() => loading = true);
    if (formKey.currentState!.validate()) {
      dynamic result = await _auth.resetPassword(context, emailController.text);
      setState(() {
        if (result == null) {
          responseText = 'The email adress doesn\'t exist!';
          resetResponseColor = Styles.error;
        } else {
          responseText = 'Password resettet!';
          resetResponseColor = Styles.primaryColor;
        }
        resetResponse = true;
      });
    }
  }
}
