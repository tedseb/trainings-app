import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/services/training_programs_database.dart';
import 'package:higym/widgets/general_widgets/exercise_card_widget.dart';
import 'package:higym/widgets/general_widgets/glas_box_widget.dart';

import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class AiGymEquipmentContent extends StatefulWidget {
  const AiGymEquipmentContent({
    required this.appUser,
    required this.goalUpdater,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;
  final Function goalUpdater;

  @override
  State<AiGymEquipmentContent> createState() => _AiGymEquipmentContentState();
}

class _AiGymEquipmentContentState extends State<AiGymEquipmentContent> {
  List<Map<String, bool>> gymEquipment = [];
  Goal? newGoal;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Goal>(
      future: TrainingProgramsDatabase(
        userGoalGroup: UsedObjects.goalObjects.firstWhere((goalObject) => goalObject['titel'] == widget.appUser.goalName)['goalGroup'],
        userGoal: widget.appUser.goalName!,
        userLevel: widget.appUser.fitnessLevel!,
        userDayFrequenz: widget.appUser.dayFrequenz.toString(),
        userAdditionalMusclegroup: widget.appUser.additionalMusclegroup!,
        userMinutesFrequenz: widget.appUser.minutesFrequenz!,
        appUser: widget.appUser,
      ).getNewGoal(),
      builder: (context, snapshot) {
        newGoal = snapshot.data;
        if (newGoal != null) {
          widget.goalUpdater(newGoal);
          gymEquipment = getEquipment(newGoal!);
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gymEquipment.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 26.0, bottom: 32.0),
                child: SizedBox(
                  height: 75.0,
                  // color: Colors.grey[50],
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlasBoxWidget(exerciseImage: 'dumbbell'),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26.0, top: 4.0, right: 26.0, bottom: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                gymEquipment[index].keys.first,
                                style: Styles.trainingsplanCardExeTitle,
                              ),
                              // Text(
                              //   'Learn more',
                              //   style: Styles.trainingsplanCardExeSubTitle,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // gymEquipment[index].values.first
                      //     ? ShadowIconButtonWidget(
                      //         buttonIcon: Icons.done_rounded,
                      //         onPressFunction: () => setState(() => gymEquipment[index][gymEquipment[index].keys.first] = false),
                      //         loggerText: 'add_${gymEquipment[index].keys.first}',
                      //       )
                      //     : ShadowIconButtonWidget(
                      //         buttonIcon: Icons.add_rounded,
                      //         onPressFunction: () => setState(() => gymEquipment[index][gymEquipment[index].keys.first] = true),
                      //         loggerText: 'delete_${gymEquipment[index].keys.first}',
                      //       ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  List<Map<String, bool>> getEquipment(Goal newGoal) {
    List<Map<String, bool>> fullEquipment = [];
    List<String> doubleNameCheck = [];

    for (Plans plan in newGoal.trainingsProgramms[0].plans) {
      for (Exercises exercise in plan.exercises) {
        for (String handle in exercise.handle) {
          if (!doubleNameCheck.contains(handle) && handle != 'handle') {
            doubleNameCheck.add(handle);
            fullEquipment.add({handle: true});
          }
        }
        for (String station in exercise.station) {
          if (!doubleNameCheck.contains(station) && station != 'station') {
            doubleNameCheck.add(station);
            fullEquipment.add({station: true});
          }
        }
      }
    }

    return fullEquipment;
  }
}
