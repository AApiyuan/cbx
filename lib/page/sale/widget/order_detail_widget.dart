import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/sale/CalculateSaleAmountUtil.dart';
import 'package:haidai_flutter_module/common/sale/CalculateSaleBeforeAmountUtil.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/order_item_model.dart';
import 'package:haidai_flutter_module/page/sale/widget/discount_widget.dart';
import 'package:haidai_flutter_module/page/sale/widget/warehouse_list_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/common_dialog.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class OrderDetail extends StatelessWidget {
  StoreCustomerListItemDoEntity? customer; //用户
  var orderItemList = <OrderItemModel>[]; //数据
  var type; //类型
  var checkAmount; //核销金额
  CreateSaleReq? saleReq; //销售单数据
  CreateSaleBeforeReq? saleBeforeReq; //报价单数据
  var wipeZero = 0.obs; //抹零通知
  var receivableAmount = 0.obs; //剩余通知
  var balanceAmount = 0.obs; //应收通知
  var customTime = DateTime.now().obs; //时间通知
  List<CustomerDeptRelationDo>? warehouseList; //配货仓列表
  var warehouse = CustomerDeptRelationDo().obs; //配货仓通知
  var warehouseVisible = true.obs; //显示配货仓通知
  Function? updateFunction; //更新回调
  var edit; //是否是编辑

  OrderDetail(this.orderItemList, this.saleReq, this.saleBeforeReq, this.type,
      {this.customer,
      this.checkAmount = 0,
      this.updateFunction,
      this.edit = false,
      this.warehouseList}) {
    initFun();
  }

  /// 初始化回调
  initFun() {
    wipeZero.value = req.wipeOffAmount ?? 0;
    receivableAmount.value = req.taxReceivableAmount ?? 0;
    balanceAmount.value = req.balanceAmount ?? 0;
    customTime.value = req.customizeTime ?? DateTime.now();
    warehouse.value = warehouseList?.firstWhere(
            (element) => element.relationDeptId == req.warehouseId,
            orElse: () => CustomerDeptRelationDo()) ??
        CustomerDeptRelationDo();
    wipeZero.listen((value) {
      if (type == SaleEnterController.TYPE_QUOTATION) {
        CalculateSaleBeforeAmountUtil.calculateSaleAmount(req, checkAmount);
      } else {
        CalculateSaleAmountUtil.calculateSaleAmount(req, checkAmount);
      }
      receivableAmount.value = req.taxReceivableAmount ?? 0;
      balanceAmount.value = req.balanceAmount ?? 0;
      updateFunction?.call();
    });
    if (saleReq?.delivery ?? false) {
      warehouseVisible.toggle();
    }
  }

  get req {
    if (type == SaleEnterController.TYPE_QUOTATION) {
      return saleBeforeReq;
    } else {
      return saleReq;
    }
  }

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            customerInfo(),
            visibleWidget(customerBalance(),
                type != SaleEnterController.TYPE_OFFLINE_SALE),
            pSizeBoxH(10.w),
            orderItem(0),
            orderItem(1),
            orderItem(2),
            remarkWidget(),
            totalReceivables(),
            visibleWidget(
                taxWidget(), type == SaleEnterController.TYPE_QUOTATION),
            _wipeZero(),
            visibleWidget(
                verification(), type == SaleEnterController.TYPE_SALE),
            pSizeBoxH(15.w),
            residueReceivables(),
            pSizeBoxH(20.w),
            visibleWidget(
                Container(color: Color(ColorConfig.color_f5f5f5), height: 12.w),
                type != SaleEnterController.TYPE_QUOTATION),
            visibleWidget(
                deliverGoods(), type == SaleEnterController.TYPE_SALE),
            visibleWidget(_warehouse(), type == SaleEnterController.TYPE_SALE),
            visibleWidget(orderDate(), type == SaleEnterController.TYPE_SALE),
            pSizeBoxH(112.w),
          ],
        ),
      ),
      color: Colors.white,
    );
  }

  visibleWidget(Widget content, bool visible) {
    return Visibility(child: content, visible: visible);
  }

  customerInfo() {
    return Visibility(
      child: Container(
        child: Row(
          children: [
            customerLogo(customer?.customerName, customer?.levelTag),
            pSizeBoxW(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pText(customer?.customerName ?? "", ColorConfig.color_333333,
                    32.w),
                pSizeBoxH(20.w),
                pText(customer?.customerPhone ?? "", ColorConfig.color_999999,
                    28.w),
              ],
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 22.w),
      ),
      visible: customer != null,
    );
  }

  customerBalance() {
    return Visibility(
      child: Container(
        height: 64.w,
        margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 4.w),
        child: Row(
          children: [
            balanceItem("余额", "¥${PriceUtils.priceString(customer?.balance)}",
                MainAxisAlignment.start, EdgeInsets.only(left: 16.w)),
            balanceItem("结欠", "¥${PriceUtils.priceString(customer?.oweAmount)}",
                MainAxisAlignment.center, EdgeInsets.zero),
            balanceItem("总欠货", "${customer?.oweNum ?? 0}",
                MainAxisAlignment.end, EdgeInsets.only(right: 19.w)),
          ],
        ),
        decoration: ShapeDecoration(
          color: Color(ColorConfig.color_FAFAFA),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        ),
      ),
      visible: customer != null,
    );
  }

  balanceItem(String title, String value, MainAxisAlignment alignment,
      EdgeInsets margin) {
    return Expanded(
      child: Container(
        margin: margin,
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            pText(title, ColorConfig.color_999999, 24.w),
            pText(value, ColorConfig.color_282940, 24.w),
          ],
        ),
      ),
    );
  }

  orderItem(int index) {
    if (index >= orderItemList.length) {
      return Container(height: 0);
    }
    var orderItem = orderItemList[index];
    var textColor;
    switch (orderItem.type) {
      case SaleTypeEnum.CHANGE_BACK_ORDER:
        textColor = ColorConfig.color_FF7314;
        break;
      case SaleTypeEnum.RETURN_GOODS:
        textColor = ColorConfig.color_ff3715;
        break;
      case SaleTypeEnum.NORMAL_SALE:
        textColor = ColorConfig.color_1678FF;
        break;
    }
    return Container(
      height: 104.w,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        children: [
          goodsCover(orderItem.getCover(0)),
          pSizeBoxW(10.w),
          goodsCover(orderItem.getCover(1)),
          pSizeBoxW(10.w),
          goodsCover(orderItem.getCover(2)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                pText(orderItem.goodsCountText(), textColor, 32.w,
                    fontWeight: FontWeight.bold),
                pText(orderItem.goodsStylePriceText(), ColorConfig.color_999999,
                    24.w),
              ],
            ),
          )
        ],
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        color: Color(ColorConfig.color_FAFAFA),
      ),
    );
  }

  goodsCover(String? url) {
    if (url == null) {
      return Container(width: 0);
    }
    return NetImageWidget(
      url,
      width: 72,
      height: 72,
      radius: 4,
      clickEnable: false,
    );
  }

  remarkWidget() {
    return Container(
      margin: EdgeInsets.only(left: 30.w, top: 20.w, right: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pText("备注", ColorConfig.color_333333, 28.w),
          pSizeBoxH(9.w),
          Container(
            // padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 6.w, bottom: 6.w),
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              style: textStyle(size: 24, color: ColorConfig.color_F3AE1F),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) => req.remark = text,
              maxLength: 50,
              maxLines: 2,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: req.remark ?? "",
                  selection: TextSelection.fromPosition(
                    TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: req.remark?.length ?? 0,
                    ),
                  ),
                ),
              ),
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              color: Color(ColorConfig.color_FAFAFA),
            ),
          )
        ],
      ),
    );
  }

  totalReceivables() {
    return Container(
      height: 58.w,
      margin: EdgeInsets.only(top: 15.w, left: 30.w, right: 30.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          pText("合计应收", ColorConfig.color_333333, 28.w),
          Expanded(
            child: Obx(
              () => pText(PriceUtils.getPrice(receivableAmount.value),
                  ColorConfig.color_333333, 28.w,
                  fontWeight: FontWeight.bold, textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }

  _wipeZero() {
    return Container(
      height: 58.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        children: [
          pText("已抹零", ColorConfig.color_333333, 28.w),
          Expanded(child: Container()),
          Visibility(
            child: InkWell(
              child: Container(
                height: 42.w,
                width: 74.w,
                margin: EdgeInsets.only(right: 10.w),
                alignment: Alignment.center,
                child: pText("抹零", ColorConfig.color_1678FF, 24.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(ColorConfig.color_1678ff),
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                ),
              ),
              onTap: () => showWipeZero(
                context,
                req.wipeOffAmount ?? 0,
                (wipeZeroValue) {
                  req.wipeOffAmount = wipeZeroValue;
                  wipeZero.value = wipeZeroValue;
                },
              ),
            ),
            visible: true,
          ),
          Obx(
            () => Container(
              child: pText(PriceUtils.getPrice(wipeZero.value),
                  ColorConfig.color_333333, 28.w,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  verification() {
    return Container(
      height: 58.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        children: [
          pText("已核销", ColorConfig.color_333333, 28.w),
          Expanded(child: Container()),
          pText(
              PriceUtils.getPrice(checkAmount), ColorConfig.color_333333, 28.w,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  residueReceivables() {
    return Obx(
      () {
        int price = balanceAmount.value;
        int color =
            price >= 0 ? ColorConfig.color_333333 : ColorConfig.color_FF3715;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            pText(price >= 0 ? "剩余应收" : "剩余应退", color, 24.w),
            pSizeBoxW(10.w),
            pText(PriceUtils.getPrice(price), color, 42.w),
            pSizeBoxW(30.w),
          ],
        );
      },
    );
  }

  deliverGoods() {
    return Container(
      height: 81.w,
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 32.w),
      child: Row(
        children: [
          pText("现场发货", ColorConfig.color_999999, 28.w),
          Expanded(
            child: pText("自动生成发货单扣库存", ColorConfig.color_999999, 28.w,
                textAlign: TextAlign.end),
          ),
          pSizeBoxW(15.w),
          Transform.scale(
            scale: 1,
            child: AbsorbPointer(
              child: Obx(
                () => pSwitch(
                  value: !warehouseVisible.value,
                  onChanged: (change) {
                    saleReq?.delivery = change;
                    warehouseVisible.toggle();
                    req.warehouseId = null;
                    warehouse.value = CustomerDeptRelationDo();
                  },
                ),
              ),
              absorbing: false,
            ),
          ),
        ],
      ),
    );
  }

  orderDate() {
    return Container(
      height: 81.w,
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 21.w),
      child: AbsorbPointer(
        child: InkWell(
          child: Row(
            children: [
              pText("单据日期", ColorConfig.color_999999, 28.w),
              Expanded(
                child: Obx(
                  () => pText(TimeUtils.getTime(customTime.value),
                      ColorConfig.color_999999, 28.w,
                      textAlign: TextAlign.end),
                ),
              ),
              Visibility(
                child: pImage("images/icon_goto.png", 23.w, 23.w),
                visible: !edit,
              ),
            ],
          ),
          onTap: () => showCupertinoModalBottomSheet(
            context: Get.context!,
            animationCurve: Curves.easeIn,
            builder: (context) => DatePick(
                initialSelectedDate: req.customizeTime,
                onCertain: (v) {
                  req.customizeTime = v;
                  customTime.value = v;
                }),
          ),
        ),
        absorbing: edit,
      ),
    );
  }

  _warehouse() {
    return Obx(
      () => Visibility(
        child: Container(
          height: 81.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 21.w),
          child: AbsorbPointer(
            child: InkWell(
              child: Row(
                children: [
                  pText("配货店仓", ColorConfig.color_999999, 28.w),
                  Expanded(
                    child: Obx(
                      () => pText(warehouse.value.name ?? "",
                          ColorConfig.color_999999, 28.w,
                          textAlign: TextAlign.end),
                    ),
                  ),
                  Visibility(
                    child: pImage("images/icon_goto.png", 23.w, 23.w),
                    visible: true,
                  ),
                ],
              ),
              onTap: () => CommonDialog(
                  "配货仓",
                  warehouseListContent(
                    warehouseList ?? [],
                    warehouse.value,
                    (relationDo) {
                      req.warehouseId = relationDo.relationDeptId;
                      warehouse.value = relationDo;
                      Get.back();
                    },
                  )).showBottom(context),
            ),
            absorbing: false,
          ),
        ),
        visible: warehouseVisible.value,
      ),
    );
  }

  Widget taxWidget() {
    return Container(
      height: 58.w,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          pText("税率", ColorConfig.color_333333, 28.w),
          Expanded(
            child: pText(
              "${req.tax ?? 0}%",
              ColorConfig.color_333333,
              28.w,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
