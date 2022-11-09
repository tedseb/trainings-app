import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/widgets/general_widgets/row_item_with_select_widget.dart';
import 'package:higym/widgets/screen_widgets/about_screen.dart';
import 'package:higym/widgets/screen_widgets/talk_to_ai_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';
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
    final goal = Provider.of<Goal?>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// User Name and Badge
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
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
                    child: Image.asset('assets/badges/${user.activityLevel}.png', height: 75),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height / 10),

            /// Goals Button it will go
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            //   child: RowItemWithSelectWidget(
            //     leadingIcon: Icons.flag_outlined,
            //     widgetText: 'My Goals',
            //     onPressFunction: () {
            //       DatabaseService(uid: user.uid!).addGoal(shawanGoal);
            //     },
            //   ),
            // ),

            // /// My Body Button
            // Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            //     child: RowItemWithSelectWidget(
            //       leadingIcon: Icons.accessibility_new_rounded,
            //       widgetText: 'My Body',
            //       onPressFunction: () {},
            //     )),

            /// Talk to AI Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.surround_sound_outlined,
                widgetText: 'Talk AI',
                onPressFunction: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalkToAiScreen(appUser: user.appUserToJson(), goal: goal!.goalToJson()),
                    ),
                  );
                },
              ),
            ),

            /// Settings Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.settings_outlined,
                widgetText: 'About',
                onPressFunction: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),
            ),

            /// Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: Icons.logout_rounded,
                widgetText: 'Log Out',
                onPressFunction: () async {
                  await _auth.signOut();
                },
              ),
            ),
            const SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
}
