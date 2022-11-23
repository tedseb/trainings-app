import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';

class TextFieldUserModifierWidget extends StatefulWidget {
  const TextFieldUserModifierWidget({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.changeVal,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hintText;
  final Function changeVal;

  @override
  State<TextFieldUserModifierWidget> createState() => _TextFieldUserModifierWidgetState();
}

class _TextFieldUserModifierWidgetState extends State<TextFieldUserModifierWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: Styles.normalText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Styles.subLine,
        hintText: widget.hintText,
        hintStyle: Styles.smalText,
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.darkGrey, width: 2.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
        ),
      ),
      keyboardType: TextInputType.name,
      onChanged: (val) => widget.changeVal(val),
    );
  }
}
