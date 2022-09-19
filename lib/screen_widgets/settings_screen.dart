import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/auth.dart';
import 'package:higym/widgets/shadow_icon_button_widget.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 38.0,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Styles.hiGymText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                /// User Name and Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Settings', style: Styles.title.copyWith(fontWeight: FontWeight.w300)),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.settings_outlined, color: Styles.hiGymText),
                    ),
                  ],
                ),
                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reminder', style: Styles.profileItemText),
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
                      ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
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
                          Text('Rate us on App Store', style: Styles.profileItemText),
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
                      ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
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
                          Text('Terms & Conditions', style: Styles.profileItemText),
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
                      ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
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
                          Text('Delete Account', style: Styles.profileItemText),
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
                      ShadowIconButtonWidget(buttonIcon: Icons.chevron_right_rounded, onPressFunction: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
