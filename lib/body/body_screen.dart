import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/circle_painter.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_vertical_picker_widget.dart';
import 'package:higym/widgets/ai_widgets/textfield_user_modifier_widget.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/progress_chart_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/zzz_deleteable/weekly_chart.dart';
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
    final newWeigthScores = List<WeigthScore>.generate(dayCount, (index) {
      final y = rng.nextDouble() * 30.0;
      final d = DateTime.now().add(Duration(days: -dayCount + index));
      return WeigthScore(y, d);
    });

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
                              'Current Weigth',
                              style: Styles.subLine,
                            ),
                          ],
                        ),
                        // Text(
                        //   user!.weigth.toString(),
                        //   style: Styles.subLineLigth,
                        // ),

                        const SizedBox(height: 8.0),
                        //  WeeklyChart(data),
                        ProgressChartWidget(userWeigth: user!.weigth!, xAxisLength: 7, key: ValueKey(user!.weigth!.last.entries.first.key)),
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
                                      initValue: user!.weigth.toString(),
                                    ));
                          },
                          loggerText: 'Update Weigth',
                        ),
                      ],
                    ),
                  ),
                ),
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
