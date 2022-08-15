import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/auth.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.name.toString(), style: Styles.title,),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  dev.log('Open Logout Screen');

                  await _auth.signOut();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide.none,
                  ),
                  primary: Colors.transparent,
                  onPrimary: Styles.white,
                  elevation: 0.0,
                ),
                child: Text(
                  'Logout',
                  style: Styles.title.copyWith(color: Styles.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
