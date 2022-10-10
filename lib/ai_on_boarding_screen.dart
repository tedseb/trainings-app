import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/authenticate/login_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_progress_bar_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_fitness_level_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_frequency_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_goal_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_name_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_personal_data_content.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';

import 'dart:developer' as dev;

class AiOnBoardingScreen extends StatefulWidget {
  const AiOnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<AiOnBoardingScreen> createState() => _AiOnBoardingScreenState();
}

AppUser onBoardingAppUser = InitialModels.initialAppUser;

class _AiOnBoardingScreenState extends State<AiOnBoardingScreen> {
  late Widget contentWidget;
  String aiText = 'Hallo ich bin Higym, dein smarter Coach!';
  bool onboardingScreen = true;

  PageController pageController = PageController();
  int currentContent = 0;

  String errorText = '';

  // AppUser appUser = InitialModels.initialAppUser;

  List<Map<String, dynamic>> aiContentScreenChain = [
    {
      'aiText': 'Wie heißt du?',
      'aiContent': AiNameContent(appUser: onBoardingAppUser),
    },
    {
      'aiText': 'Kannst du mir etwas über dich erzählen?',
      'aiContent': AiPersonalDataContent(appUser: onBoardingAppUser),
    },
    {
      'aiText': 'Was ist dein Ziel?',
      'aiContent': AiGoalContent(appUser: onBoardingAppUser),
    },
    {
      'aiText': 'Wie fit bist du?',
      'aiContent': AiFitnessLevelContent(appUser: onBoardingAppUser),
    },
    // {
    //   'aiText': 'Welche Fitnessmethoden bevorzugst du eher?',
    //   'aiContent': AiNameContent(appUser: onBoardingAppUser),
    // },
    {
      'aiText': 'Wie viele Tage die Woche und wie lange möchtest du Trainieren?',
      'aiContent': AiFrequencyContent(appUser: onBoardingAppUser),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AiWaveWidget(),
          onboardingScreen
              ? Flexible(
                  child: Column(
                    children: const [
                      Spacer(),
                      AiTextWidget(
                        aiText: 'Hallo ich bin Higym, dein smarter Coach!',
                        key: ValueKey('Hallo ich bin Higym, dein smarter Coach!'),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              : Flexible(
                  child: Column(
                    children: [
                      AiTextWidget(
                        aiText: aiContentScreenChain[currentContent]['aiText'],
                        key: ValueKey(aiContentScreenChain[currentContent]['aiText']),
                      ),
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: aiContentScreenChain.length,
                          controller: pageController,
                          onPageChanged: (int index) => setState(() => currentContent = index),
                          itemBuilder: (_, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                               Flexible(child: SingleChildScrollView(child: aiContentScreenChain[index]['aiContent'],)),
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
      bottomNavigationBar: onboardingScreen
          ? AiBottomSimpleBackDoneWidget(
              leftButtonText: 'Login',
              rightButtonText: 'Start',
              onPressedLeft: () => goToLogInScreen(),
              onPressedRight: () => startStopOnBoarding(),
            )
          // : const SizedBox(),
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: errorText != '',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(errorText, style: const TextStyle(color: Styles.error))],
                  ),
                ),
                AiBottomProgressBarWidget(
                  // key: ValueKey(currentContent),
                  pagesLength: aiContentScreenChain.length,
                  currentPage: currentContent,
                  onPressedLeft: () => previousPage(),
                  onPressedRight: () => nextPage(),
                ),
              ],
            ),
    );
  }

  void nextPage() {
    if (true) {
    // if (contentEditedChecker()) {
      if (currentContent < aiContentScreenChain.length - 1) {
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
    if (currentContent <= 0) {
      startStopOnBoarding();
    } else {
      setState(() {
        pageController.previousPage(
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linear,
        );
          errorText = '';
      });
    }
  }

  bool contentEditedChecker() {
    if (pageController.page == 0) {
      if (onBoardingAppUser.name == null) {
        setState(() {
          errorText = 'Bitte Namen einfügen';
        });

        return false;
      }
    }
    if (pageController.page == 1) {
      if (onBoardingAppUser.age == null || onBoardingAppUser.size == null || onBoardingAppUser.weigth == null || onBoardingAppUser.gender == null) {
        setState(() {
          errorText = 'Bitte Alle Felder Befüllen';
        });
        return false;
      } 
    }
    if (pageController.page == 2) {
      if (onBoardingAppUser.goalName == null) {
        setState(() {
          errorText = 'Bitte Goal auswählen';
        });
        return false;
      } 
    }
    if (pageController.page == 4) {
      dev.log('Day fre = ${onBoardingAppUser.dayFrequenz}');
      if (onBoardingAppUser.dayFrequenz == null || onBoardingAppUser.minutesFrequenz == null) {
        setState(() {
          errorText = 'Bitte Alle Felder Befüllen';
        });
        return false;
      } 
    }

    setState(() {
      errorText = '';
    });

    return true;
  }

  void startStopOnBoarding() {
    setState(() {
      onboardingScreen = !onboardingScreen;
    });
  }

  void goToLogInScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(toggleView: () {}),
      ),
    );
  }
}
