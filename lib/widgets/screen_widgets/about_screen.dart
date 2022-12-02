import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/gymion_icons_1_0_icons.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 38.0,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Styles.darkGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                /// User Name and Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('About', style: Styles.headLinesBold),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(GymionIcons_1_0.einstellungen, color: Styles.darkGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 100),

                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text('Reminder', style: Styles.profileItemText),
                //           Container(
                //             margin: const EdgeInsets.only(top: 4.0),
                //             width: 32.0,
                //             height: 4,
                //             decoration: BoxDecoration(
                //               color: Styles.primaryColor,
                //               borderRadius: BorderRadius.circular(50),
                //             ),
                //           ),
                //         ],
                //       ),
                //       ShadowIconButtonWidget(buttonIcon: GymionIcons_1_0.pfeil, onPressFunction: () {}),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rate us on App Store', style: Styles.normalLinesLight),
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            width: 32.0,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Styles.primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                      ShadowIconButtonWidget(
                        buttonIcon: GymionIcons_1_0.pfeil,
                        onPressFunction: () {},
                        loggerText: 'Rate us on App Store',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Terms & Conditions', style: Styles.normalLinesLight),
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            width: 32.0,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Styles.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                      ShadowIconButtonWidget(
                        buttonIcon: GymionIcons_1_0.pfeil,
                        onPressFunction: () {},
                        loggerText: 'Terms & Conditions',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delete Account', style: Styles.normalLinesLight),
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            width: 32.0,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Styles.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                      ShadowIconButtonWidget(
                        buttonIcon: GymionIcons_1_0.pfeil,
                        onPressFunction: () {
                          // AuthService().deleteUser(context);
                          FirebaseAuth.instance.currentUser!.delete();
                        },
                        loggerText: 'Delete Account',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
