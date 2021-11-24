import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

saleList() {
  return GetBuilder<BiGoodsController>(
    builder: (ctl) => SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return item(index, ctl.saleGoodsList[index], ctl);
        },
        childCount: ctl.saleGoodsList.length,
      ),
    ),
    id: BiGoodsController.idSaleList,
  );
}

item(int index, BiSaleGoodsGroupGoodsIdDo data, BiGoodsController controller) {
  int textColor = ColorConfig.color_ffffff;
  switch (index) {
    case 0:
      textColor = ColorConfig.color_FF521F;
      break;
    case 1:
      textColor = ColorConfig.color_FF9228;
      break;
    case 2:
      textColor = ColorConfig.color_FFD02E;
      break;
  }
  return Container(
    child: Row(
      children: [
        Expanded(
          child: clickWidget(
            pText(
              "${index + 1}",
              textColor,
              28.w,
              padding: EdgeInsets.only(left: 30.w),
            ),
            data,
            controller,
            true,
          ),
        ),
        clickWidget(
          NetImageWidget(
            GoodsUtils.getGoodsCover(data.imgPath, data.cover),
            width: 64,
            height: 64,
          ),
          data,
          controller,
          true,
        ),
        clickWidget(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pText(
                data.goodsSerial ?? "",
                ColorConfig.color_ffffff,
                24.w,
                width: 188.w,
                margin: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
              ),
              Visibility(
                child: pSizeBoxH(10.w),
                visible: !controller.singleDept,
              ),
              Visibility(
                child: pText(
                  data.goodsName ?? "",
                  ColorConfig.color_B3FFFFFF,
                  24.w,
                  width: 188.w,
                  margin: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  textAlign: TextAlign.start,
                ),
                visible: !controller.singleDept,
              ),
            ],
          ),
          data,
          controller,
          true,
        ),
        clickWidget(
          pText(
            controller.getItemLeftData(data),
            ColorConfig.color_ffffff,
            24.w,
            width: 120.w,
            alignment: Alignment.centerLeft,
          ),
          data,
          controller,
          false,
        ),
        clickWidget(
          pText(
            controller.getItemRightData(data),
            ColorConfig.color_ffffff,
            24.w,
            width: 200.w,
            alignment: Alignment.centerLeft,
          ),
          data,
          controller,
          false,
        ),
      ],
    ),
    color: Color(ColorConfig.color_393a58),
    height: 124.w,
  );
}

clickWidget(Widget widget, BiSaleGoodsGroupGoodsIdDo data,
    BiGoodsController controller, bool toGoods) {
  return GestureDetector(
    child: widget,
    behavior: HitTestBehavior.opaque,
    onTap: () => toGoods
        ? toGoodsProfile(data, controller)
        : toSkuDetail(data, controller),
  );
}

toGoodsProfile(BiSaleGoodsGroupGoodsIdDo data, BiGoodsController controller) {
  return Get.toNamed(
    ArgUtils.map2String(
      path: Routes.GOODS_PROFILE,
      arguments: {
        Constant.TOP_DEPT_ID: controller.topDeptId,
        Constant.GOODS_ID: data.goodsId,
        Constant.DEPT_ID:
            controller.singleDept ? controller.customerDeptIds[0] : null,
        Constant.START_TIME: controller.startTime,
        Constant.END_TIME: controller.endTime,
      },
    ),
  );
}

toSkuDetail(BiSaleGoodsGroupGoodsIdDo data, BiGoodsController controller) {
  return Get.toNamed(
    ArgUtils.map2String(
      path: Routes.BI_SKU,
      arguments: {
        Constant.TOP_DEPT_ID: controller.topDeptId,
        Constant.GOODS_ID: data.goodsId,
        Constant.DEPT_ID: controller.singleDept ? controller.deptId : null,
      },
    ),
  );
}
