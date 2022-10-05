import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
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
                        backgroundColor: Styles.hiGymText,
                        child: Icon(leadingIcon, color: Styles.white),
                      ),
                      const SizedBox(width: 32.0),
                    ],
                  )
                : const SizedBox(),
            Text(widgetText, style: Styles.profileItemText),
          ],
        ),
        ShadowIconButtonWidget(
          buttonIcon: Icons.chevron_right_rounded,
          onPressFunction: () => onPressFunction(),
          loggerText: widgetText,
        ),
      ],
    );
  }
}
