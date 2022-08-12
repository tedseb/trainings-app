import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class ShadowIconButtonWidget extends StatelessWidget {
  const ShadowIconButtonWidget({Key? key, required this.buttonInput, required this.onPressFunction}) : super(key: key);

  final String buttonInput;
  final Function onPressFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
   
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      onTap: () => onPressFunction,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12.0), boxShadow: [
          ///bottom right
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(3, 3),
            blurRadius: 3,
            // spreadRadius: 1,
          ),
      
          ///top left
          // BoxShadow(
          //   color: Colors.grey.shade100,
          //   offset: const Offset(-3,-3),
          //   blurRadius: 5,
          //   spreadRadius: 1,
          // ),
        ]),
        child: const Icon(
          Icons.info_outline_rounded,
          color: Styles.gymyGrey,
        ),
      ),
    );
  }
}
