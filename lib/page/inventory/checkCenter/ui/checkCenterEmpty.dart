import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/permission_utils.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/dialog/dialogStartToBegin.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/modules/scheduleItem.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkHistory.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

import 'checkHistory.dart';
import 'checkTitle01.dart';

///空的盘点中心
class CheckCenterEmpty extends StatelessWidget implements CreateInventory {
  CheckCenterEmpty({Key? key}) : super(key: key);
  // CheckCenterEmptyState createState() => CheckCenterEmptyState();
  final int depId = ArgUtils.getArgument2num("depId") as int;
  final ScheduleItem si = new ScheduleItem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckTitle01().appBar(
        context,
        "盘点中心",
        callBack: () => BackUtils.backToNative(),
        actions: [
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "盘点历史",
                textAlign: TextAlign.center,
                style: textStyle(color: ColorConfig.color_999999, size: 28),
              ),
              padding: EdgeInsetsDirectional.only(end: 36.w),
            ),
            onTap: () =>
                Get.toNamed(
                    ArgUtils.map2String(path: Routes.CHECKHIS, arguments: {
                      "depId": depId,
                    })),
          ),
        ],
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      height: 203.w,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text("当前没有进行的盘点任务",
                          style: TextStyle(
                              color: Color(ColorConfig.color_999999),
                              fontSize: 28.w))),
                  SizedBox(
                      height: 20.w,
                      child: Container(color: Color(ColorConfig.color_f5f5f5))),
                  Container(
                    height: 350.w,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(24.w, 30.w, 0, 49.w),
                          child: Text(
                            "盘点3步骤",
                            style: textStyle(
                                color: ColorConfig.color_333333,
                                size: 28,
                                bold: true),
                          ),
                        ),
                        Container(
                          height: 100.w,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: si.schedule(null, 0),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 72.w,
                            width: 200.w,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                            child: Text("开始盘点",
                                textAlign: TextAlign.center,
                                style: textStyle(
                                    size: 28, color: ColorConfig.color_ffffff)),
                            decoration: ShapeDecoration(
                              color: Color(ColorConfig.color_1678FF),
                              shape: StadiumBorder(
                                side: BorderSide(
                                    color: Color(ColorConfig.color_1678FF),
                                    width: 1.w),
                              ),
                            ),
                          ),
                          onTap: () => PermissionUtils.checkPermission(
                                  PermissionUtils.WAREHOUSE_ADD_INVENTORY)
                              .then((value) => _startTask(value)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 20.w,
                      child: Container(
                        color: Color(ColorConfig.color_f5f5f5),
                      )),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.w, top: 30.w),
                          child: Text("提示", style: textStyle(bold: true)),
                        ),
                        _createHintTitle(1, "开始盘点", ""),
                        _createHintContent("开始盘点即对库存快照，生成账面库存", top: 20),
                        _createHintContent("盘点过程中，不要出入库、发货业务，以免造成数据错乱"),
                        _createHintTitle(2, "盘点完成", "(货品盘点完成)"),
                        _createHintContent("点击完成后，可以出入库、发货业务，不会影响盘点数据",
                            top: 20),
                        _createHintContent("不能再新建盘点单，可以修改已录入的盘点数"),
                        _createHintTitle(3, "库存调整", ""),
                        _createHintContent("根据差异，调整库存", top: 20),
                        _createHintContent("不能再修改盘点数"),
                        _createHintTitle(4, "结束盘点", ""),
                        _createHintContent("如果盘点出错了可以撤销调整的盘点，重新创建盘点", top: 20),
                        _createHintContent(""),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  /// 创建提示标题
  Widget _createHintTitle(int step, String title, String richTitle) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, top: 28.w),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Image.asset(
              "images/2.0x/icon_checkcenter_num_$step.png",
              width: 32.w,
              height: 32.w,
              fit: BoxFit.cover,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: textStyle(bold: true),
                ),
                TextSpan(
                  text: richTitle,
                  style: textStyle(color: ColorConfig.color_999999),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 创建提示内容
  Widget _createHintContent(String content, {double top = 18}) {
    return Padding(
      padding: EdgeInsets.only(left: 76.w, top: top.w),
      child: Text(
        content,
        style: textStyle(size: 24, color: ColorConfig.color_999999),
      ),
    );
  }

  @override
  callBack() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["deptId"] = depId;

    CheckApi.checkRecordCreate(map).then((value) {
      Get.offAllNamed(ArgUtils.map2String(
          path: Routes.CHECKING, arguments: {"depId": depId}));
    }, onError: (e) {
      print("flutter:   error1:$e");
    });
  }

  ///开始任务
  _startTask(bool hasPermission) {
    if (hasPermission) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return StartToBeginDialog(this);
        },
      );
    }
  }

}

abstract class CreateInventory {
  callBack();
}
