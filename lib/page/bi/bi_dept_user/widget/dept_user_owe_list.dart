import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptUserOweList() {
  return GetBuilder<BiDeptUserController>(
      id: "deptUserOweList",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0.w, 0.w, 0.w, 24.w),
            margin: EdgeInsets.only(bottom: 20.w, top: 20.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30.w, left: 30.w),
                  alignment: Alignment.centerLeft,
                  child: pText("欠货欠款", ColorConfig.color_ffffff, 32.w),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  margin: EdgeInsets.only(top: 34.w),
                  height: 44.w,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    children: [
                      Container(
                        width: 70.w,
                        alignment: Alignment.centerLeft,
                        child: pText("序号", 0xb3ffffff, 24.w),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: pText("店员", 0xb3ffffff, 24.w),
                      )),
                      sortTitleButton(ctl, "单据结欠", "orderOweAmount"),
                      sortTitleButton(ctl, "客户余额", "balance"),
                      sortTitleButton(ctl, "欠货", "shortageNum", width: 80),
                      pSizeBoxW(16.w)
                    ],
                  ),
                ),
                Container(
                    child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  //解决无限高度问题
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                      Get.toNamed(ArgUtils.map2String(
                        path: Routes.DEPT_USER_PROFILE,
                        arguments: {
                          Constant.DEPT_USER_ID: ctl.customerGroupDeptUsers[index].merchandiserId,
                          Constant.DEPT_ID: ctl.customerGroupDeptUsers[index].deptId,
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.START_TIME:ctl.statisticStartTime,
                          Constant.END_TIME:ctl.statisticEndTime,
                        },
                      ));
                    },
                    child:  Container(
                      padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                      margin: EdgeInsets.only(left: 30.w, right: 30.w),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.w,
                                  color: index != ctl.customerGroupDeptUsers.length - 1 ? Color.fromRGBO(255, 255, 255, 0.1) : Colors.transparent))),
                      child: Row(
                        children: [
                          Container(
                            width: 70.w,
                            alignment: Alignment.centerLeft,
                            child: pText((index + 1).toString(),
                                index == 0 ? 0xFFFF521F : (index == 1 ? 0xFFFF9228 : (index == 2 ? 0xFFFFD02E : ColorConfig.color_ffffff)), 28.w,
                                fontFamily: "Roboto"),
                          ),
                          Expanded(
                              child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText(ctl.customerGroupDeptUsers[index].merchandiserName.toString(), ColorConfig.color_ffffff, 24.w),
                                Visibility(
                                  visible: ctl.deptId==null,
                                  child: pSizeBoxH(5.w),
                                ),
                                Visibility(
                                  visible: ctl.deptId==null,
                                  child: pText(ctl.customerGroupDeptUsers[index].deptName.toString(), 0xb3ffffff, 24.w),
                                )
                              ],
                            ),
                          )),
                          Container(
                            width: 150.w,
                            alignment: Alignment.centerLeft,
                            child: pText((ctl.customerGroupDeptUsers[index].orderOweAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                          ),
                          Container(
                            width: 150.w,
                            alignment: Alignment.centerLeft,
                            child: pText((ctl.customerGroupDeptUsers[index].balance! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                          ),
                          Container(
                            width: 80.w,
                            alignment: Alignment.centerLeft,
                            child: pText((ctl.customerGroupDeptUsers[index].shortageNum).toString(), ColorConfig.color_ffffff, 24.w),
                          ),
                          pImage("images/right.png", 16.w, 16.w)
                        ],
                      ),
                    ));
                  },
                  itemCount: ctl.customerGroupDeptUsers.length,
                ))
              ],
            ));
      });
}

Widget sortTitleButton(BiDeptUserController ctl, String name, String filed, {int width = 150}) {
  return GestureDetector(
      onTap: () {
        if (ctl.oweOrderByField == filed) {
          if (ctl.oweOrderBy == "DESC") {
            ctl.oweOrderBy = "ASC";
          } else if (ctl.oweOrderBy == "ASC") {
            ctl.oweOrderBy = "DESC";
          }
        } else {
          ctl.oweOrderByField = filed;
          ctl.oweOrderBy = "DESC";
        }
        ctl.oweSort();
      },
      child: Container(
        width: width.w,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            pText(name, ctl.oweOrderByField == filed ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
            pImage(ctl.oweOrderByField == filed ? (ctl.oweOrderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png") : "images/no_sort.png",
                24.w, 24.w)
          ],
        ),
      ));
}
