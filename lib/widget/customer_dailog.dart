import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///自定义Dialog
// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  final String title; //弹窗标题
  final int height;
  final int width;
  final int contentLength;
  final int type; //弹框类型 ，0，输入框,1 文本，
  String value; //输入框的值
  final Widget? content; //弹窗内容
  final String confirmContent; //按钮文本
  final int confirmTextColor; //确定按钮文本颜色
  final bool isCancel; //是否有取消按钮，默认为true true：有 false：没有
  final bool isConfirm; //是否有确定按钮，默认为true true：有 false：没有
  final int confirmColor; //确定按钮颜色
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭
  final Function? confirmCallback; //点击确定按钮回调
  final Function? dismissCallback; //弹窗关闭回调
  final bool Function(String)? confirmCheckCallback; //检测点击确定是否有效

  CustomDialog(
      {Key? key,
      this.title = "",
      this.type = 0,
      this.value = "",
      this.content,
      this.height = 570,
      this.width = 550,
      this.contentLength = 50,
      this.confirmContent = "确定",
      this.confirmTextColor = ColorConfig.color_1678ff,
      this.isCancel = true,
      this.isConfirm = true,
      this.confirmColor = ColorConfig.color_ffffff,
      this.outsideDismiss = true,
      this.confirmCallback,
      this.dismissCallback,
      this.confirmCheckCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomDialogState();
  }
}

class CustomDialogState extends State<CustomDialog> {
  confirmDialog() {
    if (!(widget.confirmCheckCallback?.call(widget.value) ?? true)) {
      return;
    }
    _dismissDialog();
    if (widget.confirmCallback != null) {
      widget.confirmCallback!(widget.value);
    }
  }

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback!();
    }
    Navigator.of(context).pop();
  }

  Widget childContent(int type) {
    if (type == 0) {
      return Container(
          width: double.infinity,
          height: 310.w,
          padding: EdgeInsets.all(20.w),
          margin: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
          decoration: BoxDecoration(color: const Color(ColorConfig.color_f5f5f5), borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: TextField(
            controller: TextEditingController.fromValue(TextEditingValue(text: '${widget.value}')),
            maxLines: 10,
            inputFormatters: CommonUtils.getTextInputFormatter(widget.contentLength),
            decoration: InputDecoration(
              hintText: '请输入',
              counterText: "",
              hintStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_999999)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            autofocus: true,
            style: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_F3AE1F)),
            onChanged: (value) {
              widget.value = value;
            },
          ));
    } else if (type == 1) {
      return widget.content ?? pText("", ColorConfig.color_333333, 28.w);
    } else {
      return pText("", ColorConfig.color_333333, 28.w);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.height == 570) {
      return KeyboardMediaQuery(
        child: WillPopScope(
            child: Material(
              type: MaterialType.transparency,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => {widget.outsideDismiss ? _dismissDialog() : null},
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          width: widget.width.w,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              pSizeBoxH(36.w /*widget.title != "" ? 36.w : 106.w*/),
                              Visibility(
                                visible: widget.title != "",
                                child: pText(widget.title, ColorConfig.color_333333, 34.w, fontWeight: FontWeight.w600),
                              ),
                              pSizeBoxH(widget.title == "" ? 0 : 36.w),
                              childContent(widget.type),
                              pSizeBoxH(45.w),
                              Divider(
                                height: 1.w,
                                color: Color(ColorConfig.color_efefef),
                              ),
                              Visibility(
                                child: Container(
                                  height: 88.w,
                                  child: Row(
                                    children: <Widget>[
                                      Visibility(
                                        visible: widget.isCancel,
                                        child: Expanded(
                                          child: pButton(
                                            double.infinity,
                                            88.w,
                                            "取消",
                                            ColorConfig.color_999999,
                                            32.w,
                                            () {
                                              _dismissDialog();
                                            },
                                            background: ColorConfig.color_ffffff,
                                            radius: 30.w,
                                          ),
                                          flex: 1,
                                        ),
                                      ),
                                      SizedBox(width: widget.isCancel ? 1.w : 0, child: Container(color: Color(ColorConfig.color_efefef))),
                                      Visibility(
                                        child: Expanded(
                                          child: pButton(
                                            double.infinity,
                                            88.w,
                                            widget.confirmContent,
                                            widget.confirmTextColor,
                                            32.w,
                                            () => confirmDialog(),
                                            background: widget.confirmColor,
                                            radius: 30.w,
                                          ),
                                        ),
                                        visible: widget.isConfirm,
                                      ),
                                    ],
                                  ),
                                ),
                                visible: widget.isConfirm || widget.isCancel,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.circular(30.w)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              return widget.outsideDismiss;
            }),
      );
    } else {
      return KeyboardMediaQuery(
        child: WillPopScope(
            child: Material(
              type: MaterialType.transparency,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => {widget.outsideDismiss ? _dismissDialog() : null},
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          width: widget.width.w,
                          height: widget.height.w,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              pSizeBoxH(36.w /*widget.title != "" ? 36.w : 106.w*/),
                              Visibility(
                                visible: widget.title != "",
                                child: pText(widget.title, ColorConfig.color_333333, 34.w, fontWeight: FontWeight.w600),
                              ),
                              pSizeBoxH(widget.title == "" ? 0 : 36.w),
                              childContent(widget.type),
                              pSizeBoxH(45.w),
                              Divider(
                                height: 1.w,
                                color: Color(ColorConfig.color_efefef),
                              ),
                              Visibility(
                                child: Container(
                                  height: 88.w,
                                  child: Row(
                                    children: <Widget>[
                                      Visibility(
                                        visible: widget.isCancel,
                                        child: Expanded(
                                          child: pButton(
                                            double.infinity,
                                            88.w,
                                            "取消",
                                            ColorConfig.color_999999,
                                            32.w,
                                            () {
                                              _dismissDialog();
                                            },
                                            background: ColorConfig.color_ffffff,
                                            radius: 30.w,
                                          ),
                                          flex: 1,
                                        ),
                                      ),
                                      SizedBox(width: widget.isCancel ? 1.w : 0, child: Container(color: Color(ColorConfig.color_efefef))),
                                      Visibility(
                                        child: Expanded(
                                          child: pButton(
                                            double.infinity,
                                            88.w,
                                            widget.confirmContent,
                                            widget.confirmTextColor,
                                            32.w,
                                            () => confirmDialog(),
                                            background: widget.confirmColor,
                                            radius: 30.w,
                                          ),
                                        ),
                                        visible: widget.isConfirm,
                                      ),
                                    ],
                                  ),
                                ),
                                visible: widget.isConfirm || widget.isCancel,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.circular(30.w)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              return widget.outsideDismiss;
            }),
      );
    }
  }
}
