import 'package:flutter/cupertino.dart';
import 'package:higym/constants/styles.dart';

class ExercisingSetInformationWidget extends StatelessWidget {
  const ExercisingSetInformationWidget({
    required this.value,
    required this.siUnits,
    Key? key,
  }) : super(key: key);

  final String value;
  final String siUnits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: Styles.subLinesBold.copyWith(color: Styles.exercisingWhite),
          ),
          Text(
            siUnits,
            style: Styles.subLinesLight.copyWith(color: Styles.exercisingWhite),
          ),
        ],
      ),
    );
  }
}
