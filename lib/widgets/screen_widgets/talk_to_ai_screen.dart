import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_frequency_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_goal_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_gym_equipment_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_name_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_personal_data_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_reminder_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/talk_to_ai_content.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';

import 'dart:developer' as dev;

class TalkToAiScreen extends StatefulWidget {
  const TalkToAiScreen({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<TalkToAiScreen> createState() => _TalkToAiScreenState();
}

class _TalkToAiScreenState extends State<TalkToAiScreen> {
  // PossibleAiScreens aiContent = PossibleAiScreens.talkToAiContent;
  // String aiText = 'Worauf willst du mich genauer einstimmen Nico?';

  late Widget contentWidget;
  late String aiText;
  PossibleAiScreens aiContent = PossibleAiScreens.talkToAiContent;

  bool bottomNavigationBarVisibility = false;

  List<Map<String, bool>> gymEquipment = [
    {'Langhantel': true},
    {'Kabelzug': true},
    {'Schrägbank': true},
    {'Kurzhantel': true},
    {'T-Seil': true},
    {'Flachbank': true},
    {'Turm': true},
    {'SZ-Stange': true},
  ];

  @override
  void initState() {
    setContentScreen(PossibleAiScreens.talkToAiContent);
    super.initState();
  }

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
                    color: Styles.hiGymText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const AiWaveWidget(),
          AiTextWidget(aiText: aiText, key: ValueKey(aiText)),
          Expanded(child: SingleChildScrollView(child: contentWidget)),
          aiContent != PossibleAiScreens.talkToAiContent ? const SizedBox() :const SizedBox(height: 32.0),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: aiContent != PossibleAiScreens.talkToAiContent,
        child: AiBottomSimpleBackDoneWidget(
          leftButtonText: 'Back',
          rightButtonText: 'Confirm',
          onPressedLeft: () => setContentScreen(PossibleAiScreens.talkToAiContent),
          onPressedRight: () => confirmChanges(),
        ),
      ),
    );
  }

  void setContentScreen(PossibleAiScreens possibleAiScreens) {
    setState(() {
      switch (possibleAiScreens) {
        case PossibleAiScreens.talkToAiContent:
          aiText = 'Worauf willst du mich genauer einstimmen ${widget.appUser.name}?';
          contentWidget = TalkToAiContent(openContent: setContentScreen);
          aiContent = PossibleAiScreens.talkToAiContent;

          break;
        case PossibleAiScreens.aiPersonalDataContent:
          aiText = 'Kannst du mir etwas über dich erzählen?';
          contentWidget = AiPersonalDataContent(appUser: widget.appUser);
          aiContent = PossibleAiScreens.aiPersonalDataContent;
          break;
        case PossibleAiScreens.aiNameContent:
          aiText = 'Wie heißt du?';
          contentWidget = AiNameContent(appUser: widget.appUser);
          aiContent = PossibleAiScreens.aiNameContent;
          break;
        case PossibleAiScreens.aiGoalContent:
          aiText = 'Was ist dein Ziel?';
          contentWidget = AiGoalContent(appUser: widget.appUser);
          aiContent = PossibleAiScreens.aiGoalContent;
          break;
        case PossibleAiScreens.aiFrequenzyContent:
          aiText = 'Wie viele Tage die Woche und wie lange möchtest du Trainieren?';
          contentWidget = AiFrequencyContent(appUser: widget.appUser);
          aiContent = PossibleAiScreens.aiFrequenzyContent;
          break;
        case PossibleAiScreens.aiReminderContent:
          aiText = 'Zu welchen Zeiten möchtest du an dein Training Erinnert werden?';
          contentWidget = AiReminderContent(appUser: widget.appUser);
          aiContent = PossibleAiScreens.aiReminderContent;
          break;
        case PossibleAiScreens.aiGymEquipmentContent:
          aiText = 'Zu welchen Zeiten möchtest du an dein Training Erinnert werden?';
          contentWidget = AiGymEquipmentContent(gymEquipment: gymEquipment);
          aiContent = PossibleAiScreens.aiGymEquipmentContent;
          break;
        default:
          aiText = 'Worauf willst du mich genauer einstimmen ${widget.appUser.name}?';
          contentWidget = TalkToAiContent(openContent: setContentScreen);
          aiContent = PossibleAiScreens.talkToAiContent;
          break;
      }
    });
  }

  void confirmChanges() {
    switch (aiContent) {
      case PossibleAiScreens.aiPersonalDataContent:
        DatabaseService(uid: widget.appUser.uid).updateUserData(widget.appUser);
        break;
      case PossibleAiScreens.aiNameContent:
        DatabaseService(uid: widget.appUser.uid).updateUserName(widget.appUser);
        break;
      case PossibleAiScreens.aiGoalContent:
        DatabaseService(uid: widget.appUser.uid).updateUserGoal(widget.appUser);
        break;
      case PossibleAiScreens.aiFrequenzyContent:
        DatabaseService(uid: widget.appUser.uid).updateUserFrequenz(widget.appUser);
        break;
      default:
        dev.log('Error no Content choosed');
        break;
    }

    setContentScreen(PossibleAiScreens.talkToAiContent);
  }
}
