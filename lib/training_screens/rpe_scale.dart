import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RPEScale extends StatelessWidget {
  const RPEScale({
    Key? key,
    required this.rpeScaleUpdater,
    required this.exerciseIndex,
    required this.exeScore,
  }) : super(key: key);

  final Function rpeScaleUpdater;
  final int exerciseIndex;
  final int exeScore;

  final Color modeColor = Styles.pastelYellow;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: modeColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'How Hard was your Exercise?',
                    style: Styles.headLinesLight.copyWith(color: Styles.exercisingWhite),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(1, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.white,
                  onPrimary: Styles.white,
                  elevation: 0.0,
                ),
                child: Text(
                  'easy',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(2, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.white,
                  onPrimary: Styles.white,
                  elevation: 0.0,
                ),
                child: Text(
                  'okay',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  rpeScaleUpdater(3, exerciseIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(28.0),
                  primary: Styles.white,
                  onPrimary: Styles.white,
                  elevation: 0.0,
                ),
                child: Text(
                  'hard',
                  style: Styles.subLinesBold.copyWith(color: modeColor),
                ),
              ),
              // Column(
              //   children: [
              //     const Icon(
              //       Icons.keyboard_arrow_up_rounded,
              //       color: Styles.white,
              //       size: 52.0,
              //     ),
              //     Text(
              //       'Score $exeScore%',
              //       style: Styles.title,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


   // Padding(
              //   padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              //   child: Container(
              //      width: double.infinity,
              //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              //     decoration: BoxDecoration(
              //       color: Styles.white,
              //       borderRadius: BorderRadius.circular(12.0),
              //       boxShadow: const [
              //         ///bottom right
              //         BoxShadow(
              //           color: Color(0xFF9B7E40),
              //           offset: Offset(3, 3),
              //           blurRadius: 9,
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         Text(
              //           'Mehrere Wiederholungen möglich gewesen',
              //           style: Styles.rpeText,
              //           textAlign: TextAlign.center,
              //         ),
              //         const SizedBox(height: 10.0),
              //         ShadowButtonWidget(
              //           buttonText: 'Zu Einfach',
              //           buttonWidth: 120.0,
              //           onPressFunction: () async {
              //             rpeScaleUpdater(0, exerciseIndex);
              //             Navigator.pop(context);
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              //   child: Container(
              //      width: double.infinity,
              //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              //     decoration: BoxDecoration(
              //       color: Styles.white,
              //       borderRadius: BorderRadius.circular(12.0),
              //       boxShadow: const [
              //         ///bottom right
              //         BoxShadow(
              //           color: Color(0xFF9B7E40),
              //           offset: Offset(3, 3),
              //           blurRadius: 9,
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         Text(
              //           'Eine Wiederholung möglich gewesen',
              //           style: Styles.rpeText,
              //           textAlign: TextAlign.center,
              //         ),
              //         const SizedBox(height: 10.0),
              //         ShadowButtonWidget(
              //           buttonText: 'Einfach',
              //           buttonWidth: 120.0,
              //           onPressFunction: () async {
              //             rpeScaleUpdater(0, exerciseIndex);
              //             Navigator.pop(context);
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              //   child: Container(
              //      width: double.infinity,
              //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              //     decoration: BoxDecoration(
              //       color: Styles.white,
              //       borderRadius: BorderRadius.circular(12.0),
              //       boxShadow: const [
              //         ///bottom right
              //         BoxShadow(
              //           color: Color(0xFF9B7E40),
              //           offset: Offset(3, 3),
              //           blurRadius: 9,
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         Text(
              //           'Moderate bis Starke Anstrengung',
              //           style: Styles.rpeText,
              //           textAlign: TextAlign.center,
              //         ),
              //         const SizedBox(height: 10.0),
              //         ShadowButtonWidget(
              //           buttonText: 'Optimal',
              //           buttonWidth: 120.0,
              //           onPressFunction: () async {
              //             rpeScaleUpdater(0, exerciseIndex);
              //             Navigator.pop(context);
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              //     decoration: BoxDecoration(
              //       color: Styles.white,
              //       borderRadius: BorderRadius.circular(12.0),
              //       boxShadow: const [
              //         ///bottom right
              //         BoxShadow(
              //           color: Color(0xFF9B7E40),
              //           offset: Offset(3, 3),
              //           blurRadius: 9,
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         Text(
              //           'Wiederholungen nicht geschafft',
              //           style: Styles.rpeText,
              //           textAlign: TextAlign.center,
              //         ),
              //         const SizedBox(height: 10.0),
              //         ShadowButtonWidget(
              //           buttonText: 'Zu Hart',
              //           buttonWidth: 120.0,
              //           onPressFunction: () async {
              //             rpeScaleUpdater(0, exerciseIndex);
              //             Navigator.pop(context);
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),




// ElevatedButton(
//                 onPressed: () async {
//                   rpeScaleUpdater(1, exerciseIndex);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(28.0),
//                   primary: Styles.white,
//                   onPrimary: Styles.white,
//                   elevation: 0.0,
//                 ),
//                 child: Text(
//                   'easy',
//                   style: TextStyle(
//                     color: modeColor,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 28,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   rpeScaleUpdater(2, exerciseIndex);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(28.0),
//                   primary: Styles.white,
//                   onPrimary: Styles.white,
//                   elevation: 0.0,
//                 ),
//                 child: Text(
//                   'okay',
//                   style: TextStyle(
//                     color: modeColor,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 28,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   rpeScaleUpdater(3, exerciseIndex);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: const CircleBorder(),
//                   padding: const EdgeInsets.all(28.0),
//                   primary: Styles.white,
//                   onPrimary: Styles.white,
//                   elevation: 0.0,
//                 ),
//                 child: Text(
//                   'hard',
//                   style: TextStyle(
//                     color: modeColor,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 28,
//                   ),
//                 ),
//               ),