import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/customer_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget emptyCustomer(SaleEnterController controller) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: pText("+新客户", ColorConfig.color_666666, 28.w),
          onTap: () => Get.toNamed(
            ArgUtils.map2String(
              path: Routes.ADD_CUSTOMER,
              arguments: {
                Constant.DEPT_ID: controller.deptId,
                Constant.ONLINE: controller.online
              },
            ),
          )?.then((value) => controller.updateCustomer(value)),
        ),
        pSizeBoxW(40.w),
        pText("|", ColorConfig.color_dcdcdc, 28.w),
        pSizeBoxW(40.w),
        InkWell(
          child: pText("选择客户", ColorConfig.color_666666, 28.w),
          onTap: () => Get.toNamed(
            ArgUtils.map2String(path: Routes.SEARCH_CUSTOMER, arguments: {
              Constant.DEPT_ID: controller.deptId,
              Constant.ONLINE: controller.online
            }),
          )?.then((value) => controller.updateCustomer(value)),
        ),
        Visibility(
          child: pSizeBoxW(40.w),
          visible: controller.type != SaleEnterController.TYPE_QUOTATION,
        ),
        Visibility(
          child: pText("|", ColorConfig.color_dcdcdc, 28.w),
          visible: controller.type != SaleEnterController.TYPE_QUOTATION,
        ),
        Visibility(
          child: pSizeBoxW(40.w),
          visible: controller.type != SaleEnterController.TYPE_QUOTATION,
        ),
        Visibility(
          child: InkWell(
            child: pText("零售客", ColorConfig.color_666666, 28.w),
            onTap: () => controller.getRetailStoreCustomer(),
          ),
          visible: controller.type != SaleEnterController.TYPE_QUOTATION,
        ),
      ],
    ),
    height: 86.w,
    alignment: Alignment.center,
    color: Colors.white,
    padding: EdgeInsets.only(bottom: 10.w),
  );
}

Widget customerInfo(SaleEnterController controller) {
  var customer = controller.customer;
  var name = customer?.customerName;
  if ((customer?.customerName?.length ?? 0) > 9) {
    name = "${customer?.customerName?.substring(0, 8)}...";
  }
  return Container(
    color: Colors.white,
    child: Stack(
      children: [
        Row(
          children: [
            customerLogo(customer?.customerName, customer?.levelTag),
            pSizeBoxW(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pText(name ?? "", ColorConfig.color_333333, 32.w),
                    pSizeBoxW(24.w),
                    pText(CustomerUtils.encodePhone(customer?.customerPhone),
                        ColorConfig.color_999999, 28.w),
                  ],
                ),
                pSizeBoxH(20.w),
                Visibility(
                  child: customerBalance(customer),
                  visible:
                      controller.type != SaleEnterController.TYPE_OFFLINE_SALE,
                ),
              ],
            ),
          ],
        ),
        Positioned(child: changeBtn(controller), top: 16.w, right: 0,),
      ],
    ),
    padding: EdgeInsets.only(left: 22.w, right: 24.w, top: 14.w, bottom: 30.w),
  );
}

toGoodsList(SaleEnterController controller, int type, String skuMap,
    SaleTypeEnum typeEnum, String id,
    {int? orderId}) {
  controller.updateSelectTab(id, controller.currTab);
  Get.toNamed(
    ArgUtils.map2String(path: Routes.GOODS_LIST, arguments: {
      Constant.DEPT_ID: controller.deptId,
      Constant.CUSTOMER_ID: controller.customer?.id,
      Constant.GOODS_TYPE: type,
      Constant.SELECT_MAP: skuMap,
      Constant.ORDER_ID: orderId,
      Constant.ONLINE: controller.online,
      "level": controller.customer?.levelTag,
    }),
  )?.then((value) => controller.addGoods(typeEnum, value));
}

changeBtn(SaleEnterController controller) {
  return Visibility(
    child: InkWell(
      child: Container(
        height: 42.w,
        width: 82.w,
        child: pText("更换", ColorConfig.color_666666, 24.w),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            color: Color(ColorConfig.color_f5f5f5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.w),
            )),
      ),
      onTap: () => Get.toNamed(
        ArgUtils.map2String(
          path: Routes.SEARCH_CUSTOMER,
          arguments: {
            Constant.DEPT_ID: controller.deptId,
            Constant.ONLINE: controller.online
          },
        ),
      )?.then((value) => controller.updateCustomer(value)),
    ),
    visible: !controller.isEdit,
  );
}

returnBtn(String text, Function function) {
  return InkWell(
    child: Container(
      height: 56.w,
      width: 120.w,
      alignment: Alignment.center,
      child: pText(text, ColorConfig.color_1678FF, 24.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.w),
          side: BorderSide(color: Color(ColorConfig.color_1678FF)),
        ),
      ),
    ),
    onTap: () => function.call(),
  );
}

customerBalance(StoreCustomerListItemDoEntity? customer) {
  return Row(
    children: [
      balanceItem("余额", "¥${PriceUtils.priceString(customer?.balance)}",
          EdgeInsets.zero),
      balanceItem("结欠", "¥${PriceUtils.priceString(customer?.oweAmount)}",
          EdgeInsets.only(left: 34.w)),
      balanceItem(
          "总欠货", "${customer?.oweNum ?? 0}", EdgeInsets.only(left: 34.w)),
    ],
  );
}

balanceItem(String title, String value, EdgeInsets margin) {
  return Container(
    margin: margin,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pText(title, ColorConfig.color_999999, 24.w),
        pText(value, ColorConfig.color_999999, 24.w),
      ],
    ),
  );
}
