import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
     theme: ThemeData(scaffoldBackgroundColor: Styles.tertiaryColor, fontFamily: 'Montserrat'),
      
      home: const Home(),
    );
  }
}

