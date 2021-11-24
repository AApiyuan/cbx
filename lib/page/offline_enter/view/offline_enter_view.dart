import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';
import 'package:haidai_flutter_module/page/offline_enter/controller/offline_enter_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflineEnterView extends GetView<OfflineEnterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfflineEnterController>(
        id: "TransferPage",
        builder: (ctl) {
          return FutureBuilder(
              future: ctl.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Color(ColorConfig.color_ffffff));
                } else {
                  return Scaffold(
                    backgroundColor: Color(ColorConfig.color_f5f5f5),
                    appBar: pAppBar(
                      "断网开单收款",
                      back: true,
                      type: 2,
                    ),
                    body: Column(children: [
                      Container(
                        height: 20.w,
                        width: 750.w,
                        color: Color(ColorConfig.color_282940),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 41.w,
                            width: 750.w,
                            color: Color(ColorConfig.color_282940),
                          ),
                          Positioned(
                            child: Column(
                              children: [
                                Center(
                                  child: pImage(
                                      "images/offline_img.png", 702.w, 82.w),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      GetBuilder<OfflineEnterController>(
                          id: "InventoryEntry",
                          builder: (ctl) {
                            if(true){
                              List<Widget> widgets = [userInfo(ctl), deptHint()];

                              if(ctl.list.length > 0){
                                widgets.addAll(ctl.list.map((e) => shopItem(e)).toList());
                              }else{
                                widgets.add(emptyWidget(bgColor: ColorConfig.color_f5f5f5));
                              }

                              return  Expanded(
                                  child: ListView(children: widgets),
                              );
                            }else{
                              return Expanded(child:SliverToBoxAdapter(
                                  child: Center(child: emptyWidget(bgColor: ColorConfig.color_00000000))) );
                            }

                          })





                    ]),
                  );
                }
              });
        });
  }

  Widget shopItem(CustomerDeptDetailAndRoleDo deptDetail) {
    return GestureDetector(
      child: Container(
        height: 118.w,
        margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.w),
        decoration: new BoxDecoration(
            color: Color(ColorConfig.color_ffffff),
            borderRadius: new BorderRadius.circular((20.w))),
        child: Row(
          children: [
            pSizeBoxW(20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                pSizeBoxW(20.w),
                pText(
                  deptDetail.name ?? "",
                  ColorConfig.color_333333,
                  28.w,
                ),
                pSizeBoxH(14.w),
                Stack(
                  children: [
                    pImage("images/support_img.png", 105.w, 28.w),
                    Positioned(
                      child: Column(
                        children: [
                          Center(
                            child: pText(
                                '支持断网', ColorConfig.color_1ca2ff, 20.w,
                                width: 105.w),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            pImage("images/into_icon.png", 24.w, 24.w),
            pSizeBoxW(20.w),
          ],
        ),
      ),
      onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.HANG_ORDER_WORKBENCH, arguments: {
        Constant.DEPT_ID: deptDetail.id,
        Constant.ONLINE: false,
      })),
    );
  }

  userInfo(OfflineEnterController ctl) {
    return Container(
      height: 83.w,
      margin: EdgeInsets.only(
          left: 24.w, right: 24.w, top: 30.w),
      decoration: new BoxDecoration(
          color: Color(ColorConfig.color_ffffff),
          borderRadius:
          new BorderRadius.circular((20.w))),
      child: Row(
        children: [
          pSizeBoxW(20.w),
          pText('当前账号', ColorConfig.color_333333, 28.w,
              fontWeight: FontWeight.bold),
          Expanded(child: SizedBox()),
          pText("${ctl.userName}-${ctl.userPhone}",
              ColorConfig.color_333333, 28.w,
              fontWeight: FontWeight.bold),
          pSizeBoxW(20.w),
        ],
      ),
    );
  }

  deptHint() {
    return Container(
      // height: 83.w,
      margin: EdgeInsets.only(
          left: 24.w, right: 24.w, top: 30.w),
      decoration: new BoxDecoration(
        // color: Color(ColorConfig.color_ffffff),
          borderRadius:
          new BorderRadius.circular((20.w))),
      child: Row(
        children: [
          pText('离线保障店铺', ColorConfig.color_999999, 24.w),
          Expanded(child: SizedBox()),
          pSizeBoxW(20.w),
        ],
      ),
    );
  }
}
