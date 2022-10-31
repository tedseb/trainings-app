import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/widgets/general_widgets/row_item_with_select_widget.dart';

class TalkToAiContent extends StatelessWidget {
  const TalkToAiContent({
    required this.openContent,
    Key? key,
  }) : super(key: key);

  final Function openContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
        //   child: RowItemWithSelectWidget(
        //     widgetText: 'Pain Report',
        //     onPressFunction: () {},
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: RowItemWithSelectWidget(
            widgetText: 'Name',
            onPressFunction: () => openContent(PossibleAiScreens.aiNameContent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: RowItemWithSelectWidget(
            widgetText: 'Personal Data',
            onPressFunction: () => openContent(PossibleAiScreens.aiPersonalDataContent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: RowItemWithSelectWidget(
            widgetText: 'My Goal',
            onPressFunction: ()  => openContent(PossibleAiScreens.aiGoalContent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: RowItemWithSelectWidget(
            widgetText: 'Trainings Frequenz',
           onPressFunction: ()  => openContent(PossibleAiScreens.aiFrequenzyContent),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
        //   child: RowItemWithSelectWidget(
        //     widgetText: 'Set Reminder',
        //      onPressFunction: ()  => openContent(PossibleAiScreens.aiReminderContent),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: RowItemWithSelectWidget(
            widgetText: 'Gym Equipment',
             onPressFunction: ()  => openContent(PossibleAiScreens.aiGymEquipmentContent),
          ),
        ),
      ],
    );
  }
}
