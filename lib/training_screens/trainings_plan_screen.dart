import 'package:flutter/material.dart';


import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/widgets/exercise_card_widget.dart';
import 'package:provider/provider.dart';

class TrainingsPlanScreen extends StatefulWidget {
  const TrainingsPlanScreen({Key? key}) : super(key: key);

  @override
  State<TrainingsPlanScreen> createState() => _TrainingsPlanScreenState();
}

class _TrainingsPlanScreenState extends State<TrainingsPlanScreen> {
  List<Plans>? myPlans;
  late Plans selectedPlan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedPlan = Provider.of<List<Plans>>(context).firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());
    return Scaffold(
      body: Column(
        children: [
          ///Emergency Button
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Styles.emergencyIcon,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          ///Plan Name
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 70.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPlan.name ?? 'Trainings Plan Loading...',
                      style: Styles.trainingsplanTitle,
                    ),
                    Text(
                      'train',
                      style: Styles.trainingsplanSubTitle,
                    ),
                  ],
                )
              ],
            ),
          ),

          ///Plan Parameter
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('Parameter', style: Styles.trainingsplanIconTitle),
                    Styles.fitnessIcon,
                  ],
                ),
                Column(
                  children: [
                    Text('Parameter', style: Styles.trainingsplanIconTitle),
                    Styles.statusBarIcon,
                  ],
                ),
                Column(
                  children: [
                    Text('Parameter', style: Styles.trainingsplanIconTitle),
                    Styles.plusIcon,
                  ],
                ),
              ],
            ),
          ),

          /// Shadow Divider
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 0.0),
            child: Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 10, offset: Offset(0, 13), color: Colors.grey, spreadRadius: -7)],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
              children: const [
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
                ExerciseCardWidget(),
              
              ],
            ),
          ),
        ],
      ),
    );
  }



  // void actualPlan() {
  //   setState(() {
  //     selectedPlan = myPlans?.firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());
  //   });
  // }
}
