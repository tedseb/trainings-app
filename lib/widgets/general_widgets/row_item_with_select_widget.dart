import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/gymion_icons_1_0_icons.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class RowItemWithSelectWidget extends StatelessWidget {
  const RowItemWithSelectWidget({
    Key? key,
    this.leadingIcon,
    required this.widgetText,
    required this.onPressFunction,
  }) : super(key: key);

  final IconData? leadingIcon;
  final String widgetText;
  final Function onPressFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leadingIcon != null
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Styles.darkGrey,
                        child: Icon(leadingIcon, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                    ],
                  )
                : const SizedBox(),
            Text(widgetText, style: Styles.normalText),
          ],
        ),
        ShadowIconButtonWidget(
          buttonIcon: GymionIcons_1_0.pfeil,
          onPressFunction: () => onPressFunction(),
          loggerText: widgetText,
        ),
      ],
    );
  }
}
