import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer' as dev;

import 'package:higym/app_utils/styles.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

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
                style: Styles.logInScreenWelcomeText,
              ),
              const SizedBox(height: 30),
              Text(
                'Enter your HiGym account email and we\'ll send you instructions on how to reset your password',
                style: Styles.loginScreenPrivacyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: Styles.textFormFieldLabel,
                  hintText: 'Your Email Address',
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
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[\w\.\-]+@[\w\-]+\.([\w\-]\.)?[a-z]{2,6}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: resetResponse,
                child: Text(
                  responseText,
                  style: Styles.loginScreenPrivacyText.copyWith(color: resetResponseColor),
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
