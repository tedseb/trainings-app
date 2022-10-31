import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/helper_utils.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/authenticate/forgot_password_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/general_widgets/button_widget.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/login_register_alternatives.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

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
  // bool loginError = false;
  // String errorText = 'Ups... Something went wrong!';

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
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 110),
                  Text(
                    'Log in to your HiGym account',
                    style: Styles.logInScreenWelcomeText,
                  ),
                  const SizedBox(height: 40),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          /// Enter Email Field
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

                          /// Enter Password Field
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: Styles.textFormFieldLabel,
                              hintText: 'Your Password',
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
                              errorMaxLines: 2,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordInVisible = !passwordInVisible,
                                ),
                                child: Icon(
                                  passwordInVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  color: Styles.grey,
                                  size: 22,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passwordInVisible,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Your Password have to be at least 6 Characters!';
                              } else {
                                return null;
                              }
                            },
                          ),

                          /// Forgot Password Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /// Forget Password Button
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Styles.hiGymText,
                                  textStyle: Styles.loginWithAlternativText,
                                ),
                                onPressed: () => _openResetPassword(),
                                child: const Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// Login Error Text
                          Visibility(
                            visible: responseText != '',
                            child: Text(
                              responseText,
                              style: Styles.loginScreenPrivacyText.copyWith(color: Styles.error),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// LogIn Button
                          ShadowButtonWidget(
                            buttonText: 'Sign in',
                            buttonWidth: double.infinity,
                            onPressFunction: _signInWithEmail,
                            loggerText: 'Home #SignIn#',
                          ),
                          const SizedBox(height: 20),

                          /// Agree Terms Text
                          Text(
                            'By continuing forward, you agree to Higym\'s Privacy Policy and Terms & Conditions',
                            style: Styles.loginScreenPrivacyText,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 50),

                          /// LogIn With Google
                          LoginRegisterAlternatives(platform: 'Google', registerSignIn: 'Sign in with', onPressFunction: _logInWithGoogle),
                          const SizedBox(height: 20),
                        ],
                      )),
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
          dev.log('Login with Email Successfull');
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
        dev.log('Login with Google Successfull');
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
