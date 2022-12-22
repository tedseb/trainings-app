import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';

class ClickableShadowCardWidget extends StatelessWidget {
  const ClickableShadowCardWidget({
    required this.title,
    required this.subTitle,
    required this.index,
    required this.selectedItem,
    required this.oncardTapped,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final int index;
  final int selectedItem;
  final Function oncardTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      child: InkWell(
        onTap: () => oncardTapped(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                onPressedFunction: () => oncardTapped(index),
                iconData: ValueConstants.goalObjects[index]['icon'],
                selectedItem: selectedItem,
                index: index,
                borderHeigth: 4.0,
                borderWidth: 30.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Styles.subLinesBold),
                    Text(subTitle, style: Styles.smallLinesBold.copyWith(color: Styles.midleDarkGrey)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
