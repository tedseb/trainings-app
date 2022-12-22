import 'package:flutter/cupertino.dart';

class ValidationUtils {
  ValidationUtils({this.originalPasswordController});
  final TextEditingController? originalPasswordController;

  mailValidation(String? value) {
    if (value!.isEmpty || !RegExp(r'^[\w\.\-]+@[\w\-]+\.([\w\-]\.)?[a-z]{2,6}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return;
  }

  passwordValidation(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Your Password have to be at least 6 Characters!';
    }
    return;
  }

  password2Validation(String? value) {
    if (value != originalPasswordController?.text) {
      return 'Both Passwords have to match eachother!';
    }
    return;
  }

  positiveNumberCheck(String? value) {
    if (value!.isEmpty || !RegExp(r'^(\d+)$').hasMatch(value)) {
      return 'Please enter only Positiv number of repetitions';
    }
    return;
  }
  doubleNumberCheck(String? value) {
    if (value!.isEmpty || !RegExp(r'^[+-]?([0-9]\d*(\.|\,)\d*|0?(\.|\,)\d*[1-9]\d*|[1-9]\d*)$').hasMatch(value)) {
      return 'Please enter only Numbers';
    }
    return;
  }
}
