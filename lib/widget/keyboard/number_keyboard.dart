import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_controller.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_manager.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class NumberKeyboard extends StatelessWidget {
  static const CKTextInputType inputType = const CKTextInputType(name: 'CKNumberKeyboard');

  static double getHeight(BuildContext ctx) {
    // MediaQueryData mediaQuery = MediaQuery.of(ctx);
    // return mediaQuery.size.width / 4 / 2 * 4;
    return 450.w;
  }

  final KeyboardController controller;

  const NumberKeyboard({required this.controller});

  static register() {
    CoolKeyboard.addKeyboard(
        NumberKeyboard.inputType,
        KeyboardConfig(
            builder: (context, controller, params) {
              return NumberKeyboard(controller: controller);
            },
            getHeight: NumberKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return RepaintBoundary(
        child: Material(
      child: DefaultTextStyle(
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
          child: Container(
              height: getHeight(context),
              padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
              decoration: BoxDecoration(
                color: Color(ColorConfig.color_efefef),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      Expanded(
                          flex: 1,
                          child: pImageCenterButton('images/cancel.png', double.infinity, 100.w, () {
                            controller.deleteOne();
                          }, 52.w, 34.w, radius: 8.w, background: ColorConfig.color_ffffff))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  buildButton('4'),
                                  buildButton('5'),
                                  buildButton('6'),
                                ],
                              ),
                              Row(
                                children: [
                                  buildButton('7'),
                                  buildButton('8'),
                                  buildButton('9'),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildButton('.'),
                                  buildButton('0'),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 7.w, 7.w),
                                        child: pImageCenterButton('images/key.png', double.infinity, 100.w, () {
                                          controller.closeAction();
                                        }, 52.w, 52.w, radius: 8.w, background: ColorConfig.color_ffffff)),
                                  )
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 314.w,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // buildButton('-', right: 0),
                                pButton(double.infinity, 314.w, "完成", ColorConfig.color_ffffff, 32.w, () {
                                  controller.nextAction();
                                }, radius: 8.w)
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ))),
    ));
  }

  Widget buildButton(String title, {String? value, int flex = 1, double right = 7}) {
    return Expanded(
        flex: flex,
        child: Container(
            decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular((8.w))),
            margin: EdgeInsets.fromLTRB(0, 0, right.w, 7.w),
            height: 100.w,
            child: pButton(double.infinity, double.infinity, title, ColorConfig.color_333333, 42.w, () {
              controller.addText(value ?? title);
            }, background: ColorConfig.color_ffffff, radius: 8.w)));
  }
}
