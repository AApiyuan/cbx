import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/button.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ClearanceWidget extends StatelessWidget {
  List<StoreDiscountTemplateDo> list;
  Function(StoreDiscountTemplateDo) selFunction;
  static const NOT_SELECT = -1;
  var _selectId = NOT_SELECT.obs;

  ClearanceWidget(this.list, this.selFunction);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: pText(
            "使用同一模板的货品，数量加在一起参与优惠计算",
            ColorConfig.color_FF5D1E,
            24.w,
          ),
          height: 48.w,
          alignment: Alignment.center,
          color: Color(ColorConfig.color_FFFCD9),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.w, top: 36.w, bottom: 20.w),
          child: pText(
            "清仓模板",
            ColorConfig.color_333333,
            28.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: list.map((e) => listItem(e)).toList(),
            mainAxisSpacing: 20.w,
            crossAxisSpacing: 20.w,
            childAspectRatio: 336.w / 185.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
          ),
        ),
        Container(
          color: Color(ColorConfig.color_efefef),
          height: 1.w,
        ),
        // Container(
        //   child: bottomBtn(
        //     "确定",
        //         () {
        //       if (_selectId.value == NOT_SELECT) {
        //         toastMsg("请选择清仓模板");
        //         return;
        //       }
        //       selFunction.call(
        //           list.firstWhere((element) => element.id == _selectId.value));
        //       Get.back();
        //     },
        //     margin:
        //     EdgeInsets.only(top: 16.w, bottom: 16.w, left: 24.w, right: 24.w),
        //   ),
        //   height: 128.w,
        // ),
        GestureDetector(
          child: Container(
            decoration: ShapeDecoration(
              color: Color(ColorConfig.color_1678FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.w),
              ),
            ),
            height: 96.w,
            margin: EdgeInsets.only(top: 16.w, bottom: 16.w, left: 24.w, right: 24.w),
            alignment: Alignment.center,
            child: pText("确定", ColorConfig.color_ffffff, 32.w),
          ),
          onTap: () {
            if (_selectId.value == NOT_SELECT) {
              toastMsg("请选择清仓模板");
              return;
            }
            selFunction.call(
                list.firstWhere((element) => element.id == _selectId.value));
            Get.back();
          },
        )
      ],
    );
  }

  Widget listItem(StoreDiscountTemplateDo templateDo) {
    return Stack(
      children: [
        GestureDetector(
          child: Obx(() => pImage(
              _selectId.value == templateDo.id
                  ? "images/ic_discount_template_selected.png"
                  : "images/ic_discount_template.png",
              336.w,
              185.w)),
          onTap: () => _selectId.value = templateDo.id!,
        ),
        Container(
          height: 185.w,
          width: 336.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pText(
                      PriceUtils.getPrice(templateDo.totalPrice),
                      ColorConfig.color_FF7113,
                      36.w,
                    ),
                    pText("/${templateDo.enableNum}件", ColorConfig.color_999999,
                        24.w),
                  ],
                ),
                margin: EdgeInsets.only(top: 25.w),
              ),
              Container(
                child: pText(
                    "不满${templateDo.enableNum}件，每件${PriceUtils.getPrice(templateDo.discountPrice)}",
                    ColorConfig.color_999999,
                    24.w),
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 30.w),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
