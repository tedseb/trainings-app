import 'package:flutter/material.dart';
import 'package:higym/authenticate/authenticate.dart';
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
    AppUser? user = Provider.of<AppUser?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<AppUser>.value(
          value: DatabaseService(uid: user?.uid).getUserData,
          initialData: AppUser(),
        ),
        StreamProvider<Goal>.value(
          value: DatabaseService(uid: user?.uid).getGoal,
          initialData: InitialModels.initialGoal,
        ),
      ],
      child: user == null ? const Authenticate() : const InitialScreen(),
    );
    //return either Home or Authenticate widget
    // if (user == null) {
    //   return const Authenticate();
    // } else {
    //   return const InitialScreen();
    // }
  }
}
