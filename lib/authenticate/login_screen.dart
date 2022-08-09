import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/services/auth.dart';

import 'dart:developer' as dev;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Authentification Service
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Styles.gymyGrey,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            cursorColor: Styles.gymyGrey,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _signInWithEmail,
            icon: const Icon(Icons.lock_open_rounded, size: 32),
            label: const Text('Sign In', style: TextStyle(fontSize: 24)),
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          )
        ],
      ),
    );
  }

  _signInWithEmail() async {
    dynamic result = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);
    // await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);

    

    if (result == null) {
      // setState(() {
      //   error = 'Could not sign in with those credentials.';
      //   loading = false;
      // });
    }else{
      dev.log(result.toString());

    }
  }
}
