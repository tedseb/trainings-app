import 'package:flutter/material.dart';
import 'package:higym/adjustment/adjustment_screen.dart';
import 'package:higym/body/body_screen.dart';
import 'package:higym/home/home_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';
import 'package:higym/training_screens/exercising_screen.dart';
import 'package:higym/training_screens/trainings_programm_screen.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';
import 'package:higym/widgets/screen_widgets/talk_to_ai_screen.dart';

import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late Goal goal;
  late AppUser appUser;

  int _selectedItem = 0;
  final _pages = [
    const HomeScreen(),
    const TrainingsProgrammScreen(),
    const BodyScreen(),
    const AdjustmentScreen(),
  ];

  final List<Map<String, dynamic>> _icons = ValueConstants.navBarIcons;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    goal = Provider.of<Goal>(context);
    appUser = Provider.of<AppUser>(context);
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
                color: Styles.white,
                offset: Offset(0, -15),
                blurRadius: 15,
                spreadRadius: 10,
              ),
              // BoxShadow(
              //   color: Colors.white,
              //   offset: Offset(0, -15),
              //   blurRadius: 15,
              //   spreadRadius: 10,
              // ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              NavbarIconButtonWidget(
                onPressedFunction: () => _onItemTapped(0),
                iconText: _icons[0]['text'],
                iconData: _icons[0]['icon'],
                selectedItem: _selectedItem,
                index: 0,
              ),
              NavbarIconButtonWidget(
                  onPressedFunction: () => _onItemTapped(1),
                  iconText: _icons[1]['text'],
                  iconData: _icons[1]['icon'],
                  selectedItem: _selectedItem,
                  index: 1),
              IconButton(
                iconSize: 80,
                color: Styles.primaryColor,
                icon: const Icon(Icons.play_circle_rounded),
                onPressed: () => newGoalNeeded(),
              ),
              NavbarIconButtonWidget(
                  onPressedFunction: () => _onItemTapped(2),
                  iconText: _icons[2]['text'],
                  iconData: _icons[2]['icon'],
                  selectedItem: _selectedItem,
                  index: 2),
              NavbarIconButtonWidget(
                onPressedFunction: () => _onItemTapped(3),
                iconText: _icons[3]['text'],
                iconData: _icons[3]['icon'],
                selectedItem: _selectedItem,
                index: 3,
              ),
              const Spacer(),
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

  void newGoalNeeded() {
    DateTime now = DateTime.now();
    DateTime endPahse = DateTime.parse(goal.trainingsProgramms[0].phases.last);

    if (now.isBefore(endPahse)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExercisingScreen(trainingsProgramm: goal.trainingsProgramms[0].trainingsProgrammsToJson(), appUser: appUser),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
          child: Container(
            padding: const EdgeInsets.all(0.0),
            height: 330,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'You have reached your goal! You need a new one!',
                          style: Styles.subLinesBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ShadowButtonWidget(
                    buttonText: 'Okay',
                    buttonWidth: 120.0,
                    onPressFunction: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TalkToAiScreen(appUser: appUser.appUserToJson(), goal: goal.goalToJson(), startingPage: 3),
                        ),
                      );
                    },
                    loggerText: 'First Repetitons',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
