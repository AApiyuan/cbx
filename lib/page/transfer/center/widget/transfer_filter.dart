import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/model/enum/transfer_enum.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/select_relation_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget docStateContent(DrawerDialog dialog, Function confirmFunction) {
  var function = () => dialog.dismiss();

  // 单据状态
  List<bool> _docStateList = [];

  // 是否撤销
  List<bool> _revocationList = [];

  // 是否差异
  List<bool> _differencesList = [];

  return Container(
      color: Colors.white,
      height: 800.h,
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: GetBuilder<TransferCenterController>(builder: (ctl) {
              for (bool item in ctl.docStateList) {
                _docStateList.add(item);
                // _docStateDefaultList.add(item);
              }

              for (bool item in ctl.revocationList) {
                _revocationList.add(item);
                // _revocationDefaultList.add(item);
              }

              for (bool item in ctl.differencesList) {
                _differencesList.add(item);
                // _differencesDefaultList.add(item);
              }

              print("有没有1");
              print(_docStateList);
              print(_revocationList);
              print(_differencesList);
              print("有没有2");

              return ListView(
                padding: EdgeInsets.all(8.w),
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pSizeBoxW(5.w),
                        pText("单据状态", ColorConfig.color_333333, 28.w),
                      ]),
                  Container(
                    height: 180.w,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8.w),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.w,
                          childAspectRatio:
                              (DeviceUtil.isPad() ? 500 : 220) / 76,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: docStateItem(
                                index,
                                _docStateList,
                                ctl.groupValue == 0
                                    ? TransferOrderType.transferIn
                                    : TransferOrderType.transferOut),
                            onTap: () {
                              _docStateList[index] = !_docStateList[index];
                              ctl.update();
                            },
                          );
                        }),
                  ),
                  pSizeBoxH(20.w),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pSizeBoxW(5.w),
                        pText("是否撤销", ColorConfig.color_333333, 28.w),
                      ]),
                  Container(
                    height: 90.w,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8.w),
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.w,
                          childAspectRatio:
                              (DeviceUtil.isPad() ? 500 : 220) / 76,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: revocationItem(index, _revocationList),
                            onTap: () {
                              _revocationList[index] = !_revocationList[index];
                              if ((ctl.revocationList[0] ^
                                      ctl.revocationList[1]) ||
                                  ctl.revocationList[1]) {
                                ctl.canceled = 1;
                              } else {
                                ctl.canceled = 0;
                              }
                              ctl.update();
                            },
                          );
                        }),
                  ),
                  pSizeBoxH(20.w),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pSizeBoxW(5.w),
                        pText("是否有差异", ColorConfig.color_333333, 28.w),
                      ]),
                  Container(
                    height: 90.w,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8.w),
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.w,
                          childAspectRatio:
                              (DeviceUtil.isPad() ? 500 : 220) / 76,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: differenceItem(index, _differencesList),
                            onTap: () {
                              _differencesList[index] =
                                  !_differencesList[index];
                              if ((ctl.differencesList[0] ^
                                      ctl.differencesList[1]) ||
                                  ctl.differencesList[1]) {
                                ctl.difference = 1;
                              } else {
                                ctl.difference = 0;
                              }

                              ctl.update();
                            },
                          );
                        }),
                  ),
                ],
              );
            }),
          ),
          Divider(
            height: 1.w,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  color: Colors.white,
                  child: GetBuilder<TransferCenterController>(builder: (ctl) {
                    return Row(
                      children: [
                        pActionText(
                            '重置', ColorConfig.color_666666, 28.w, 250.w, 96.w,
                            () {
                          // 单据状态
                          _docStateList = [false, false, false, false];

                          // 是否撤销
                          _revocationList = [true, false];

                          // 是否差异
                          _differencesList = [false, false];

                          ctl.update();
                        }, background: ColorConfig.color_ffffff),
                        pActionText(
                            '取消', ColorConfig.color_1678ff, 28.w, 250.w, 96.w,
                            () {
                          function();
                        }, background: ColorConfig.color_f5f5f5),
                        pActionText(
                            '确定', ColorConfig.color_ffffff, 28.w, 250.w, 96.w,
                            () {
                          function();

                          ctl.docStateList = _docStateList;
                          ctl.revocationList = _revocationList;
                          ctl.differencesList = _differencesList;
                          ctl.pageRefresh(ctl.lastListType, ctl.lastCtr,
                              refresh: true);
                          confirmFunction();
                        }, background: ColorConfig.color_1678ff),
                      ],
                    );
                  })))
        ],
      ));
}

docStateItem(
    int index, List<bool> revocationList, TransferOrderType orderyype) {
  bool isSelected = revocationList[index];
  if (index == 0) {
    return stateButton(isSelected,
        orderyype == TransferOrderType.transferIn ? '待对方调出' : '待出库');
  } else if (index == 1) {
    return stateButton(isSelected,
        orderyype == TransferOrderType.transferIn ? '已出待入库' : '已出对方待收');
  } else if (index == 2) {
    return stateButton(isSelected,
        orderyype == TransferOrderType.transferIn ? '已入库待完成' : '已收待完成');
  } else if (index == 3) {
    return stateButton(isSelected, '已完成');
  } else {
    return Text("未知");
  }
}

revocationItem(int index, List<bool> revocationList) {
  bool isSelected = revocationList[index];
  if (index == 0) {
    return stateButton(isSelected, '正常');
  } else if (index == 1) {
    return stateButton(isSelected, '已撤销');
  } else {
    return Text("未知");
  }
}

differenceItem(int index, List<bool> differencesList) {
  bool isSelected = differencesList[index];
  if (index == 0) {
    return stateButton(isSelected, '有差异');
  } else if (index == 1) {
    return stateButton(isSelected, '无差异');
  } else {
    return Text("未知");
  }
}

Widget stateButton(bool isSelected, String text) {
  if (isSelected) {
    return Container(
        height: 76.w,
        child: Center(
          child: pText(text, ColorConfig.color_1678ff, 28.w),
        ),
        decoration: BoxDecoration(
          color: Color(ColorConfig.color_E8F2FF),
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
        ));
  } else {
    return Container(
        height: 76.w,
        child: Center(
          child: pText(text, ColorConfig.color_666666, 28.w),
        ),
        decoration: BoxDecoration(
          color: Color(ColorConfig.color_f5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
        ));
  }
}

Widget hisShopContent(DrawerDialog dialog, List<SelectRelationEntity> list,
    Function callFuction) {
  var function = () => dialog.dismiss();
  return Container(
      color: Colors.white,
      height: 800.h,
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: GetBuilder<TransferCenterController>(builder: (ctl) {
              return ListView.builder(
                padding: EdgeInsets.all(8.w),
                itemCount: list.length,
                itemExtent: 92.w,
                itemBuilder: (BuildContext context, int index) {
                  SelectRelationEntity item = list[index];
                  return hisShopContentItem(ctl, list, index, () {
                    function();
                    callFuction();
                    ctl.pageRefresh(ctl.lastListType, ctl.lastCtr,
                        refresh: true);
                  });
                },
              );
            }),
          ),
          Divider(),
          Expanded(
              flex: 1,
              child: GetBuilder<TransferCenterController>(builder: (ctl) {
                return GestureDetector(
                  onTap: () {
                    ctl.selectedHisShopId = null;
                    ctl.update();
                    ctl.pageRefresh(ctl.lastListType, ctl.lastCtr,
                        refresh: true);
                    function.call();
                  },
                  child: Center(
                    child: pText('不选择店铺', ColorConfig.color_666666, 28.w),
                  ),
                );
              }))
        ],
      ));
}

hisShopContentItem(TransferCenterController ctl,
    List<SelectRelationEntity> list, int index, Function function) {
  // var customer = ctl.filterCustomer[index];
  // var select = ctl.isSelectCustomer(customer.customer?.id);

  SelectRelationEntity item = list[index];
  int? selectedHisShopId = ctl.selectedHisShopId;
  bool isSelected = item.id == selectedHisShopId ? true : false;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
        margin: EdgeInsets.only(left: 30.w),
        height: 92.w,
        alignment: Alignment.centerLeft,
        child: pText(
            "${item.name}",
            isSelected ? ColorConfig.color_1678FF : ColorConfig.color_333333,
            28.w,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400)
        // pText(
        //   "${customer.customer?.customerName} ${customer.count}单",
        //   select ? ColorConfig.color_1678FF : ColorConfig.color_333333,
        //   28.w,
        //   fontWeight: select ? FontWeight.bold : FontWeight.w400,
        // ),
        ),
    onTap: () {
      //ctl.updateSelectCustomer(customer.customer!.id!);
      ctl.selectedHisShopId = item.relationDeptId!.toInt();
      ctl.update();
      ctl.pageRefresh(ctl.lastListType, ctl.lastCtr, refresh: true);
      function.call();
    },
  );
}
