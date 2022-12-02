import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/ai_widgets/ai_bottom_simple_back_done_widget.dart';

class AiVerticalPickerWidget extends StatefulWidget {
  const AiVerticalPickerWidget({
    required this.dialogName,
    required this.valueUnit,
    required this.pickerList,
    required this.valueUpdater,
    required this.initValue,
    Key? key,
  }) : super(key: key);

  final String dialogName;
  final String valueUnit;
  final List pickerList;
  final Function valueUpdater;
  final dynamic initValue;

  @override
  State<AiVerticalPickerWidget> createState() => _AiVerticalPickerWidgetState();
}

class _AiVerticalPickerWidgetState extends State<AiVerticalPickerWidget> {
  late int _index;

  late PageController valueController;

  @override
  void initState() {
    int initPage = widget.pickerList.indexWhere((element) => element.toString() == widget.initValue);
    initPage = initPage != -1 ? initPage : (widget.pickerList.length ~/ 2) ~/ 2;
    _index = initPage;
    valueController = PageController(viewportFraction: 0.3, initialPage: initPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: 490,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 60.0, 32.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.dialogName,
                    style: Styles.subLinesBold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.valueUnit, style: Styles.smallLinesBold),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      width: 80.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2.0, color: Styles.darkGrey),
                          bottom: BorderSide(width: 2.0, color: Styles.darkGrey),
                        ),
                      ),
                    ),
                    PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.pickerList.length,
                      controller: valueController,
                      // physics: const CustomPageViewScrollPhysics(),
                      onPageChanged: (int index) => setState(() => _index = index),
                      itemBuilder: (_, i) {
                        return Center(
                          child: Text(
                            widget.pickerList[i].toString(),
                            style: Styles.headLinesBold.copyWith(color: i == _index ? Styles.darkGrey : Styles.lightGrey),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            AiBottomSimpleBackDoneWidget(
              leftButtonText: 'Back',
              rightButtonText: 'Confirm',
              onPressedLeft: () => Navigator.pop(context),
              onPressedRight: () => updateAndClose(),
            )
          ],
        ),
      ),
    );
  }

  void updateAndClose() {
    widget.valueUpdater(widget.pickerList[_index]);
    Navigator.pop(context);
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 150,
        stiffness: 100,
        damping: 1,
      );
}


//  Container(
//                                     margin: const EdgeInsets.only(bottom: 4),
//                                     width: 64.0,
//                                     height: 2,
//                                     decoration: BoxDecoration(
//                                       color: Styles.grey,
//                                       borderRadius: BorderRadius.circular(50),
//                                     ),
//                                   ),

// Transform.scale(
//                       scale: i == _index ? 1 : 0.7,
//                       child: Center(
//                         child: Text(
//                           widget.pickerList[i].toString(),
//                           style: TextStyle(fontSize: 32),
//                         ),
//                       ),
//                     );

// PageView.builder(
          
//           // physics: const  CustomPageViewScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           itemCount: 100,
//           controller: PageController(viewportFraction: 0.1),
//           onPageChanged: (int index) => setState(() => _index = index),
//           itemBuilder: (_, i) {
//             return Transform.scale(
//               scale: i == _index ? 1 : 0.7,
//               child: Center(
//                 child: Text(
//                   i.toString(),
//                   style: TextStyle(fontSize: 32),
//                 ),
//               ),
//             );
//           },
//         ),