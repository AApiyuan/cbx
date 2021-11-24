import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/checkCreateController.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkCenterEmpty.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

/**
 * 弹窗：开始盘点
 */
// ignore: must_be_immutable
class StartToBeginDialog extends Dialog {
  CheckCenterEmpty checkCenterEmptyState;
  CheckCenterController mCheckCenterController = new CheckCenterController();

  StartToBeginDialog(this.checkCenterEmptyState);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(ColorConfig.color_88000000),
      alignment: Alignment.center,
      child: Container(
        height: 468.w,
        width: 550.w,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(30.w),
            ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 54.w, 0, 0),
              alignment: Alignment.center,
              child: Text("确定开始盘点任务吗？",
                  style: textStyle(
                      size: 32, color: ColorConfig.color_333333, bold: true)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50.w, 36.w, 50.w, 0),
              child: Text("开始盘点即对库存快照，生成账面库存",
                  style: textStyle(size: 32, color: ColorConfig.color_999999)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50.w, 20.w, 50.w, 0),
              child: Text("盘点过程中，不要出入库、发货业务，以免造成数据错乱",
                  style: textStyle(size: 32, color: ColorConfig.color_999999)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40.w, 0, 0),
              color: Color(ColorConfig.color_efefef),
              height: 1.w,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsetsDirectional.only(top: 15.w, bottom: 15.w),
                        child: Text("取消",
                            style: textStyle(
                              color: ColorConfig.color_999999,
                              size: 32,
                              bold: true,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  Container(color: Color(ColorConfig.color_efefef), width: 1.w),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsetsDirectional.only(top: 15.w, bottom: 15.w),
                        child: Text("确定",
                            style: textStyle(
                                color: ColorConfig.color_1678FF,
                                size: 32,
                                bold: true),
                            textAlign: TextAlign.center),
                        color: Colors.transparent,
                      ),
                      onTap: () {
                        checkCenterEmptyState.callBack();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
