import 'package:flutter/material.dart';
import 'package:higym/app_utils/validation_utils.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/constants/icon_constants.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/authenticate/forgot_password_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/login_register_alternatives.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Form Key
  final formKey = GlobalKey<FormState>();

  /// Authentification Service
  final AuthService _auth = AuthService();

  /// Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Password visibility
  bool passwordInVisible = true;

  /// Error Text
  String responseText = '';

  /// For Loading Screen
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: LoadingWidget())
          : SingleChildScrollView(
              // padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Spacer
                  const SizedBox(height: 110),

                  /// AI Sign Up Text
                  const AiTextWidget(possibleAiScreen: PossibleAiScreens.signInScreen, variation: 1),

                  /// Spacer
                  const SizedBox(height: 40),

                  /// Login Form
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            /// Enter Email Field
                            TextFormFieldWidget(
                              textEditingController: emailController,
                              labelText: 'E-mail',
                              hintText: 'Your Email Address',
                              textInputType: TextInputType.emailAddress,
                              validator: ValidationUtils().mailValidation,
                            ),

                            /// Spacer
                            const SizedBox(height: 30),

                            /// Enter Password Field
                            TextFormFieldWidget(
                              textEditingController: passwordController,
                              labelText: 'Password',
                              hintText: 'Your Password',
                              suffixIcon: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () => setState(
                                  () => passwordInVisible = !passwordInVisible,
                                ),
                                child: passwordInVisible ? IconConstants.passwordNotVisibleIcon : IconConstants.passwordVisibleIcon,
                              ),
                              textInputType: TextInputType.visiblePassword,
                              obscureText: passwordInVisible,
                              validator: ValidationUtils().passwordValidation,
                            ),

                            /// Forgot Password Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Styles.darkGrey,
                                    textStyle: Styles.smallLinesBold,
                                  ),
                                  onPressed: () => _openResetPassword(),
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),

                            /// Spacer
                            const SizedBox(height: 20),

                            /// Login Error Text
                            Visibility(
                              visible: responseText != '',
                              child: Text(
                                responseText,
                                style: Styles.smallLinesLight.copyWith(color: Styles.error),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            /// Spacer
                            const SizedBox(height: 20),

                            /// LogIn Button
                            ShadowButtonWidget(
                              buttonText: 'Sign in',
                              buttonWidth: double.infinity,
                              onPressFunction: _signInWithEmail,
                              loggerText: 'Home #SignIn#',
                            ),

                            /// Spacer
                            const SizedBox(height: 20),

                            /// Agree Terms Text
                            Text(
                              'By continuing forward, you agree to Higym\'s Privacy Policy and Terms & Conditions',
                              style: Styles.smallLinesBold,
                              textAlign: TextAlign.center,
                            ),

                            /// Spacer
                            const SizedBox(height: 50),

                            /// LogIn With Google
                            LoginRegisterAlternatives(platform: 'Google', registerSignIn: 'Sign in with', onPressFunction: _logInWithGoogle),

                            /// Spacer
                            const SizedBox(height: 20),
                          ],
                        )),
                  ),
                ],
              ),
            ),

      /// Back to OnBoarding Screen
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButtonWidget(
              buttonText: 'Zurück',
              buttonWidth: 120.0,
              onPressFunction: () => Navigator.pop(context),
              loggerText: 'Login',
            ),
          ],
        ),
      ),
    );
  }

  _signInWithEmail() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      /// Set Loading Screen and wait for response
      setState(() => loading = true);
      dynamic result = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);

      setState(() {
        if (result == null) {
          responseText = 'Could not sign in with those credentials.';
          loading = false;
        } else if (result is String) {
          responseText = result;
          loading = false;
        } else {
          responseText = '';
          loading = false;
          Navigator.pop(context);
          dev.log('Login with Email Successfull', name: 'Login_Screen');
        }
      });
    }
  }

  _logInWithGoogle() async {
    FocusManager.instance.primaryFocus?.unfocus();

    /// Set Loading Screen and wait for response
    setState(() => loading = true);
    dynamic result = await _auth.signInWithGoogle();

    setState(() {
      if (result == null) {
        responseText = 'Could not sign in with Google.';
        loading = false;
      } else if (result is String) {
        loading = false;
        responseText = result;
      } else {
        loading = false;
        responseText = '';
        Navigator.pop(context);
        dev.log('Login with Google Successfull', name: 'Login_Screen');
      }
    });
  }

  _openResetPassword() {
    // FocusManager.instance.primaryFocus?.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }
}
