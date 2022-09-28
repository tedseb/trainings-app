import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/services/auth.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/loading_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final Function toggleView;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Authentification Service
  final AuthService _auth = AuthService();

  // Keys
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Bools
  late bool passwordVisibility1;
  late bool passwordVisibility2;
  bool loading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  // TextField state
  String email = '';
  String userName = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: LoadingWidget())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Styles.hiGymText,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    cursorColor: Styles.hiGymText,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: passwordController,
                    cursorColor: Styles.hiGymText,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _registerWithEmail,
                    icon: const Icon(Icons.app_registration_rounded, size: 32),
                    label: const Text('Register', style: TextStyle(fontSize: 24)),
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: ElevatedButton(
                      onPressed: () => widget.toggleView(),
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                      child: const Text('Go to Login'),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _registerWithEmail() async {
    setState(() => loading = true);
    dynamic result = await _auth.registerWithEmailAndPassword(emailController.text, passwordController.text, nameController.text);

    if (result == null) {
      setState(() {
        error = 'This email is not valid or taken by an another User';
        loading = false;
      });
    } else {
      setState(() => loading = false);
      widget.toggleView();
      FirebaseAuth.instance.signOut();
    }
  }
}
