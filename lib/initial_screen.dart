import 'package:flutter/material.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/services/database.dart';
import 'package:higym/start_screens/home_screen.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/exercising_screen.dart';
import 'package:higym/training_screens/trainings_plan_screen.dart';
import 'package:higym/widgets/loading_widget.dart';
import 'package:higym/widgets/navbar_icon_button_widget.dart';
import 'package:higym/zzzPlaceholder/random_screen_one.dart';
import 'package:higym/zzzPlaceholder/random_screen_two.dart';

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
    const StartScreen(),
    const RandomScreenOne(),
    const TrainingsPlanScreen(),
    const LoadingWidget(),
  ];
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.person_outline_rounded,
    Icons.phone_iphone_rounded,
    Icons.outlined_flag_rounded,
  ];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    List<Plans> myPlans = Provider.of<List<Plans>>(context);

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
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped, iconData: _icons, selectedItem: _selectedItem, index: 0),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped, iconData: _icons, selectedItem: _selectedItem, index: 1),
              IconButton(
                iconSize: 80,
                color: Styles.primaryColor,
                icon: const Icon(Icons.play_circle_rounded),
                onPressed: () async {
                  selectedPlan = myPlans.firstWhere((element) => element.name == 'ShowRoomTestPlan', orElse: () => Plans());

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExercisingScreen(selectedPlan: selectedPlan.plansToJson()),
                    ),
                  );
                },
              ),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped, iconData: _icons, selectedItem: _selectedItem, index: 2),
              NavbarIconButtonWidget(onPressedFunction: _onItemTapped, iconData: _icons, selectedItem: _selectedItem, index: 3),
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
