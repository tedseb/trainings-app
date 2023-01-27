import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/services/activity_calculator.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';

class GceqAnswerButtonsWidget extends StatefulWidget {
  const GceqAnswerButtonsWidget({
    // required this.goalUpdater,
    required this.onPressedFunction,
    Key? key,
  }) : super(key: key);

  // final Function goalUpdater;
  final Function onPressedFunction;

  @override
  State<GceqAnswerButtonsWidget> createState() => _GceqAnswerButtonsWidgetState();
}

class _GceqAnswerButtonsWidgetState extends State<GceqAnswerButtonsWidget> {
  int _selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ValueConstants.gceqAnswer.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(width: 8.0),
              InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () => _onItemTapped(index),
                child: Container(
                   height: 50.0,
                    width: 40.0,
                  decoration: BoxDecoration(
                    color: Styles.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      ///bottom right
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(3, 3),
                        blurRadius: 3,
                      ),

                      ///top left
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(-3, -3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((index+1).toString(), style: Styles.subLinesBold),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(
                          top: index == _selectedItem ? 1.0 : 0,
                          right: 8.0,
                          left: 8.0,
                        ),
                        width: 20.0,
                        height:  index == _selectedItem ? 3.0 : 0,
                        decoration: BoxDecoration(
                          color: Styles.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
            ],
          );
        });
  }

  void _onItemTapped(int index) {
    widget.onPressedFunction(index);
    setState(() {
      _selectedItem = index;
    });
  }
}
