import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

class ShadowCardWidget extends StatelessWidget {
  const ShadowCardWidget({
    required this.cardChild,
    Key? key,
  }) : super(key: key);

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        decoration: BoxDecoration(
          color: Styles.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            ///bottom right
            // BoxShadow(
            //   color: Colors.grey.shade900,
            //   offset: const Offset(4, 4),
            //   blurRadius: 10,
            //   spreadRadius: 4,
            // ),
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: cardChild,
      ),
    );
  }
}
