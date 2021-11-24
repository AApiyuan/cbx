import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/discount_template_detail_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/clearance_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/common_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'discount_widget.dart';

// ignore: must_be_immutable
class MoreDiscountWidget extends StatelessWidget {
  List<SaleDetailDoSaleGoodsList> goodsList;
  List<int> selectList = [];
  late BuildContext _context;

  MoreDiscountWidget(this.goodsList);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(
      children: [
        listWidget(),
        Container(color: Color(ColorConfig.color_efefef), height: 1.w),
        bottomWidget(),
      ],
    );
  }

  listWidget() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) => Expanded(
        child: ListView.separated(
          itemBuilder: (_, index) => listItem(ctl, goodsList[index]),
          itemCount: goodsList.length,
          separatorBuilder: (context, index) => Container(
            color: Color(ColorConfig.color_efefef),
            height: 16.w,
          ),
        ),
      ),
      id: SaleEnterController.idDiscountGoodsList,
    );
  }

  listItem(
      SaleEnterController controller, SaleDetailDoSaleGoodsList saleGoods) {
    var storeGoods = saleGoods.storeGoods;
    var goodsImage =
        GoodsUtils.getGoodsCover(storeGoods?.imgPath, storeGoods?.cover);
    var goodsName = GoodsUtils.getGoodsTitle(
        storeGoods?.goodsSerial, storeGoods?.goodsName);
    var priceText = initPriceText(controller, saleGoods, storeGoods!);
    return Row(
      children: [
        InkWell(
          child: Container(
            child: pImage(
                selectList.contains(storeGoods.id)
                    ? "images/icon_select_on.png"
                    : "images/icon_select_off.png",
                38.w,
                38.w),
            padding: EdgeInsets.only(left: 24.w, right: 20.w),
          ),
          onTap: () {
            if (selectList.contains(storeGoods.id)) {
              selectList.remove(storeGoods.id);
            } else {
              selectList.add(storeGoods.id!);
            }
            controller.update([
              SaleEnterController.idDiscountGoodsList,
              SaleEnterController.idDiscountSelectAll,
              SaleEnterController.idDiscountSelectAllText,
            ]);
          },
        ),
        NetImageWidget(goodsImage, width: 160, height: 160),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pText(goodsName, ColorConfig.color_333333, 28.w,
                  fontWeight: FontWeight.bold, width: 450.w),
              Container(
                child: pText(priceText, ColorConfig.color_999999, 28.w, textAlign: TextAlign.start),
                width: 480.w,
              ),
              pText(
                "售${controller.saleSelectMap[saleGoods.goodsId!] ?? 0}",
                ColorConfig.color_1678FF,
                32.w,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          height: 200.w,
          padding: EdgeInsets.only(left: 16.w, top: 20.w, bottom: 20.w),
        ),
      ],
    );
  }

  initPriceText(
      SaleEnterController controller,
      SaleDetailDoSaleGoodsList saleGoods,
      SaleDetailDoSaleGoodsListStoreGoods storeGoods) {
    var priceText;
    var discountEnum = EnumCoverUtils.stringToEnums(
        saleGoods.discountType, SaleGoodsDiscountTypeEnum.values);
    if (discountEnum == SaleGoodsDiscountTypeEnum.CHANGE_PRICE) {
      priceText = "改${PriceUtils.getPrice(saleGoods.price)}";
    } else if (discountEnum == SaleGoodsDiscountTypeEnum.REBATE) {
      priceText =
          "折${PriceUtils.priceString(saleGoods.discount)} x ${PriceUtils.getPrice(saleGoods.salePrice)}";
    } else if (discountEnum == SaleGoodsDiscountTypeEnum.TEMPLATE) {
      priceText =
          "清仓${PriceUtils.getPrice(saleGoods.discountTemplateDetail?.totalPrice)}/${saleGoods.discountTemplateDetail?.enableNum ?? 0}件";
    } else {
      priceText = "${PriceUtils.getPrice(controller.getGoodsPrice(saleGoods))}";
    }
    var receivableAmount = controller.getReceivableAmount(storeGoods.id!);
    priceText = "$priceText  |  总额${PriceUtils.getPrice(receivableAmount)}";
    return priceText;
  }

  bottomWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GetBuilder<SaleEnterController>(
          builder: (ctl) => InkWell(
            onTap: () {
              if (goodsList.length == selectList.length) {
                selectList.clear();
              } else {
                selectList.clear();
                goodsList
                    .forEach((element) => selectList.add(element.goodsId!));
              }
              ctl.update([
                SaleEnterController.idDiscountGoodsList,
                SaleEnterController.idDiscountSelectAll,
                SaleEnterController.idDiscountSelectAllText,
              ]);
            },
            child: Container(
              child: pImage(
                  goodsList.length == selectList.length
                      ? "images/icon_select_on.png"
                      : "images/icon_select_off.png",
                  38.w,
                  38.w),
              padding: EdgeInsets.only(left: 24.w, right: 16.w),
            ),
          ),
          id: SaleEnterController.idDiscountSelectAll,
        ),
        GetBuilder<SaleEnterController>(
          builder: (ctl) => pText(
              goodsList.length == selectList.length ? "全不选" : "全选",
              ColorConfig.color_333333,
              24.w),
          id: SaleEnterController.idDiscountSelectAllText,
        ),
        Expanded(child: Container()),
        GetBuilder<SaleEnterController>(
          builder: (ctl) => InkWell(
            child: Container(
              child: pText("批量打折", ColorConfig.color_1678FF, 32.w),
              alignment: Alignment.center,
              height: 84.w,
              width: 240.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                  side: BorderSide(color: Color(ColorConfig.color_1678FF)),
                ),
              ),
              margin: EdgeInsets.only(top: 18.w, bottom: 18.w, right: 20.w),
            ),
            onTap: () {
              if (selectList.isEmpty) {
                toastMsg("请选择货品");
                return;
              }
              showRebateDialog(
                  _context, 0, (discount) => rebate(discount, ctl));
            },
          ),
        ),
        GetBuilder<SaleEnterController>(
          builder: (ctl) => InkWell(
            child: Container(
              child: pText("批量清仓", ColorConfig.color_ffffff, 32.w),
              alignment: Alignment.center,
              height: 84.w,
              width: 240.w,
              decoration: ShapeDecoration(
                color: Color(ColorConfig.color_1678FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                ),
              ),
              margin: EdgeInsets.only(top: 18.w, bottom: 18.w, right: 29.w),
            ),
            onTap: () {
              if (selectList.isEmpty) {
                toastMsg("请选择货品");
                return;
              }
              // getDiscountTemplate(ctl);
              ctl.getDiscountTemplate().then((value) => showClearanceDialog(value, ctl));
            },
          ),
        ),
      ],
    );
  }

  rebate(int discount, SaleEnterController controller) {
    Map<int, int> map = {};
    selectList.forEach((goodsId) {
      var saleGoods =
          goodsList.firstWhere((element) => element.goodsId == goodsId);
      saleGoods.discountType =
          EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.REBATE);
      saleGoods.discount = discount;
      map[goodsId] = controller.saleSelectMap[goodsId] ?? 0;
    });
    controller.updateSaleGoodsCount(map);
    controller.update([
      SaleEnterController.idDiscountGoodsList,
      SaleEnterController.idDiscountSelectAll,
      SaleEnterController.idDiscountSelectAllText,
    ]);
  }

  template(
      StoreDiscountTemplateDo templateDetail, SaleEnterController controller) {
    Map<int, int> map = {};
    selectList.forEach((goodsId) {
      var saleGoods =
          goodsList.firstWhere((element) => element.goodsId == goodsId);
      saleGoods.discountType =
          EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.TEMPLATE);
      saleGoods.discountTemplateDetail =
          DiscountTemplateDetailEntity().fromJson(templateDetail.toJson());
      saleGoods.discountTemplateId = templateDetail.id;
      map[goodsId] = controller.saleSelectMap[goodsId] ?? 0;
    });
    controller.updateSaleGoodsCount(map);
    controller.update([
      SaleEnterController.idDiscountGoodsList,
      SaleEnterController.idDiscountSelectAll,
      SaleEnterController.idDiscountSelectAllText,
    ]);
  }

  showClearanceDialog(
      List<StoreDiscountTemplateDo> data, SaleEnterController ctl) {
    CommonDialog(
      "批量清仓",
      ClearanceWidget(data, (templateDetail) => template(templateDetail, ctl)),
    ).showBottom(_context);
  }

  // getDiscountTemplate(SaleEnterController controller) {
  //   var param = StoreDiscountTemplateReq();
  //   param.status = Status.ENABLE;
  //   param.style = StoreDiscountTemplateEnum.CLEARANCE;
  //   param.customerDeptId = controller.deptId;
  //   StoreDiscountTemplateApi.getDiscountTemplate(param)
  //       .then((value) => showClearanceDialog(value, controller));
  // }

  clearDiscount(SaleEnterController controller) {
    Map<int, int> map = {};
    goodsList.forEach((element) {
      element.discountType =
          EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.NONE);
      element.discount = 0;
      element.discountTemplateDetail = null;
      element.discountTemplateId = -1;
      element.price = null;
      map[element.goodsId!] = controller.saleSelectMap[element.goodsId!] ?? 0;
    });
    controller.updateSaleGoodsCount(map);
    controller.update([
      SaleEnterController.idDiscountGoodsList,
      SaleEnterController.idDiscountSelectAll,
      SaleEnterController.idDiscountSelectAllText,
    ]);
  }
}
