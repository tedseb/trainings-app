import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    this.suffixIcon,
    required this.textInputType,
    this.obscureText = false,
    required this.validator,
    Key? key,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final Widget? suffixIcon; 
  final TextInputType textInputType;
  final bool obscureText;
  final Function validator;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      style: Styles.normalLinesLight,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: Styles.subLinesBold,
        hintText: widget.hintText,
        hintStyle: Styles.smallLinesBold,
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.darkGrey, width: 2.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.error, width: 2.0),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
        ),
        errorMaxLines: 2,
        suffixIcon: widget.suffixIcon
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      validator: (value) => widget.validator(value),
    );
  }
}
