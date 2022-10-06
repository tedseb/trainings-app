import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/authenticate/login_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_progress_bar_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_frequency_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_goal_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_name_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_personal_data_content.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';

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
  int currentPage = 0;

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
    // {
    //   'aiText': 'Wie fit bist du?',
    //   'aiContent': AiNameContent(appUser: appUser),
    // },
    // {
    //   'aiText': 'Welche Fitnessmethoden bevorzugst du eher?',
    //   'aiContent': AiNameContent(appUser: appUser),
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
          onboardingScreen ? const Spacer() : const SizedBox(),
          onboardingScreen
              ? const AiTextWidget(
                  aiText: 'Hallo ich bin Higym, dein smarter Coach!',
                  key: ValueKey('Hallo ich bin Higym, dein smarter Coach!'),
                )
              : AiTextWidget(
                  aiText: aiContentScreenChain[currentPage]['aiText'],
                  key: ValueKey(aiContentScreenChain[currentPage]['aiText']),
                ),
          onboardingScreen ? const Spacer() : const SizedBox(),
          onboardingScreen
              ? const SizedBox()
              : Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: aiContentScreenChain.length,
                    controller: pageController,
                    // onPageChanged: (int index) => setState(() => selectedPage = index),
                    itemBuilder: (_, index) {
                      return aiContentScreenChain[index]['aiContent'];
                    },
                  ),
                ),
          // const Spacer(),
        ],
      ),
      bottomNavigationBar: onboardingScreen
          ? AiBottomSimpleBackDoneWidget(
              leftButtonText: 'Login',
              rightButtonText: 'Start',
              onPressedLeft: () => goToLogInScreen(),
              onPressedRight: () => startOnBoarding(),
            )
          // : const SizedBox(),
          : AiBottomProgressBarWidget(
              pagesLength: aiContentScreenChain.length,
              currentPage: currentPage,
              onPressedLeft: () => previousPage(),
              onPressedRight: () => nextPage(),
            ),
    );
  }

  void nextPage() {
    if (currentPage++ < aiContentScreenChain.length - 1) {
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

  void previousPage() {
    setState(() {
      if (currentPage-- < 0) {
        onboardingScreen = true;
      } else {
        pageController.previousPage(
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linear,
        );
      }
    });
  }

  void startOnBoarding() {
    setState(() {
      onboardingScreen = false;
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
