//height在expand为false时候生效
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class BottomSheetWidget extends StatefulWidget {
  Widget? child;
  bool showTitle = true;
  String title = "";
  Function? onClose;
  Function? onCertain;
  String buttonText = "确定";
  double? height;
  bool showCertain;
  EdgeInsetsGeometry? childPadding = EdgeInsets.fromLTRB(24.w, 10.w, 24.w, 0);
  Widget? leftWidget;
  bool autoClose;//是否点确定时候关闭

  BottomSheetWidget(
      {this.child,
      this.showTitle = true,
      this.title = "",
      this.onClose,
      this.buttonText = "确定",
      this.height,
      this.onCertain,
      this.showCertain = true,
      this.childPadding,
      this.leftWidget,
      this.autoClose = true});

  @override
  State<StatefulWidget> createState() {
    return _BottomSheetState();
  }
}

class _BottomSheetState extends State<BottomSheetWidget> {
  double padding = 0;

  // var keyboardVisibilityController;

  // double keyboardHeight = 0;
  // ValueNotifier<double> keyboardHeightNotifier = CoolKeyboard.getKeyboardHeightNotifier();

  @override
  void initState() {
    // keyboardVisibilityController = KeyboardVisibilityController();
    // // Subscribe
    // keyboardVisibilityController.onChange.listen((bool visible) {
    //   if (mounted) {
    //     setState(() {
    //       if (visible) {
    //         padding = CoolKeyboard.getKeyboardHeightNotifier().value != null ? CoolKeyboard.getKeyboardHeightNotifier().value : 600.w;
    //       } else {
    //         padding = 0;
    //       }
    //     });
    //   }
    // });

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
    return KeyboardMediaQuery(
        child: Container(
            height: widget.height ?? double.infinity,
            child: Scaffold(
              backgroundColor: new Color(ColorConfig.color_ffffff),
              body: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, widget.showCertain ? 150.w : 0),
                        decoration: BoxDecoration(
                            color: new Color(ColorConfig.color_ffffff),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))),
                        child: Container(
                          padding: widget.childPadding,
                          child: Column(
                            children: [
                              Container(
                                height: 70.w,
                                alignment: Alignment.center,
                                child: pText(widget.showTitle ? widget.title : "", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600),
                              ),
                              // pSizeBoxH(50.w),
                              Expanded(child: widget.child as Widget)
                            ],
                          ),
                        ),
                      ),
                      new Positioned(
                          top:10.w,
                          right: 10.w,
                          child: pImageButton("images/del_pic.png", 60.w, 60.w, () {
                            Navigator.pop(context);
                            if (widget.onClose != null) {
                              widget.onClose!();
                            }
                          })),
                      Positioned(
                          left: 10.w,
                          child: widget.leftWidget ?? pSizeBoxW(0)),
                    ],
                  )),
              bottomSheet: Visibility(
                  visible: widget.showCertain,
                  child:  Container(
                          margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.w),
                          child: pButton(
                            double.infinity,
                            96.w,
                            widget.buttonText,
                            ColorConfig.color_ffffff,
                            28.w,
                            () {
                              if (widget.onCertain != null) {
                                widget.onCertain!();
                              }
                              if(widget.autoClose){
                                Navigator.pop(context);
                              }
                            },
                            radius: 96.w,
                          ))),
            )));
  }
}
