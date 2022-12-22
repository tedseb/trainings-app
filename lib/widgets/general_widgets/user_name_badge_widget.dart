import 'package:flutter/cupertino.dart';
import 'package:higym/constants/styles.dart';

class UserNameBadgeWidget extends StatelessWidget {
  const UserNameBadgeWidget({
    required this.userName,
    required this.userLvl,
    Key? key,
  }) : super(key: key);

  final String userName;
  final int userLvl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Hi ', style: Styles.headLinesBold),
                TextSpan(text: userName, style: Styles.headLinesLight),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/badges/$userLvl.png', height: 75, filterQuality: FilterQuality.none),
        ),
      ],
    );
  }
}
