import 'package:flutter/material.dart';
import 'package:higym/authenticate/login_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
      return const LoginScreen();

    // if (showSignIn) {
    //   return const LoginScreen();
    // } else {
    //   return RegisterScreen(toggleView: toggleView);
    // }
  }
}
