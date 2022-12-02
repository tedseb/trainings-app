import 'dart:math';

import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/widgets/general_widgets/bmi_chart_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/weight_chart_widget.dart';
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
  AppUser? user;
  final weightController = TextEditingController();
  List<double> weightList = List<double>.generate(320, (i) => ((i / 2) + 40));
  DateTime now = DateTime.now();
  DateTime laterAsNow = DateTime(2022, 11, 25);

  late List<Map<DateTime, double>> weigthScores;
  // late List<WeigthScore>  weigthScores;

  // List<double> data = [];
  var rng = Random();
  int dayCount = 7;

  @override
  void initState() {
    setState(() => weigthScores = [
          {now: 10.0},
          // {laterAsNow: 10.0},
        ]);
    //  setState(() => weigthScores = newWeigthScores);
    // for (var i = 0; i < 20; i++) {
    //   data.add(rng.nextDouble() * 100.0);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    Size screenSize = MediaQuery.of(context).size;
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

                /// Weight Chart
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 0.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Styles.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        ///bottom right
                        BoxShadow(color: Colors.grey.shade400, offset: const Offset(4, 4), blurRadius: 10, spreadRadius: 4),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Weigth Chart',
                              style: Styles.subLinesBold,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8.0),
                        //  WeeklyChart(data),
                        WeightChartWidget(userWeigth: user!.weigth!, xAxisLength: 7, key: ValueKey(user!.weigth!.last.entries.first.value)),
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
                                    ));
                          },
                          loggerText: 'Update Weigth',
                        ),
                      ],
                    ),
                  ),
                ),

                /// BMI Chart
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Styles.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        ///bottom right
                        BoxShadow(color: Colors.grey.shade400, offset: const Offset(4, 4), blurRadius: 10, spreadRadius: 4),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'BMI Chart',
                              style: Styles.subLinesBold,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8.0),
                        BmiChartWidget(user: user!, key: ValueKey(user!.size)),
                        const SizedBox(height: 8.0),

                    
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0)
              ],
            )
          : const LoadingWidget(),
    );
  }

  bool userTester() {
    if (user == null) {
      dev.log('User IST null');
      return false;
    }

    if (user!.activityLevel == null) {
      dev.log('user!.activityLevel IST null');
      return false;
    }

    dev.log('user!.activityLevel != null');
    return true;
  }

  changeWeigth(double val) {
    String now = DateFormat('dd.MM').format(DateTime.now());
    setState(() {
      if (user!.weigth!.isEmpty) {
        user!.weigth!.add({now: val});
      } else {
        user!.weigth!.last.entries.first.key != now ? user!.weigth!.add({now: val}) : user!.weigth!.last = {now: val};
      }
    });
    // user!.weigth = val;
    DatabaseService(uid: user!.uid).updateUserData(user!);
    // setState(() {
    //   weightController.text = val.toString();
    // });
  }
}
