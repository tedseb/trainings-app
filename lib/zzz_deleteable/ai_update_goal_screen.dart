// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class AiUpdateGoalScreen extends StatefulWidget {
//   const AiUpdateGoalScreen({Key? key}) : super(key: key);

//   @override
//   State<AiUpdateGoalScreen> createState() => _AiUpdateGoalScreenState();
// }

// class _AiUpdateGoalScreenState extends State<AiUpdateGoalScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//                         child: PageView.builder(
//                           // key: ValueKey(currentContent),
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: aiContentScreenChain.length,
//                           controller: pageController,
//                           onPageChanged: (int index) => setState(() => currentContent = index),
//                           itemBuilder: (_, index) {
//                             return
//                                 // (index == aiContentScreenNumber[PossibleAiScreens.aiGymEquipmentContent] && onBoardingGoal == null)
//                                 //     ? const LoadingWidget()
//                                 //     :
//                                 Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // const Spacer(),
//                                 Flexible(
//                                     child: SingleChildScrollView(
//                                   physics: currentContent == aiContentScreenNumber[PossibleAiScreens.aiPresentTrainingsProgrammContent]
//                                       ? const NeverScrollableScrollPhysics()
//                                       : null,
//                                   child: aiContentScreenChain[index]['aiContent'],
//                                 )),
//                                 // const Spacer(),
//                               ],
//                             );
//                           },
//                         ),
//                       );
//   }
// }