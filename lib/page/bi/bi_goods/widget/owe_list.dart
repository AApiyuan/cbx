import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_owe_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_do_entity.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

oweList() {
  return GetBuilder<BiGoodsOweController>(
    builder: (ctl) => SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return item(index, ctl.listData[index], ctl);
        },
        childCount: ctl.listData.length,
      ),
    ),
    id: BiGoodsOweController.idOweList,
  );
}

item(int index, BiGoodsStockDoEntity data, BiGoodsOweController controller) {
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
          child: GestureDetector(
            child: pText(
              "${index + 1}",
              textColor,
              28.w,
              padding: EdgeInsets.only(left: 20.w),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () => toGoodsProfile(data, controller),
          ),
        ),
        GestureDetector(
          child: NetImageWidget(
            GoodsUtils.getGoodsCover(data.imgPath, data.cover),
            width: 64,
            height: 64,
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () => toGoodsProfile(data, controller),
        ),
        GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pText(
                data.goodsSerial ?? "",
                ColorConfig.color_ffffff,
                24.w,
                width: 164.w,
                padding: EdgeInsets.only(left: 16.w),
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
                  width: 164.w,
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  textAlign: TextAlign.start,
                ),
                visible: !controller.singleDept,
              ),
            ],
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () => toGoodsProfile(data, controller),
        ),
        GestureDetector(
          child: textItem("${data.stockNum}", 130.w),
          behavior: HitTestBehavior.opaque,
          onTap: () => toSkuDetail(data, controller),
        ),
        GestureDetector(
          child: textItem("${data.substandardNum}", 130.w),
          behavior: HitTestBehavior.opaque,
          onTap: () => toSkuDetail(data, controller),
        ),
        GestureDetector(
          child: textItem("${data.shortageNum ?? 0}", 88.w),
          behavior: HitTestBehavior.opaque,
          onTap: () => toSkuDetail(data, controller),
        ),
        GestureDetector(
          child: pImage("images/right.png", 16.w, 16.w),
          behavior: HitTestBehavior.opaque,
          onTap: () => toSkuDetail(data, controller),
        ),
        GestureDetector(
          child: pSizeBoxW(30.w),
          behavior: HitTestBehavior.opaque,
          onTap: () => toSkuDetail(data, controller),
        ),
      ],
    ),
    color: Color(ColorConfig.color_393a58),
    height: 124.w,
  );
}

textItem(String text, double width) {
  return pText(
    text,
    ColorConfig.color_ffffff,
    24.w,
    width: width,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10.w),
  );
}

toGoodsProfile(BiGoodsStockDoEntity data, BiGoodsOweController controller) {
  return Get.toNamed(
    ArgUtils.map2String(
      path: Routes.GOODS_PROFILE,
      arguments: {
        Constant.TOP_DEPT_ID: controller.topDeptId,
        Constant.GOODS_ID: data.goodsId,
        Constant.DEPT_ID:
            controller.singleDept ? controller.customerDeptIds[0] : null,
      },
    ),
  );
}

toSkuDetail(BiGoodsStockDoEntity data, BiGoodsOweController controller) {
  return Get.toNamed(
    ArgUtils.map2String(
      path: Routes.BI_SKU,
      arguments: {
        Constant.TOP_DEPT_ID: controller.topDeptId,
        Constant.GOODS_ID: data.goodsId,
        Constant.DEPT_ID:
            controller.singleDept ? controller.customerDeptIds[0] : null,
      },
    ),
  );
}
