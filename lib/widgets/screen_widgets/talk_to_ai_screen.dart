import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_progress_bar_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_additional_musclegroup_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_frequency_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_goal_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_gym_equipment_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_name_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_personal_data_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_present_trainigs_programm_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_reminder_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/talk_to_ai_content.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';

import 'dart:developer' as dev;

class TalkToAiScreen extends StatefulWidget {
  const TalkToAiScreen({
    required this.appUser,
    required this.goal,
    this.startingPage = 0,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> appUser;
  final Map<String, dynamic> goal;
  final int startingPage;

  @override
  State<TalkToAiScreen> createState() => _TalkToAiScreenState();
}

class _TalkToAiScreenState extends State<TalkToAiScreen> {
  late AppUser appUser;
  late Goal myGoal;

  late PageController pageController;
  int pageViewIndex = 0;

  bool talkToAiContentScreen = true;

  List<Map<String, dynamic>> aiContentScreenChain = [];
  int notPageViewContent = 3;

  @override
  void initState() {
    appUser = AppUser.appUserFromJson(widget.appUser);
    myGoal = Goal.goalFromJson(widget.goal);

    pageViewIndex = widget.startingPage;
    pageController = PageController(initialPage: pageViewIndex);

    aiContentScreenChain = [
      {
        'index': 0,
        'key': PossibleAiScreens.talkToAiContent,
        'aiText': 'Worauf willst du mich genauer einstimmen ${appUser.name}?',
        'aiContent': TalkToAiContent(openContent: setContentScreen),
      },
      {
        'index': 1,
        'key': PossibleAiScreens.aiNameContent,
        'aiText': 'Wie heißt du?',
        'aiContent': AiNameContent(appUser: appUser),
      },
      {
        'index': 2,
        'key': PossibleAiScreens.aiPersonalDataContent,
        'aiText': 'Kannst du mir etwas über dich erzählen?',
        'aiContent': AiPersonalDataContent(appUser: appUser),
      },
      {
        'index': 3,
        'key': PossibleAiScreens.aiGoalContent,
        'aiText': 'Was ist dein Ziel?',
        'aiContent': AiGoalContent(appUser: appUser),
      },
      {
        'index': 4,
        'key': PossibleAiScreens.aiFrequenzyContent,
        'aiText': 'Wie viele Tage die Woche und wie lange möchtest du Trainieren?',
        'aiContent': AiFrequencyContent(appUser: appUser),
      },
      // Following element is only to demonstrade that it is possible
      // {
      //   'index': 5,
      //   'key': PossibleAiScreens.aiAdditionalMusclegroupContent,
      //   'aiText': 'Welche Muskelgruppe möchtest du zusätzlich beanspruchen?',
      //   'aiContent': AiAdditionalMusclegroupContent(appUser: appUser),
      // },
      {
        'index': 5,
        'key': PossibleAiScreens.aiGymEquipmentContent,
        'aiText': 'Diese Equipments solltest du parat haben!',
        // 'aiText': 'Welche Ausstattung bietet dein Fitnessstudio?',
        'aiContent': AiGymEquipmentContent(appUser: appUser, goalUpdater: goalUpdater),
      },
      {
        'index': 6,
        'key': PossibleAiScreens.aiPresentTrainingsProgrammContent,
        'aiText': 'Hier ist dein neues Trainings Programm, viel Erfolg!',
        'aiContent': AiPresentTrainingsProgrammContent(getNewGoal: getNewGoal),
      },
    ];

    // setContentScreen(PossibleAiScreens.talkToAiContent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Close Talk to AI
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

          /// AI Talking Wave
          const AiWaveWidget(),

          /// AI Content PageView
          Flexible(
            child: Column(
              children: [
                AiTextWidget(
                  aiText: aiContentScreenChain[pageViewIndex]['aiText'],
                  key: ValueKey(aiContentScreenChain[pageViewIndex]['aiText']),
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: aiContentScreenChain.length,
                    onPageChanged: (int index) => setState(() => pageViewIndex = index),
                    controller: pageController,
                    itemBuilder: (_, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              physics: aiContentScreenChain[index]['key'] == PossibleAiScreens.aiPresentTrainingsProgrammContent
                                  ? const NeverScrollableScrollPhysics()
                                  : null,
                              child: aiContentScreenChain[index]['aiContent'],
                            ),
                          ),
                          // const Spacer(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
          // return ScaleTransition(scale: animation, child: child);
        },
        child: bottomNavBar(),
      ),
    );
  }

  Widget bottomNavBar() {
    if (pageViewIndex == 0) {
      return const SizedBox(height: 104.0);
    }
    if (pageViewIndex < 3) {
      return AiBottomSimpleBackDoneWidget(
        leftButtonText: 'Cancel',
        rightButtonText: 'Confirm',
        onPressedLeft: () => setContentScreen(PossibleAiScreens.talkToAiContent),
        onPressedRight: () => confirmAndUpdateNameAndPersonalDate(),
      );
    }

    if (pageViewIndex < (aiContentScreenChain.length - 1)) {
      return AiBottomProgressBarWidget(
        pagesLength: aiContentScreenChain.length - 3,
        currentPage: pageViewIndex - 3,
        onPressedLeft: () => previousPage(),
        onPressedRight: () => nextPage(),
      );
    }

    return AiBottomSimpleBackDoneWidget(
      leftButtonText: 'Back',
      rightButtonText: 'Confirm',
      onPressedLeft: () => setContentScreen(PossibleAiScreens.aiGymEquipmentContent),
      onPressedRight: () => confirmAndUpdateGoalData(),
    );
  }

  void nextPage() {
    if (checkBeforeNextPage()) {
      if (pageViewIndex < (aiContentScreenChain.length - 1)) {
        setState(() {
          pageController.nextPage(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.linear,
          );
        });
      }
    }
  }

  void previousPage() {
    if (pageViewIndex == 3) {
      setContentScreen(PossibleAiScreens.talkToAiContent);
    } else {
      setState(() {
        pageController.previousPage(
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linear,
        );
      });
    }
  }

  void setContentScreen(PossibleAiScreens possibleAiScreens) {
    setState(() {
      int newIndex = aiContentScreenChain.indexOf(aiContentScreenChain.firstWhere((element) => element['key'] == possibleAiScreens));
      pageViewIndex = newIndex;

      pageController.jumpToPage(pageViewIndex);

      // pageController.animateToPage(
      //   pageViewIndex,
      //   duration: const Duration(
      //     milliseconds: 300,
      //   ),
      //   curve: Curves.linear,
      // );
    });
    if (pageViewIndex == 0 && widget.startingPage != 0) {
      Navigator.of(context).pop();
    }
  }

  bool checkBeforeNextPage() {
    /// User Fitness Frequenzy - Add or remove Musclegroup Screen
    if (pageViewIndex == 4) {
      if (appUser.fitnessLevel != 0) {
        if (((appUser.dayFrequenz != 1 && appUser.dayFrequenz != 2) || (appUser.dayFrequenz == 2 && appUser.minutesFrequenz == '50-60')) &&
            aiContentScreenChain.firstWhere((element) => element['key'] == PossibleAiScreens.aiAdditionalMusclegroupContent,
                    orElse: () => {'index': -1})['index'] ==
                -1) {
          setState(() => aiContentScreenChain.insert(
                5,
                {
                  'index': 5,
                  'key': PossibleAiScreens.aiAdditionalMusclegroupContent,
                  'aiText': 'Welche Muskelgruppe möchtest du zusätzlich beanspruchen?',
                  'aiContent': AiAdditionalMusclegroupContent(appUser: appUser),
                },
              ));

          return true;
        }
      }
      if ((appUser.dayFrequenz == 1 || (appUser.dayFrequenz == 2 && appUser.minutesFrequenz != '50-60')) &&
          aiContentScreenChain.firstWhere((element) => element['key'] == PossibleAiScreens.aiAdditionalMusclegroupContent,
                  orElse: () => {'index': -1})['index'] !=
              -1) {
        setState(() => aiContentScreenChain.removeAt(5));
      }
      return true;
    }

    return true;
  }

  void goalUpdater(Goal newGoal) {
    myGoal = newGoal;
  }

  Goal getNewGoal() {
    return myGoal;
  }

  void confirmAndUpdateNameAndPersonalDate() {
    DatabaseService(uid: appUser.uid).updateUserNameAndPersonalData(appUser);
    setContentScreen(PossibleAiScreens.talkToAiContent);
  }

  void confirmAndUpdateGoalData() {
    DatabaseService(uid: appUser.uid).updateUserStartingNewGoalData(appUser);
    DatabaseService(uid: appUser.uid).addGoal(myGoal);
    setContentScreen(PossibleAiScreens.talkToAiContent);
  }
}
