import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';

import 'dart:developer' as dev;

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Stack(
            children: [
              AnimatedContainer(
                height: expandedIndex == 0 ? 550 : 110,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: expandedIndex == 0
                    ? SizedBox(
                        height: 550,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 128.0, 8.0, 8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [ElevatedButton(onPressed: () {}, child: const Text('Activate'))],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              InkWell(
                onTap: () {
                  if (expandedIndex == 0) {
                    setState(() {
                      expandedIndex = -1;
                    });
                    dev.log('card 0 close');
                  } else {
                    setState(() {
                      expandedIndex = 0;
                    });
                    dev.log('card 0 open');
                  }
                },
                child: Container(
                  height: 120.0,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: const AssetImage('assets/card_background/build.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.srcOver),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'TRAINING 1',
                              'Build Muscles',
                              style: Styles.goalsCardTitle,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              width: 100.0,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width,
              //   child: InkWell(
              //     onTap: () {
              //       if (expandedIndex == 0) {
              //         setState(() {
              //           expandedIndex = -1;
              //         });
              //       } else {
              //         setState(() {
              //           expandedIndex = 0;
              //         });
              //       }
              //       dev.log('card 0 tapped');
              //     },
              //     child: Card(
              //       // semanticContainer: true,
              //       clipBehavior: Clip.antiAliasWithSaveLayer,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //       elevation: 5,
              //       margin: const EdgeInsets.all(10),
              //       child: FittedBox(fit: BoxFit.cover, child: Image.asset('assets/card_background/build.jpg')),
              //     ),
              //   ),
              // ),
            ],
          ),
          // Stack(
          //   children: [
          //     AnimatedContainer(
          //       height: expandedIndex == 1 ? 300 : 90,

          //       duration: const Duration(milliseconds: 500),
          //       curve: Curves.easeInOut,
          //       margin: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         color: Colors.grey[200],
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: expandedIndex == 1
          //           ? const SizedBox(
          //               height: 300,
          //               child: Center(child: Text('Das ist Card 1')),
          //             )
          //           : const SizedBox(),

          //     ),
          //     SizedBox(
          //       height: 100,
          //       width: MediaQuery.of(context).size.width,
          //       child: InkWell(
          //         onTap: () {
          //           if (expandedIndex == 1) {
          //             setState(() {
          //               expandedIndex = -1;
          //             });
          //           } else {
          //             setState(() {
          //               expandedIndex = 1;
          //             });
          //           }
          //           dev.log('card 1 tapped');
          //         },
          //         child: Card(
          //           // semanticContainer: true,
          //           clipBehavior: Clip.antiAliasWithSaveLayer,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           elevation: 5,
          //           margin: const EdgeInsets.all(10),
          //           child: FittedBox(fit: BoxFit.cover, child: Image.asset('assets/card_background/cardio.jpg')),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // Stack(
          //   children: [
          //     AnimatedContainer(
          //       height: expandedIndex == 2 ? 300 : 90,
          //       duration: const Duration(milliseconds: 500),
          //       curve: Curves.easeInOut,
          //       margin: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         color: Colors.grey[200],
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: expandedIndex == 2
          //           ? const SizedBox(
          //               height: 300,
          //               child: Center(child: Text('Das ist Card 2')),
          //             )
          //           : const SizedBox(),

          //     ),
          //     SizedBox(
          //       height: 100,
          //       width: MediaQuery.of(context).size.width,
          //       child: InkWell(
          //         onTap: () {
          //           if (expandedIndex == 2) {
          //             setState(() {
          //               expandedIndex = -1;
          //             });
          //           } else {
          //             setState(() {
          //               expandedIndex = 2;
          //             });
          //           }
          //           dev.log('card 2 tapped');
          //         },
          //         child: Card(

          //           clipBehavior: Clip.antiAliasWithSaveLayer,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           elevation: 5,
          //           margin: const EdgeInsets.all(10),
          //           child: FittedBox(fit: BoxFit.cover, child: Image.asset('assets/card_background/definition.jpg')),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
