import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumNegativeInputFormatter extends TextInputFormatter {
  bool negative;
  bool decimal;

  NumNegativeInputFormatter({this.negative = false, this.decimal = false}) : super();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (negative) {
      if ((newValue.text.contains('-') && !newValue.text.startsWith('-')) || newValue.text == '--') {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    } else {
      if (newValue.text.contains('-')) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }
    if(newValue.text.startsWith(".")){
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    if (oldValue.text.contains('.') && newValue.text.endsWith(".") && newValue.text.length > oldValue.text.length) {
      //只能输入一个.
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    if (newValue.text.contains('.') && newValue.text.indexOf(".") < (newValue.text.length - 3)) {
      //只能输入两位
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    if (!decimal) {
      if (oldValue.text == '0' && newValue.text != '') {
        value = newValue.text.substring(1);
        selectionIndex = oldValue.selection.end;
      }
    } else {
      if (oldValue.text == '0' && newValue.text != '' && !newValue.text.contains('.')) {
        value = newValue.text.substring(1);
        selectionIndex = oldValue.selection.end;
      }
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
