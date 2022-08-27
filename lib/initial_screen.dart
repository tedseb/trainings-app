import 'package:flutter/material.dart';
import 'package:higym/achievements/achievements.dart';
import 'package:higym/home/home_screen.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/profile/profile_screen.dart';
import 'package:higym/services/downloader.dart';
import 'package:higym/training_screens/exercising_screen.dart';
import 'package:higym/training_screens/trainings_plan_screen.dart';
import 'package:higym/widgets/loading_widget.dart';
import 'package:higym/widgets/navbar_icon_button_widget.dart';

import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Plans selectedPlan = Plans(
    name: 'ShowRoomTestPlan',
    parameters: {'fitnessIcon': 'Endurance', 'bodyIcon': 'Full Body', 'timerIcon': 'ca. 30min'},
    exercises: [
      Exercises(
        name: 'Military Press',
        img: '',
        video: 'military_press',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 229,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Squats',
        img: '',
        video: 'squats',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 111,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Deadlifts',
        img: '',
        video: 'deadlifts',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 105,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Rudern Stehend',
        img: '',
        video: 'rudern_stehend',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 106,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
      Exercises(
        name: 'Bankdrücken',
        img: '',
        video: 'bankdruecken',
        info: '',
        muscleGroup: '',
        exePauseTime: 90,
        exePauseTimeDone: 0,
        exerciseFinished: false,
        exercisePauseFinished: false,
        pk: 102,
        rpeScale: [],
        sets: [
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
          Sets(
            repetitions: 10,
            repetitionsDone: 0,
            time: 30,
            timeDone: 0,
            weight: 0,
            weightDone: 0,
            pause: 45,
            pauseDone: 0,
            success: 0,
            setFinished: false,
            setPauseFinished: false,
          ),
        ],
      ),
    ],
    kcal: 0,
    time: 0,
    higymAutomated: true,
  );

  


  int _selectedItem = 0;
  final _pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const TrainingsPlanScreen(),
    const Achievement(),
  ];
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.person_outline_rounded,
    Icons.phone_iphone_rounded,
    Icons.outlined_flag_rounded,
  ];
  final Map<String,IconData> menuAndIcon = {
    'Home':Icons.home_outlined,
    'Profile':Icons.person_outline_rounded,
    'Plans': Icons.phone_iphone_rounded,
    'Status':Icons.outlined_flag_rounded,
  };
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AppUser?>(context);
    List<Plans> myPlans = Provider.of<List<Plans>>(context);
// Downloader.checkAndDownload( selectedPlan);
    return Scaffold(
      backgroundColor: Styles.white,
      extendBody: true,
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Styles.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(0, -15),
                blurRadius: 15,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SizedBox()),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped,menuAndIcon: menuAndIcon, iconData: _icons, selectedItem: _selectedItem, index: 0),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped,menuAndIcon: menuAndIcon,  iconData: _icons, selectedItem: _selectedItem, index: 1),
              IconButton(
                iconSize: 80,
                color: Styles.primaryColor,
                icon: const Icon(Icons.play_circle_rounded),
                onPressed: () async {
                  selectedPlan = myPlans.firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());
                  // DatabaseService(
                  //         oldPlanName: selectedPlan.name,
                  //         uid: user?.uid,
                  //         planNameOrDate: selectedPlan.name,
                  //         collectionPlansOrDonePlans: 'UserExercisePlans',
                  //         selectedPlan: selectedPlan)
                  //     .updateUserPlan();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExercisingScreen(selectedPlan: selectedPlan.plansToJson()),
                    ),
                  );
                },
              ),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped,menuAndIcon: menuAndIcon,  iconData: _icons, selectedItem: _selectedItem, index: 2),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped,menuAndIcon: menuAndIcon,  iconData: _icons, selectedItem: _selectedItem, index: 3),
              const Expanded(child: SizedBox()),
            ],
          )),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      _pageController.animateToPage(
        _selectedItem,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.linear,
      );
    });
  }
}
