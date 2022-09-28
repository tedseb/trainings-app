import 'package:flutter/material.dart';
import 'package:higym/achievements/achievements.dart';
import 'package:higym/home/home_screen.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/zzz_deleteable/plans.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/profile/profile_screen.dart';
import 'package:higym/widgets/screen_widgets/expanded_example.dart';
import 'package:higym/widgets/screen_widgets/goals_screen.dart';
import 'package:higym/services/downloader.dart';
import 'package:higym/training_screens/exercising_screen.dart';
import 'package:higym/training_screens/trainings_programm_screen.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';

import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late Plans selectedPlan;

  int _selectedItem = 0;
  final _pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const TrainingsProgrammScreen(),
    const ExpandExample(),
    // const GoalsScreen(),
    // const Achievement(),
  ];
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.person_outline_rounded,
    Icons.phone_iphone_rounded,
    Icons.outlined_flag_rounded,
  ];
  final Map<String, IconData> menuAndIcon = {
    'Home': Icons.home_outlined,
    'Profile': Icons.person_outline_rounded,
    'Plans': Icons.phone_iphone_rounded,
    'Status': Icons.widgets_rounded,
  };
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Goal goal = Provider.of<Goal>(context);
    AppUser appUser = Provider.of<AppUser>(context);
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
              NavbarIconButtonWidget(
                  onPressedFunction: _onItemTapped, menuAndIcon: menuAndIcon, iconData: _icons, selectedItem: _selectedItem, index: 0),
              NavbarIconButtonWidget(
                  onPressedFunction: _onItemTapped, menuAndIcon: menuAndIcon, iconData: _icons, selectedItem: _selectedItem, index: 1),
              IconButton(
                iconSize: 80,
                color: Styles.primaryColor,
                icon: const Icon(Icons.play_circle_rounded),
                onPressed: () async {
                  // selectedPlan = goal.trainingsProgramms[0].plans[0];

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExercisingScreen(trainingsProgramm: goal.trainingsProgramms[0].trainingsProgrammsToJson(), appUser: appUser),
                    ),
                  );
                },
              ),
              NavbarIconButtonWidget(
                  onPressedFunction: _onItemTapped, menuAndIcon: menuAndIcon, iconData: _icons, selectedItem: _selectedItem, index: 2),
              NavbarIconButtonWidget(
                  onPressedFunction: _onItemTapped, menuAndIcon: menuAndIcon, iconData: _icons, selectedItem: _selectedItem, index: 3),
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
