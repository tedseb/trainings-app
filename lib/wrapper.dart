import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/ai_on_boarding_screen.dart';
import 'package:higym/initial_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppUser? user = Provider.of<AppUser?>(context);
    User? user = Provider.of<User?>(context);
    // user != null ? user.reload() : () {};
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>.value(
          value: DatabaseService(uid: user?.uid).getUserData,
          initialData: InitialModels.initialAppUser,
        ),
        StreamProvider<Goal>.value(
          value: DatabaseService(uid: user?.uid).getGoal,
          initialData: InitialModels.initialGoal,
        ),
      ],
      // child: _userAuthAndVerified(user),
      child: _userAuthAndVerified(user),
    );
    //return either Home or Authenticate widget
    // if (user == null) {
    //   return const Authenticate();
    // } else {
    //   return const InitialScreen();
    // }
  }

  _userAuthAndVerified(User? user) {
    if (user == null) {
      return const AiOnBoardingScreen();
      // return const Authenticate();
    }

    if (!user.emailVerified) {
      return const AiOnBoardingScreen();
      // return const Authenticate();
    }
    return const InitialScreen();
  }
}
