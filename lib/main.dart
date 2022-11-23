import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:flutter/services.dart';
import 'package:higym/authenticate/login_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/wrapper.dart';
import 'package:provider/provider.dart';
import 'initial_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:developer' as dev;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Styles.white, fontFamily: 'GreycliffCF', dividerColor: Colors.transparent, splashColor: Styles.primaryColor),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
    
    
    // MaterialApp(
    //   theme: ThemeData(scaffoldBackgroundColor: Styles.white, fontFamily: 'Montserrat'),
    //   home: const MainPage(),
    // );
  }
}

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return const InitialScreen();
//             } else {
//               return const Authenticate();
//             }
//           }),
//     );
//   }
// }
