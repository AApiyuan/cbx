import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/exposure/controller/exposure_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class ExposureView extends GetView<ExposureController> {
  bool show = true;
  ExposureController ctl = Get.find<ExposureController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExposureController>(
        id: "exposureview",
        builder: (ctl) {
          return Scaffold(
              appBar: pAppBar('体验', actions: [
                GestureDetector(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(ColorConfig.color_1678FF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.w))),
                      padding: EdgeInsets.only(
                          top: 12.w, bottom: 12.w, left: 24.w, right: 24.w),
                      child: pText("曝光", ColorConfig.color_ffffff, 28.w),
                    ),
                  ),
                  onTap: () {
                    ctl.exposureConsumer();
                  },
                ),
                pSizeBoxW(40.w)
              ]),
              backgroundColor: Color(ColorConfig.color_ffffff),
              body: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        pSizeBoxH(15.w),
                        Row(
                          children: [
                            pSizeBoxW(30.w),
                            Expanded(
                                child: Container(
                                    height: 154.w,
                                    padding: EdgeInsets.all(20.w),
                                    child: TextField(
                                      maxLines: 10,
                                      keyboardType: TextInputType.text,
                                      inputFormatters:
                                      CommonUtils.getTextInputFormatter(100),
                                      decoration: InputDecoration(
                                        hintText: '请输入内容',
                                        counterText: "",
                                        hintStyle: TextStyle(
                                            fontSize: 28.w,
                                            color:
                                            Color(ColorConfig.color_999999)),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      autofocus: false,
                                      style: TextStyle(
                                          fontSize: 28.w,
                                          color: Color(ColorConfig.color_333333)),
                                      onChanged: (value) {
                                        ctl.content = value;
                                      },
                                    ))),
                            pSizeBoxW(30.w),
                          ],
                        ),
                        GetBuilder<ExposureController>(
                            id: "gridview",
                            builder: (ctl) {
                              int line = (ctl.datas.length - 1) ~/ 4 + 1;
                              return Container(
                                // width: 500.w,
                                  height: (line * 188 + 100).w,
                                  padding: EdgeInsets.all(50.w),
                                  child: GridView.builder(
                                    physics: new NeverScrollableScrollPhysics(),
                                    //禁用滑动事件
                                    itemCount: ctl.datas.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return getItemContainer(
                                          ctl.datas[index], index);
                                    },
                                    gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      //单个子Widget的水平最大宽度
                                        maxCrossAxisExtent: 161.w,
                                        //水平单个子Widget之间间距
                                        mainAxisSpacing: 24.0.w,
                                        //垂直单个子Widget之间间距
                                        crossAxisSpacing: 24.0.w),
                                  ));
                            }),
                        Row(
                          children: [
                            pSizeBoxW(60.w),
                            pText('对方手机号', ColorConfig.color_333333, 28.w,
                                height: 60.w),
                            Expanded(
                              child: Container(
                                height: 60.w,
                                padding: EdgeInsets.only(top: 10.w),
                                child: TextField(
                                  controller: TextEditingController.fromValue(TextEditingValue(text: '${ctl.phone}')),
                                  maxLines: 10,
                                  keyboardType: TextInputType.number,
                                  inputFormatters:
                                  CommonUtils.getTextInputFormatter(11),
                                  decoration: InputDecoration(
                                    hintText: '  请输入手机号码',
                                    counterText: "",
                                    hintStyle: TextStyle(
                                        fontSize: 28.w,
                                        color: Color(ColorConfig.color_999999)),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  autofocus: false,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 28.w,
                                      color: Color(ColorConfig.color_333333)),

                                  onChanged: (value) {
                                    ctl.phone = value;
                                  },
                                ),
                              ),
                            ),
                            pSizeBoxW(60.w),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 50.w),
                          child: GestureDetector(
                              onTap: () {
                                showActionSheet(context);
                              },
                              child: Row(
                                children: [
                                  pSizeBoxW(60.w),
                                  Expanded(
                                    child: pText(
                                        '显示店铺名称', ColorConfig.color_333333, 28.w,
                                        height: 60.w,
                                        alignment: Alignment.centerLeft),
                                  ),
                                  pText(ctl.show ? '显示' : '不显示',
                                      ColorConfig.color_333333, 28.w,
                                      height: 60.w),
                                  pSizeBoxW(5.w),
                                  pImage("images/icon_goto.png", 23.w, 23.w),
                                  pSizeBoxW(60.w),
                                ],
                              )),
                        ),
                        pSizeBoxH(200.w)
                      ],
                    )),

              ));
        });
  }

  Future<void> showActionSheet(BuildContext context) async {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            // title: Text("123456"),
            // message: Text("123456"),

            actions: [
              CupertinoActionSheetAction(
                  onPressed: () {
                    ctl.show = true;
                    ctl.update(["exposureview"]);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      pSizeBoxW(10.w),
                      pImage(
                          !ctl.show
                              ? "images/unChecked.png"
                              : "images/checked.png",
                          40.w,
                          40.w),
                      pSizeBoxW(20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText('显示', ColorConfig.color_333333, 34.w),
                          pText('全国所有店铺及人员可见', ColorConfig.color_999999, 28.w)
                        ],
                      )
                    ],
                  )),
              CupertinoActionSheetAction(
                  onPressed: () {
                    ctl.show = false;
                    ctl.update(["exposureview"]);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      pSizeBoxW(10.w),
                      pImage(
                          ctl.show
                              ? "images/unChecked.png"
                              : "images/checked.png",
                          40.w,
                          40.w),
                      pSizeBoxW(20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText('不显示', ColorConfig.color_333333, 34.w),
                          pText('只本公司可见店铺名称，其他显示“***”',
                              ColorConfig.color_999999, 28.w)
                        ],
                      )
                    ],
                  ))
            ],
          );
        });
  }

  Widget getItemContainer(String item, int index) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {
              ctl.showChooseImgDialog();
            },
            child: item == "images/icon_good_add.png"
                ? Container(
                    width: 140.w,
                    height: 140.w,
                    padding: EdgeInsets.all(10.w),
                    child: pImage(item, 140.w, 140.w),
                  )
                : Container(
                    width: 140.w,
                    height: 140.w,
                    padding: EdgeInsets.all(10.w),
                    child: NetImageWidget(
                      item,
                      height: 140,
                      width: 140,
                    ))),
        Positioned(
            top: 0.w,
            right: 0.w,
            child: Visibility(
                visible: item != "images/icon_good_add.png",
                child: Container(
                  width: 42.w,
                  child: GestureDetector(
                    child: Column(
                      children: [
                        pImage("images/icon_search_clear.png", 42.w, 42.w),
                      ],
                    ),
                    onTap: () {
                      ctl.datas.removeAt(index);
                      ctl.update(["gridview"]);
                    },
                  ),
                )))
      ],
    );
    //   Container(
    //   width: 5.0,
    //   height: 5.0,
    //   alignment: Alignment.center,
    //   child: Text(
    //     item,
    //     style: TextStyle(color: Colors.white, fontSize: 20),
    //   ),
    //   color: Colors.blue,
    // );
  }
}
