import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';
import 'package:intl/intl.dart';

class AiGoalContent extends StatefulWidget {
  const AiGoalContent({
    required this.appUser,
    // required this.goalUpdater,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;
  // final Function goalUpdater;

  @override
  State<AiGoalContent> createState() => _AiGoalContentState();
}

class _AiGoalContentState extends State<AiGoalContent> {
  int _selectedItem = 0;

  final DateTime phase1Start = ActivityCalculator.thisWeekStart(addWeeks: 0);
  final DateTime phase2Start = ActivityCalculator.thisWeekStart(addWeeks: 2);
  final DateTime phase3Start = ActivityCalculator.thisWeekStart(addWeeks: 6);
  final DateTime goalEnding = ActivityCalculator.thisWeekStart(addWeeks: 10);

  @override
  void initState() {
    _selectedItem = UsedObjects.goalObjects.indexWhere((element) => element['titel'] == widget.appUser.goalName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: UsedObjects.goalObjects.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: InkWell(
              onTap: () => _onItemTapped(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Styles.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    ///bottom right
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(3, 3),
                      blurRadius: 3,
                    ),

                    ///top left
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-3, -3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    NavbarIconButtonWidget(
                      onPressedFunction: () => _onItemTapped(index),
                      iconData: UsedObjects.goalObjects[index]['icon'],
                      selectedItem: _selectedItem,
                      index: index,
                      borderHeigth: 4.0,
                      borderWidth: 30.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(UsedObjects.goalObjects[index]['titel'], style: Styles.subLinesBold),
                          Text(UsedObjects.goalObjects[index]['subTitel'], style: Styles.smallLinesBold.copyWith(color: Styles.midleDarkGrey)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      widget.appUser.goalName = UsedObjects.goalObjects[index]['titel'];
      // Goal goalWithNewPhase = UsedObjects.shawanGoal;
      // goalWithNewPhase.trainingsProgramms[0].phases[0] = DateFormat('yyyy-MM-dd').format(phase1Start);
      // goalWithNewPhase.trainingsProgramms[0].phases[1] = DateFormat('yyyy-MM-dd').format(phase2Start);
      // goalWithNewPhase.trainingsProgramms[0].phases[2] = DateFormat('yyyy-MM-dd').format(phase3Start);
      // goalWithNewPhase.trainingsProgramms[0].phases[3] = DateFormat('yyyy-MM-dd').format(goalEnding);
      // widget.goalUpdater(goalWithNewPhase.goalToJson());
    });
  }
}
