import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import '../verification_logic.dart';

Widget collectionAndRefundCard(
  TabController tabController,
  TextEditingController textEditingController,
  BuildContext context,
  var self,
) {
  return Column(
    children: [
      GetBuilder<VerificationLogic>(
          id: "third",
          builder: (ctl) {
            tabController =
                TabController(length: ctl.refundMethodList.length, vsync: self);
            ctl.tabController = tabController;
            return Container(
                child: Card(
                  margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
                  child: Column(
                    children: [
                      Container(
                        child: Center(
                          child: CupertinoSlidingSegmentedControl(
                            children: {
                              1: Text('收款'),
                              2: Text('退款'),
                            },
                            onValueChanged: (value) {
                              ctl.updateRefundMethodBtn(value);
                              // ctl.groupValue = int.parse(value.toString());
                            },
                            groupValue: ctl.groupValue,
                          ),
                        ),
                        height: 80.w,
                        width: 470.w,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: TabBar(
                                  isScrollable: true,
                                  controller: tabController,
                                  labelColor: Colors.blue,
                                  unselectedLabelColor: Colors.black38,
                                  tabs: ctl.refundMethodList.map((e) {
                                    return Tab(text: e.remitMethodName);
                                  }).toList(),
                                  onTap: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    ctl.refundChangeTap();
                                  },
                                  indicatorSize: TabBarIndicatorSize.label),
                            ),
                            IconButton(
                                onPressed: () {
                                  // 收款方式-跳转
                                  Get.toNamed(ArgUtils.map2String(
                                      path: Routes.REFUND_METHOD,
                                      arguments: {
                                        'refundString':
                                            jsonEncode(ctl.refundMethodList)
                                      }));
                                },
                                icon: Icon(Icons.menu)),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        height: 80.w,
                        //width: 250.w,
                      ),
                      Row(
                        children: [
                          ctl.plusOrMinusWidget(),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onChanged: (value) {
                                ctl.editCompletedAssignment(value);
                              },
                              controller: textEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '0.0',
                              ),
                              style: TextStyle(fontSize: 64.w),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                height: 350.w,
                width: 750.w);
          }),
      GetBuilder<VerificationLogic>(
          id: "thirdSon",
          builder: (ctl) {
            return getRefundMethodWidget(ctl);
          }),
    ],
  );
}

// 收退款-部件显示
Widget getRefundMethodWidget(VerificationLogic ctl) {
  ctl.showRefundMethodList = [];
  for (var entity in ctl.refundMethodList) {
    if (ctl.groupValue == 1) {
      if (entity.xPaymentAmount != null) {
        ctl.showRefundMethodList.add(entity);
      }
    } else {
      if (entity.xRefundAmount != null) {
        ctl.showRefundMethodList.add(entity);
      }
    }
  }

  return Container(
    color: Colors.white,
    width: 710.w,
    height: 90.w * ctl.showRefundMethodList.length,
    child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        StoreRemitMethodDoEntity entity = ctl.showRefundMethodList[index];

        if (ctl.groupValue == 1) {
          return ListTile(
            title: pText(
                entity.remitMethodName!, ColorConfig.color_333333, 22.w,
                textAlign: TextAlign.left),
            trailing: pText(
                "收款¥${entity.xPaymentAmount!}", ColorConfig.color_333333, 22.w,
                textAlign: TextAlign.right),
          );
        } else {
          return ListTile(
            title: pText(
                entity.remitMethodName!, ColorConfig.color_333333, 22.w,
                textAlign: TextAlign.left),
            trailing: pText(
                "退款¥${entity.xRefundAmount!}", ColorConfig.color_333333, 22.w,
                textAlign: TextAlign.right),
          );
        }
      },
      itemExtent: 50.w,
      itemCount: ctl.showRefundMethodList.length,
    ),
  );
}
