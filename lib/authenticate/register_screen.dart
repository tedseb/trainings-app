import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/services/auth.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/login_register_alternatives.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    required this.backToOnBoarding,
    required this.appUser,
    required this.onBoardingGoal,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;
  final Goal onBoardingGoal;
  final Function backToOnBoarding;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Authentification Service
  final AuthService _auth = AuthService();

  /// Keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Bools
  bool passwordInVisible = true;
  bool passwordInVisible2 = true;
  bool loading = false;

  /// Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  /// Error Text
  bool loginResponse = false;
  String responseText = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
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

                  /// AI Sign Up Text
                  Text(
                    'Sign up to save your workout progress and stats',
                    style: Styles.logInScreenWelcomeText,
                    textAlign: TextAlign.center,
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

                          /// Enter Password1 Field
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
                          const SizedBox(height: 30),

                          /// Enter Password2 Field
                          TextFormField(
                            controller: passwordController2,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: Styles.textFormFieldLabel,
                              hintText: 'Repeat your Password',
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
                                  () => passwordInVisible2 = !passwordInVisible2,
                                ),
                                child: Icon(
                                  passwordInVisible2 ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  color: Styles.grey,
                                  size: 22,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passwordInVisible2,
                            validator: (value) {
                              if (value != passwordController.text) {
                                return 'Both Passwords have to match eachother!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 20),

                          /// Sign Up Error Text
                          Visibility(
                            visible: responseText != '',
                            child: Text(
                              responseText,
                              style: Styles.loginScreenPrivacyText.copyWith(color: Styles.error),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Sign Up Button
                          ShadowButtonWidget(
                            buttonText: 'Sign up',
                            buttonWidth: double.infinity,
                            onPressFunction: _registerWithEmail,
                            loggerText: 'Home #SignUp#',
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
                          LoginRegisterAlternatives(platform: 'Google', registerSignIn: 'Sign in with', onPressFunction: _registerWithGoogle),
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

  _registerWithEmail() async {
    if (formKey.currentState!.validate()) {
      widget.appUser.email = emailController.text;

      /// Set Loading Screen and wait for response
      setState(() => loading = true);
      dynamic result = await _auth.registerWithEmailAndPassword(
        password: passwordController.text,
        onBoardingUser: widget.appUser,
        onboardingGoal: widget.onBoardingGoal,
      );

      if (result == null) {
        setState(() {
          responseText = 'This email is not valid or taken by an another User';
          loading = false;
        });
      } else {
        setState(() {
          responseText = '';
          loading = false;
        });
        backToOnBoarding();
        dev.log('Login with Email Successfull');
      }
    }
  }

  _registerWithGoogle() async {
    setState(() => loading = true);
    dynamic result = await _auth.registerWithGoogle(onBoardingUser: widget.appUser, onboardingGoal: widget.onBoardingGoal);

    if (result == null) {
      setState(() {
        responseText = 'Could not sign up with Google Account.';
        loading = false;
      });
    }  else {
      setState(() {
        responseText = '';
        // loading = false;
      });
      navPop();
      dev.log('Register with Email Successfull');
    }
  }

  void backToOnBoarding() {
    widget.backToOnBoarding();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
  void navPop() {
   Navigator.pop(context);
  }
}
