import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_progress_bar_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/gceq_answer_buttons_widget.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';
import 'package:higym/widgets/general_widgets/spelling_text_widget.dart';

class EnhanceTheAiScreen extends StatefulWidget {
  const EnhanceTheAiScreen({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<EnhanceTheAiScreen> createState() => _EnhanceTheAiScreenState();
}

class _EnhanceTheAiScreenState extends State<EnhanceTheAiScreen> {
  List<Map<String, String>> gceqList = ValueConstants.gceqList;
  int selectedAnswer = -1;

  PageController pageController = PageController();
  int pageViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Close Enhance the AI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 38.0,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Styles.darkGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),

          /// AI Content PageView
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                SpellingTextWidget(
                  spellingText: gceqList[pageViewIndex]['question']!,
                  key: ValueKey(gceqList[pageViewIndex]['question']),
                ),
                const Spacer(),
                  // const SizedBox(height: 50.0),
               (pageViewIndex < 2 || pageViewIndex == (gceqList.length - 1))
                          ? const SizedBox()
                          : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text('Nicht wichtig', style: Styles.normalLinesLight, textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('Sehr wichtig', style: Styles.normalLinesLight, textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75,
                  // width: double.infinity,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gceqList.length,
                    onPageChanged: (int index) => setState(() => pageViewIndex = index),
                    controller: pageController,
                    itemBuilder: (_, index) {
                      return (pageViewIndex < 2 || pageViewIndex == (gceqList.length - 1))
                          ? const SizedBox()
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: GceqAnswerButtonsWidget(onPressedFunction: selectAnswer),
                              ),
                            );
                      // ) : gceqAnswerScreen();
                    },
                  ),
                ),
                const Spacer(),
                // const SizedBox(height: 50.0),
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
        child: bottomNavBar(),
      ),
    );
  }

  Widget bottomNavBar() {
    if (pageViewIndex < 1) {
      return AiBottomSimpleBackDoneWidget(
        leftButtonText: 'Cancel',
        rightButtonText: 'O.K.',
        onPressedLeft: () => Navigator.of(context).pop(),
        onPressedRight: () => nextPage(),
      );
    }
    if (pageViewIndex < 2) {
      return AiBottomSimpleBackDoneWidget(
        leftButtonText: 'Back',
        rightButtonText: 'Start',
        onPressedLeft: () => previousPage(),
        onPressedRight: () => nextPage(),
      );
    }

    if (pageViewIndex < (gceqList.length - 1)) {
      return AiBottomProgressBarWidget(
        pagesLength: gceqList.length - 1,
        currentPage: pageViewIndex - 1,
        onPressedLeft: () => previousPage(),
        onPressedRight: () => nextPage(),
      );
    }

    return AiBottomSimpleBackDoneWidget(
      leftButtonText: 'Back',
      rightButtonText: 'Confirm',
      onPressedLeft: () => previousPage(),
      onPressedRight: () => confirmUpdateCloseGCEQ(),
    );
  }

  void nextPage() {
    if (pageViewIndex < (gceqList.length - 1)) {
      setState(() {
        selectedAnswer = -1;
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
    if (pageViewIndex > 0) {
      setState(() {
        selectedAnswer = -1;
        pageController.previousPage(
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.linear,
        );
      });
    }
  }

  selectAnswer(int answerIndex) {
    setState(() {
      gceqList[pageViewIndex]['answer'] = (answerIndex+1).toString();
    });
  }

  confirmUpdateCloseGCEQ() {
    setState(() {
      widget.appUser.gceq = gceqList;
      DatabaseService(uid: widget.appUser.uid).addGceqToUser(widget.appUser);
      Navigator.of(context).pop();
    });
  }


}
