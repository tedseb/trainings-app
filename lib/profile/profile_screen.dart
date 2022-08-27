import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// User Name and Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      style: Styles.homeCardName,
                      children: [
                        TextSpan(text: 'Hi ', style: Styles.title.copyWith(fontWeight: FontWeight.w500)),
                        TextSpan(text: user!.name.toString(), style: Styles.title.copyWith(fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset('assets/badges/weight_nike_badge.png', height: 75),
                ),
              ],
            ),
            const SizedBox(height: 100),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.flag_outlined, color: Styles.gymyGrey),
                  Text('My Goals', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.accessibility_new_rounded, color: Styles.gymyGrey),
                  Text('My Body', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.surround_sound_outlined, color: Styles.gymyGrey),
                  Text('Talk AI', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.settings_outlined, color: Styles.gymyGrey),
                  Text('Settings', style: Styles.profileItemText),
                  ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 16.0),
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       dev.log('Open Logout Screen');

            //       await _auth.signOut();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(16.0),
            //         side: BorderSide.none,
            //       ),
            //       primary: Colors.transparent,
            //       onPrimary: Styles.white,
            //       elevation: 0.0,
            //     ),
            //     child: Text(
            //       'Logout',
            //       style: Styles.title.copyWith(color: Styles.primaryColor),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
