import 'package:flutter/material.dart';
import 'package:higym/authenticate/authenticate.dart';
import 'package:higym/initial_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUser? user = Provider.of<AppUser?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Exercises>>.value(
          value: DatabaseService().exerciseDatabase,
          initialData: const [],
        ),
        StreamProvider<List<Plans>>.value(
          value: DatabaseService(uid: user?.uid, collectionPlansOrDonePlans: 'UserExercisePlans').allPlans,
          initialData: const [],
        ),
        StreamProvider<List<Map<DateTime, List<Plans>>>>.value(
          value: DatabaseService(uid: user?.uid, collectionPlansOrDonePlans: 'FinishedExercises').donePlans,
          initialData: const [],
        ),
        StreamProvider<AppUser>.value(
          value: DatabaseService(uid: user?.uid).getUserData,
          initialData: AppUser(),
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
