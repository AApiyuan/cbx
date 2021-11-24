import 'package:flutter/services.dart';

class NumTextInputFormatter extends TextInputFormatter {

  int last;
  double? max;

  NumTextInputFormatter({this.last = 2, this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (max != null) {
      double? num = double.tryParse(newValue.text);
      if (num != null && num > max!) {
        return oldValue;
      }
    }
    int index = newValue.text.indexOf(".");
    if (index == -1) return newValue;
    if (newValue.text.length - index - 1 > last) {
      return oldValue;
    } else {
      return newValue;
    }
  }

}