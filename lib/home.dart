import 'package:flutter/material.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/plans.dart';
import 'package:higym/services/database.dart';
import 'package:higym/start_screens/start_screen.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/training_screens/trainings_plan_screen.dart';
import 'package:higym/zzzPlaceholder/random_screen_one.dart';
import 'package:higym/zzzPlaceholder/random_screen_two.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItem = 0;
  final _pages = [
    const TrainingsPlanScreen(),
    const StartScreen(),
    const RandomScreenOne(),
    const RandomScreenTwo(),
  ];
  final _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      _pageController.animateToPage(_selectedItem,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return MultiProvider(
       providers: [
        StreamProvider<List<Exercises>>.value(
          value: DatabaseService().exerciseDatabase, initialData: const [],
        ),
        StreamProvider<List<Plans>>.value(
          value: DatabaseService(uid: user?.uid, collectionPlansOrDonePlans: 'UserExercisePlans').allPlans, initialData: const [],
        ),
        StreamProvider<List<Map<DateTime, List<Plans>>>>.value(
          value: DatabaseService(uid: user?.uid, collectionPlansOrDonePlans: 'FinishedExercises').donePlans, initialData: const [],
        ),
      ],
      child: Scaffold(
        
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.orangeAccent,
        //   //Floating action button on Scaffold
        //   onPressed: () {
        //     //code to execute on button press
        //   },
        //   child: const Icon(Icons.play_arrow_rounded,color: Styles.white,), //icon inside button
        // ),
    
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        bottomNavigationBar: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.white,
          elevation: 0.0,
          // shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin: 5, //notche margin between floating button and bottom appbar
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Styles.gymyGrey,
                ),
                onPressed: () {
                  developer.log('width: $width');
                  developer.log('heigth: $height');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.person_outline_rounded,
                  color: Styles.gymyGrey,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.phone_iphone_rounded,
                  color: Styles.gymyGrey,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.outlined_flag_rounded,
                  color: Styles.gymyGrey,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}




 //////////////////////////////////////////////////////ButtomNavBar original
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 0.0,
        //   backgroundColor: Styles.white,
    
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home_outlined,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.person_outline_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'Business',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.phone_iphone_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'School',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.outlined_flag_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'School',
        //     ),
        //   ],
        //   currentIndex: _selectedItem,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        // ),
        //////////////////////////////////////////////////////ButtomNavBar original
    
        ///////////////////////////////////////////////////////End Design1
        // bottomNavigationBar: BottomAppBar(
        //   elevation: 0.0,
        //   //bottom navigation bar on scaffold
        //   // color: Colors.redAccent,
        //   child: Row(
        //     //children inside bottom appbar
        //     mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: <Widget>[
        //       IconButton(
        //         icon: const Icon(
        //           Icons.home_outlined,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.person_outline_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         height: 100.0,
        //         width: 100.0,
        //         child: IconButton(
        //           icon: const Icon(
        //             Icons.play_circle_fill_rounded,
        //             color: Colors.orangeAccent,
        //             size: 80.0,
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.phone_iphone_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.outlined_flag_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //     ],
        //   ),
        // ),
        ///////////////////////////////////////////////////////End Design1