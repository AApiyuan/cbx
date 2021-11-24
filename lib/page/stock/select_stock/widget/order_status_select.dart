import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget orderStatusSelect(Function change) {
  var _orderTypeKey = GlobalKey();

  return GetBuilder<SelectStockController>(builder: (ctl) {
    return GestureDetector(
      onTap: () {
        DrawerDialog(
          (dialog) => orderStatusSelectContent(dialog, change, ctl),
          autoDismiss: false,
        ).show(Get.context as BuildContext, _orderTypeKey);
      },
      child: Row(key: _orderTypeKey, children: [
        pText('筛选', ColorConfig.color_666666, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxW(16.w),
        pImage("images/icon_filtrate_off.png", 24.w, 24.w),
      ]),
    );
  });
}

Widget orderStatusSelectContent(DrawerDialog dialog, Function change, SelectStockController controller) {
  List<MerchandiserUserDoEntity> oldPersonListData = new List.from(controller.personListData);
  Map<String, bool> oldSelectedStatus = new Map.from(controller.selectedStatus); //状态选择
  var oldOnlyOnJob = false.obs; //只看在职
  Map<int, bool> oldSelectedMerchandisers = new Map.from(controller.selectedMerchandisers);
  return GetBuilder<SelectStockController>(
      id: "orderStatusSelect",
      builder: (ctl) {
        return Stack(children: [
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 33.w, left: 24.w, right: 24.w),
              height: 900.w,
              child: Column(
                children: [
                  Row(
                    children: [
                      pText('单据状态', ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                    ],
                  ),
                  pSizeBoxH(20.w),
                  GetBuilder<SelectStockController>(
                      id: "status",
                      builder: (ctl) {
                        return Row(
                          children: [
                            pActionText("正常", ctl.selectedStatus[CanceledEnum.ENABLE] != null ? ColorConfig.color_1678ff : ColorConfig.color_666666,
                                28.w, 220.w, 76.w, () {
                              if (ctl.selectedStatus[CanceledEnum.ENABLE] != null) {
                                ctl.selectedStatus.remove(CanceledEnum.ENABLE);
                              } else {
                                ctl.selectedStatus[CanceledEnum.ENABLE] = true;
                              }
                              ctl.update(['status']);
                            },
                                background: ctl.selectedStatus[CanceledEnum.ENABLE] != null ? ColorConfig.color_E8F2FF : ColorConfig.color_f5f5f5,
                                radius: 10.w),
                            pSizeBoxW(20),
                            pActionText(
                                "已撤销",
                                ctl.selectedStatus[CanceledEnum.CANCELED] != null ? ColorConfig.color_1678ff : ColorConfig.color_666666,
                                28.w,
                                220.w,
                                76.w, () {
                              if (ctl.selectedStatus[CanceledEnum.CANCELED] != null) {
                                ctl.selectedStatus.remove(CanceledEnum.CANCELED);
                              } else {
                                ctl.selectedStatus[CanceledEnum.CANCELED] = true;
                              }
                              ctl.update(['status']);
                            },
                                background: ctl.selectedStatus[CanceledEnum.CANCELED] != null ? ColorConfig.color_E8F2FF : ColorConfig.color_f5f5f5,
                                radius: 10.w),
                          ],
                        );
                      }),
                  pSizeBoxH(40.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pText('操作人', ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                      Row(
                        children: [
                          pText('不查看已离职', ColorConfig.color_999999, 24.w),
                          pSizeBoxW(10.w),
                          Transform.scale(
                              scale: GetPlatform.isIOS ? 1 : 1.5,
                              child: Obx(
                                () => CupertinoSwitch(
                                  value: ctl.onlyOnJob.value,
                                  onChanged: (change) {
                                    ctl.onlyOnJob.toggle();
                                    ctl.updatePersonListData();
                                  },
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                  pSizeBoxH(20.w),
                  FutureBuilder(
                      future: ctl.getPersonListData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(color: Color(ColorConfig.color_ffffff));
                        } else {
                          return Expanded(
                            child: GetBuilder<SelectStockController>(
                                id: "merchandiser",
                                builder: (ctl) {
                                  return GridView.builder(
                                      shrinkWrap: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(8.w),
                                      itemCount: ctl.personListData.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 16.w,
                                        mainAxisSpacing: 16.w,
                                        childAspectRatio: 220.0 / 76,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return GetBuilder<SelectStockController>(
                                            id: "merchandiser" + ctl.personListData[index].id.toString(),
                                            builder: (ctl) {
                                              return Visibility(
                                                  visible: !(ctl.onlyOnJob.value && ctl.personListData[index].status == Status.DISABLE),
                                                  child: Stack(
                                                    children: [
                                                      pActionText(
                                                          ctl.personListData[index].name.toString(),
                                                          ctl.selectedMerchandisers[ctl.personListData[index].id] != null
                                                              ? ColorConfig.color_1678ff
                                                              : ColorConfig.color_666666,
                                                          28.w,
                                                          220.w,
                                                          76.w, () {
                                                        if (ctl.selectedMerchandisers[ctl.personListData[index].id] != null) {
                                                          ctl.selectedMerchandisers.remove(ctl.personListData[index].id);
                                                        } else {
                                                          ctl.selectedMerchandisers[ctl.personListData[index].id as int] = true;
                                                        }
                                                        ctl.update(["merchandiser" + ctl.personListData[index].id.toString()]);
                                                      },
                                                          background: ctl.selectedMerchandisers[ctl.personListData[index].id] != null
                                                              ? ColorConfig.color_E8F2FF
                                                              : ColorConfig.color_f5f5f5,
                                                          radius: 10.w),
                                                      Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Visibility(
                                                            visible: ctl.personListData[index].status == Status.DISABLE,
                                                            child: Container(
                                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                              decoration: BoxDecoration(
                                                                  color: Color(ColorConfig.color_dcdcdc),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius.circular(10.w), bottomLeft: Radius.circular(10.w))),
                                                              child: pText("离职", ColorConfig.color_ffffff, 20.w),
                                                            ),
                                                          ))
                                                    ],
                                                  ));
                                            });
                                      });
                                }),
                          );
                        }
                      }),
                  pSizeBoxH(50.w),
                ],
              )),
          Positioned(
              bottom: 0,
              child: Row(
                children: [
                  pActionText("重置", ColorConfig.color_666666, 32.w, 250.w, 96.w, () {
                    ctl.selectedStatus.clear();
                    ctl.selectedMerchandisers.clear();
                    ctl.selectedStatus[CanceledEnum.ENABLE] = true; //默认显示选中正常的
                    ctl.onlyOnJob.value = false;
                    ctl.update(['orderStatusSelect']);
                  }, background: ColorConfig.color_ffffff),
                  pActionText("取消", ColorConfig.color_1678ff, 32.w, 250.w, 96.w, () {
                    ctl.personListData = oldPersonListData;
                    ctl.selectedStatus = oldSelectedStatus;
                    ctl.onlyOnJob.value = oldOnlyOnJob.value;
                    ctl.selectedMerchandisers = oldSelectedMerchandisers;
                    ctl.update(['orderStatusSelect']);
                    dialog.dismiss();
                  }, background: ColorConfig.color_efefef),
                  pActionText("确定", ColorConfig.color_ffffff, 32.w, 250.w, 96.w, () {
                    dialog.dismiss();
                    change.call();
                  }, background: ColorConfig.color_1678ff),
                ],
              ))
        ]);
      });
}
