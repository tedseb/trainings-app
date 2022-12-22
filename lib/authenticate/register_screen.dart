import 'package:flutter/material.dart';
import 'package:higym/app_utils/validation_utils.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/constants/icon_constants.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/login_register_alternatives.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/text_form_field_widget.dart';

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
  State<RegisterScreen> createState() => _RegisterScreenState();
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
                  /// Spacer
                  const SizedBox(height: 110),

                  /// AI Sign Up Text
                  AiTextWidget(user: widget.appUser, possibleAiScreen: PossibleAiScreens.signUpScreen, variation: 1),

                  /// Spacer
                  const SizedBox(height: 40),

                  /// Login Form
                  Form(
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

                          /// Spacer
                          const SizedBox(height: 30),

                          /// Enter Password2 Field
                          TextFormFieldWidget(
                            textEditingController: passwordController2,
                            labelText: 'Password',
                            hintText: 'Repeat your Password',
                            suffixIcon: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => setState(
                                () => passwordInVisible2 = !passwordInVisible2,
                              ),
                              child: passwordInVisible2 ? IconConstants.passwordNotVisibleIcon : IconConstants.passwordVisibleIcon,
                            ),
                            textInputType: TextInputType.visiblePassword,
                            obscureText: passwordInVisible2,
                            validator: ValidationUtils(originalPasswordController: passwordController).password2Validation,
                          ),

                          /// Spacer
                          const SizedBox(height: 20),

                          /// Sign Up Error Text
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

                          /// Sign Up Button
                          ShadowButtonWidget(
                            buttonText: 'Sign up',
                            buttonWidth: double.infinity,
                            onPressFunction: _registerWithEmail,
                            loggerText: 'Home #SignUp#',
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
                          LoginRegisterAlternatives(platform: 'Google', registerSignIn: 'Sign in with', onPressFunction: _registerWithGoogle),

                          /// Spacer
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
        dev.log('Register with Email Successfull', name: 'Register_Screen');
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
    } else {
      setState(() {
        responseText = '';
        // loading = false;
      });
      navPop();
      dev.log('Register with Google Successfull', name: 'Register_Screen');
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
