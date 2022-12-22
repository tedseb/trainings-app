import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/paintings/bmi_chart_painter.dart';
import 'package:higym/widgets/general_widgets/shadow_card_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/paintings/weight_chart_painter.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  /// AppUser Object
  AppUser? user;

  ///TextEditingController
  final weightController = TextEditingController();

  ///Constants
  List<double> weightList = ValueConstants.weightList;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return Scaffold(
      body: userTester()
          ? ListView(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
                //   child: SizedBox(
                //     height: screenSize.width,
                //     width: screenSize.width,
                //     child: CustomPaint(
                //       foregroundPainter: BackgroundCirclePainter(
                //         progressBigPercent: 1 / 4,
                //         progressBigReachPercent: 16 / 16,
                //         progressSmallPercet: 1 / 4,
                //         progressSmallReachPercet: 1 / 4,
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Mein Körper',
                //             style: Styles.normalText,
                //           ),
                //           Text(
                //             'Status',
                //             style: Styles.normalTextBold,
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                /// Spacer
                const SizedBox(height: 200),

                /// Weight Chart
                ShadowCardWidget(
                  key: const ValueKey('Weigth Chart'),
                  cardChild: Column(
                    children: [
                      /// Weight Chart Headline
                      Row(children: [Text('Weigth Chart', style: Styles.subLinesBold)]),

                      /// Spacer
                      const SizedBox(height: 8.0),

                      /// Painting Weight Chart
                      WeightChartPainter(userWeigth: user!.weigth!, xAxisLength: 5, key: ValueKey(user!.weigth!.last.entries.first.value)),

                      /// Spacer
                      const SizedBox(height: 8.0),

                      /// Update Weigth Button
                      ShadowButtonWidget(
                        buttonText: 'Update Weigth',
                        buttonWidth: 180.0,
                        onPressFunction: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AiVerticalPickerWidget(
                              dialogName: 'Gewicht',
                              valueUnit: 'kg',
                              pickerList: weightList,
                              valueUpdater: changeWeigth,
                              initValue: user!.weigth!.last.entries.first.value.toString(),
                            ),
                          );
                        },
                        loggerText: 'Update Weigth',
                      ),
                    ],
                  ),
                ),

                /// Spacer
                const SizedBox(height: 32),

                /// BMI Chart
                ShadowCardWidget(
                  key: const ValueKey('BMI Chart'),
                  cardChild: Column(
                    children: [
                      /// BMI Chart Headline
                      Row(children: [Text('BMI Chart', style: Styles.subLinesBold)]),

                      /// Spacer
                      const SizedBox(height: 8.0),

                      /// Painting BMI Chart
                      BmiChartPainter(user: user!, key: ValueKey(user!.size)),

                      /// Spacer
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),

                /// Spacer
                const SizedBox(height: 100.0)
              ],
            )
          : const LoadingWidget(),
    );
  }

  bool userTester() {
    if (user == null) {
      dev.log('User NULL', name: 'Body_Screen');
      return false;
    }
    dev.log('User OK', name: 'Body_Screen');
    return true;
  }

  changeWeigth(double val) {
    String now = DateFormat('dd.MM').format(DateTime.now());
    // String now = '03.12';
    setState(() {
      if (user!.weigth!.isEmpty) {
        user!.weigth!.add({now: val});
      } else {
        user!.weigth!.last.entries.first.key != now ? user!.weigth!.add({now: val}) : user!.weigth!.last = {now: val};
      }
    });
    DatabaseService(uid: user!.uid).updateUserData(user!);
  }
}
