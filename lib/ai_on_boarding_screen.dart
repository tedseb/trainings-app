import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/authenticate/login_screen.dart';
import 'package:higym/authenticate/register_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/models/initial_models.dart';
import 'package:higym/models/used_objects.dart';
import 'package:higym/services/training_programs_database.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_progress_bar_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_additional_musclegroup_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_fitness_level_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_fitness_methods_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_frequency_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_goal_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_gym_equipment_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_name_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_personal_data_content.dart';
import 'package:higym/widgets/ai_widgets/ai_contents/ai_present_trainigs_programm_content.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';

import 'dart:developer' as dev;

import 'package:higym/widgets/general_widgets/loading_widget.dart';

class AiOnBoardingScreen extends StatefulWidget {
  const AiOnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<AiOnBoardingScreen> createState() => _AiOnBoardingScreenState();
}

class _AiOnBoardingScreenState extends State<AiOnBoardingScreen> {
  AppUser onBoardingAppUser = InitialModels.initialAppUser;
  Goal? onBoardingGoal;

  late Widget contentWidget;
  String aiText = 'Hallo ich bin Higym, dein smarter Coach!';
  int onboardingScreen = 0;

  PageController pageController = PageController();
  int currentContent = 0;

  String errorText = '';

  // AppUser appUser = InitialModels.initialAppUser;

  List<Map<String, dynamic>> aiContentScreenChain = [];

  Map<PossibleAiScreens, int> aiContentScreenNumber = {
    PossibleAiScreens.aiNameContent: 0,
    PossibleAiScreens.aiPersonalDataContent: 1,
    PossibleAiScreens.aiGoalContent: 2,
    PossibleAiScreens.aiFitnessLevelContent: 3,
    PossibleAiScreens.aiFitnessMethodsContent: -1,
    PossibleAiScreens.aiFrequenzyContent: 4,
    PossibleAiScreens.aiAdditionalMusclegroupContent: -1,
    PossibleAiScreens.aiGymEquipmentContent: 5,
    PossibleAiScreens.aiPresentTrainingsProgrammContent: 6,
  };

  @override
  void initState() {
    ///Screens

    aiContentScreenChain = [
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
      // 'aiContent': AiFitnessMethodsContent(appUser: onBoardingAppUser),
      // },
      {
        'aiText': 'Wie viele Tage die Woche und wie lange möchtest du Trainieren?',
        'aiContent': AiFrequencyContent(appUser: onBoardingAppUser),
      },
      // {
      //   'aiText': 'Welche Muskelgruppe möchtest du zusätzlich beanspruchen?',
      // 'aiContent': AiAdditionalMusclegroupContent(appUser: onBoardingAppUser),
      // },
      {
        'aiText': 'Diese Equipments solltest du parat haben!',
        // 'aiText': 'Welche Ausstattung bietet dein Fitnessstudio?',
        'aiContent': AiGymEquipmentContent(appUser: onBoardingAppUser, goalUpdater: goalUpdater),
      },
      {
        'aiText': 'Hier ist dein neues Trainings Programm, viel Erfolg!',
        'aiContent': AiPresentTrainingsProgrammContent(getNewGoal: getNewGoal),
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AiWaveWidget(),
          onboardingScreen == 0
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
                          // key: ValueKey(currentContent),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: aiContentScreenChain.length,
                          controller: pageController,
                          onPageChanged: (int index) => setState(() => currentContent = index),
                          itemBuilder: (_, index) {
                            return
                                // (index == aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] && onBoardingGoal == null)
                                //     ? const LoadingWidget()
                                //     :
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Flexible(
                                    child: SingleChildScrollView(
                                  physics: currentContent == aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]
                                      ? const NeverScrollableScrollPhysics()
                                      : null,
                                  child: aiContentScreenChain[index]['aiContent'],
                                )),
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
        child: onBoardingBottomNavBar(),
      ),
    );
  }

  void nextPage() {
    if (contentEditedChecker()) {
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
    if (currentContent == aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]) {
      setState(() => onboardingScreen = 1);
    }
    if (currentContent <= 0) {
      setState(() => onboardingScreen = 0);
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

  Widget onBoardingBottomNavBar() {
    switch (onboardingScreen) {
      case 0:
        return AiBottomSimpleBackDoneWidget(
          leftButtonText: 'Login',
          rightButtonText: 'Start',
          onPressedLeft: () => goToLogInScreen(),
          onPressedRight: () => setState(() => onboardingScreen = 1),
        );

      case 1:
        return Column(
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
        );
      case 2:
        return AiBottomSimpleBackDoneWidget(
          leftButtonText: 'Zurück',
          rightButtonText: 'Speichern',
          onPressedLeft: () => previousPage(),
          onPressedRight: () => goToRegisterScreen(),
        );

      default:
        return AiBottomSimpleBackDoneWidget(
          leftButtonText: 'Login',
          rightButtonText: 'Start',
          onPressedLeft: () => goToLogInScreen(),
          onPressedRight: () => setState(() => onboardingScreen = 1),
        );
    }
  }

  bool contentEditedChecker() {
    /// User Name
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiNameContent]) {
      if (onBoardingAppUser.name == null) {
        setState(() {
          errorText = 'Bitte Namen einfügen';
        });

        return false;
      }
      setState(() {
        errorText = '';
      });
      return true;
    }

    /// User Data
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiPersonalDataContent]) {
      if (onBoardingAppUser.age == null || onBoardingAppUser.size == null || onBoardingAppUser.weigth == null || onBoardingAppUser.gender == null) {
        setState(() {
          errorText = 'Bitte Alle Felder Befüllen';
        });
        return false;
      }
      setState(() {
        errorText = '';
      });
      return true;
    }

    /// User Goal
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiGoalContent]) {
      if (onBoardingAppUser.goalName == null) {
        setState(() {
          errorText = 'Bitte Goal auswählen';
        });
        return false;
      }
      setState(() {
        errorText = '';
      });
      return true;
    }

    /// User Fitness Level - Add or remove FitnessMethod Screen
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiFitnessLevelContent]) {
      if (onBoardingAppUser.fitnessLevel! > 1 && aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent] == -1) {
        setState(() {
          aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent] = aiContentScreenNumber[PossibleAiScreens.aiFitnessLevelContent]! + 1;
          aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent] = aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent]! + 1;
          aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] = aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent]! + 1;
          aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent] =
              aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]! + 1;
          aiContentScreenChain.insert(
            aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent]!,
            {
              'aiText': 'Welche Fitnessmethode bevorzugst du eher?',
              'aiContent': AiFitnessMethodsContent(appUser: onBoardingAppUser),
            },
          );
        });
        setState(() {
          errorText = '';
        });
        return true;
      }
      if (onBoardingAppUser.fitnessLevel! < 2 && aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent] != -1) {
        setState(() {
          aiContentScreenChain.removeAt(aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent]!);

          aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent] = -1;
          aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent] = aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent]! - 1;
          aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] = aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent]! - 1;
          aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent] =
              aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]! - 1;
        });
      }
      setState(() {
        errorText = '';
      });
      return true;
    }

    /// User Fitness Methods
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiFitnessMethodsContent]) {
      if (onBoardingAppUser.fitnessMethod == null) {
        setState(() {
          errorText = 'Bitte Fitnessmethode auswählen';
        });
        return false;
      }

      if (onBoardingAppUser.fitnessMethod == 'Cardio') {
        onBoardingAppUser.fitnessLevel = 0;
        // setState(() => onBoardingAppUser.fitnessLevel = 0);
      }
      setState(() => errorText = '');
      return true;
    }

    /// User Fitness Frequenzy - Add or remove Musclegroup Screen
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent]) {
      if (onBoardingAppUser.dayFrequenz == null || onBoardingAppUser.minutesFrequenz == null) {
        setState(() {
          errorText = 'Bitte Alle Felder Befüllen';
        });
        return false;
      }

      if (onBoardingAppUser.fitnessLevel != 0) {
        if (((onBoardingAppUser.dayFrequenz != 1 && onBoardingAppUser.dayFrequenz != 2) ||
                (onBoardingAppUser.dayFrequenz == 2 && onBoardingAppUser.minutesFrequenz == '50-60')) &&
            aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent] == -1) {
          setState(() {
            aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent] =
                aiContentScreenNumber[PossibleAiScreens.aiFrequenzyContent]! + 1;
            aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] = aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent]! + 1;
            aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent] =
                aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]! + 1;
            aiContentScreenChain.insert(
              aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent]!,
              {
                'aiText': 'Welche Muskelgruppe möchtest du zusätzlich beanspruchen?',
                'aiContent': AiAdditionalMusclegroupContent(appUser: onBoardingAppUser),
              },
            );
          });
          setState(() {
            errorText = '';
          });
          return true;
        }
      }
      if ((onBoardingAppUser.dayFrequenz == 1 || (onBoardingAppUser.dayFrequenz == 2 && onBoardingAppUser.minutesFrequenz != '50-60')) &&
          aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent] != -1) {
        setState(() {
          aiContentScreenChain.removeAt(aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent]!);

          aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent] = -1;
          aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] = aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent]! - 1;
          aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent] =
              aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]! - 1;
        });
      }
      setState(() {
        errorText = '';
      });
      return true;
    }

    /// User Musclegroup
    // if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiAdditionalMusclegroupContent]) {}

    /// User Gym Equipment
    if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent]) {
      setState(() => onboardingScreen = 2);
      return true;
    }

    /// User Trainingsprogram
    // if (pageController.page == aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]) {}

    setState(() {
      errorText = '';
    });

    return true;
  }

  void goToLogInScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void goToRegisterScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(appUser: onBoardingAppUser, onBoardingGoal: onBoardingGoal!, backToOnBoarding: backToOnBoarding),
      ),
    );
  }

  void backToOnBoarding() {
    setState(() => onboardingScreen = 0);
  }

  void goalUpdater(Goal newGoal) {
    onBoardingGoal = newGoal;
  }

  Goal getNewGoal() {
    return onBoardingGoal!;
  }

  // void getGoal() async {
  //   String userGoalGroup = UsedObjects.goalObjects.firstWhere((goalObject) => goalObject['titel'] == onBoardingAppUser.goalName)['goalGroup'];
  //   onBoardingGoal = await TrainingProgramsDatabase(
  //     userGoalGroup: userGoalGroup,
  //     userGoal: onBoardingAppUser.goalName!,
  //     userLevel: onBoardingAppUser.fitnessLevel!,
  //     userDayFrequenz: onBoardingAppUser.dayFrequenz.toString(),
  //     userAdditionalMusclegroup: onBoardingAppUser.additionalMusclegroup!,
  //     userMinutesFrequenz: onBoardingAppUser.minutesFrequenz!,
  //   ).getNewGoal();
  //   setState(() {
  //     onBoardingGoal;
  //   });
  //   dev.log(onBoardingGoal!.trainingsProgramms[0].plans[0].name);
  //   // onBoardingGoal = Goal.goalFromJson(newGoal);
  // }
}
