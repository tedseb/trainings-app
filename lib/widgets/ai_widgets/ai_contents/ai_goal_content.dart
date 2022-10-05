import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/used_objects.dart' as used_objects;
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';

class AiGoalContent extends StatefulWidget {
  const AiGoalContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiGoalContent> createState() => _AiGoalContentState();
}

class _AiGoalContentState extends State<AiGoalContent> {
  int _selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
        itemCount: used_objects.goalObjects.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: Container(
              key: ValueKey(index) ,
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
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
              child: Row(
                children: [
                  NavbarIconButtonWidget(
                    key: ValueKey(index+10),
                    onPressedFunction: () => _onItemTapped(3),
                    iconData: used_objects.goalObjects[index]['icon'],
                    selectedItem: _selectedItem,
                    index: index,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }
}
