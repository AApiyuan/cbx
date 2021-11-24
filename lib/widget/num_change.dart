// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';

class NumChangeWidget extends StatefulWidget {
  // final double height;
  String num = '';
  final ValueChanged<String> onValueChanged;
  final Function onEditingComplete;
  int color;
  bool negative;
  int negativeColor;
  int buttonColor;
  int buttonBack;

  NumChangeWidget(
      {Key? key,
      this.num = '',
      this.color = ColorConfig.color_1678ff,
      this.buttonColor = ColorConfig.color_dcdcdc,
      this.buttonBack = ColorConfig.color_ffffff,
      this.negative = false,
      this.negativeColor = ColorConfig.color_ff3715,
      required this.onValueChanged,
      required this.onEditingComplete})
      : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<NumChangeWidget> {
  @override
  void initState() {
    super.initState();
  }

  //页面销毁
  @override
  void dispose() {
    //释放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _minusNum,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Color(widget.buttonBack), border: Border(right: BorderSide(color: new Color(ColorConfig.color_dcdcdc), width: 1.w))),
                  width: 74.w,
                  height: 74.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    size: 36.w,
                    color: new Color(widget.buttonColor),
                  )
                  // FlatButton(
                  //     padding: EdgeInsets.zero,
                  //     focusNode: FocusNode(skipTraversal: true),
                  //     minWidth: 74.w,
                  //     height: 74.w,
                  //     onPressed: _minusNum,
                  //     child: Container(
                  //       decoration: const BoxDecoration(image: DecorationImage(image: const AssetImage("images/minus_gray.png"))),
                  //       width: 74.w,
                  //       height: 74.w, // 设计图
                  //     ))
                  // 设计图
                  )),
          Expanded(
              child: RepaintBoundary(
                  child: TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController.fromValue(TextEditingValue(
                text: '${widget.num}',
                //判断keyword是否为空
                // 保持光标在最后
                selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: '${widget.num}'.length)))),
            style: TextStyle(fontSize: 36.w, color: Color(widget.num.startsWith('-') ? widget.negativeColor : widget
                .color),fontWeight:FontWeight.w600),
            // keyboardType: TextInputType.number,
            keyboardType: NumberKeyboard.inputType,
            enableInteractiveSelection: false,
            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            inputFormatters: [NumNegativeInputFormatter(negative: widget.negative), LengthLimitingTextInputFormatter(5)],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: '0',
              counterText: "",
              isCollapsed: true,
              hintStyle: TextStyle(fontSize: 36.w, color: Color(ColorConfig.color_999999)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 15.w, 0, 15.w),
            ),
            onChanged: (value) {
              print(value);
              print(widget.num);
              setState(() {
                widget.num = value;
                if (value == '-' || value == '') {
                  widget.onValueChanged('0');
                } else {
                  widget.onValueChanged(widget.num);
                }
              });
            },
            onEditingComplete: () {
              widget.onEditingComplete();
            },
          ))),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _addNum,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Color(widget.buttonBack), border: Border(left: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                  width: 74.w,
                  height: 74.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    size: 36.w,
                    color: Color(widget.buttonColor),
                  ))
              // FlatButton(
              //     padding: EdgeInsets.zero,
              //     focusNode: FocusNode(skipTraversal: true),
              //     minWidth: 74.w,
              //     height: 74.w,
              //     onPressed: _addNum,
              //     child: Container(
              //       decoration: const BoxDecoration(image: DecorationImage(image: const AssetImage("images/plus.png"))),
              //       width: 74.w,
              //       height: 74.w, // 设计图
              //     )), // 设计图
              ),
        ],
      ),
    ));
  }

  void _minusNum() {
    if ((widget.num == '0' || widget.num == '') && !widget.negative) {
      return;
    }
    setState(() {
      if (widget.num == '') {
        widget.num = '0';
      }
      widget.num = (int.parse(widget.num) - 1).toString();
      widget.onValueChanged(widget.num);
    });
  }

  void _addNum() {
    setState(() {
      if (widget.num == '') {
        widget.num = '0';
      }
      widget.num = (int.parse(widget.num) + 1).toString();
      widget.onValueChanged(widget.num);
    });
  }
}

class NumNegativeInputFormatter extends TextInputFormatter {
  bool negative;

  NumNegativeInputFormatter({this.negative = false}) : super();

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
    if (oldValue.text == '0' && newValue.text != '') {
      value = newValue.text.substring(1);
      selectionIndex = oldValue.selection.end;
    }
    if(newValue.text.contains('.')){
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
