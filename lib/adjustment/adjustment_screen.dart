import 'package:flutter/material.dart';
import 'package:higym/constants/icon_constants.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/widgets/general_widgets/row_item_with_select_widget.dart';
import 'package:higym/widgets/screen_widgets/about_screen.dart';
import 'package:higym/widgets/screen_widgets/talk_to_ai_screen.dart';
import 'package:higym/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:higym/widgets/general_widgets/user_name_badge_widget.dart';

class AdjustmentScreen extends StatefulWidget {
  const AdjustmentScreen({Key? key}) : super(key: key);

  @override
  State<AdjustmentScreen> createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    final goal = Provider.of<Goal?>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 150.0, 32.0, 30.0),
        child: ListView(
          children: [
            /// User Name and Badge
            UserNameBadgeWidget(userName: user!.name.toString(), userLvl: user.activityLevel!),
            SizedBox(height: screenSize.height / 10),

            /// Talk to AI Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: RowItemWithSelectWidget(
                leadingIcon: IconConstants.talkToAiIconData,
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
                leadingIcon: IconConstants.aboutIconData,
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
                leadingIcon: IconConstants.signOutIconData,
                widgetText: 'Log Out',
                onPressFunction: () async {
                  await _auth.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
