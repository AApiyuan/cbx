import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/widget/bottom_statistics_widget.dart';
import 'package:haidai_flutter_module/page/sale/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/widget/detail_tab.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SaleEnterView extends GetView<SaleEnterController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: KeyboardMediaQuery(
          child: FutureBuilder(
            future: controller.init(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(ColorConfig.color_ffffff));
              } else {
                return Scaffold(
                  appBar: pAppBar("开单", backFunc: () => _back()),//searchGoodsAppBar(),
                  body: Column(
                    children: [
                      customerWidget(),
                      Expanded(child: DetailTab(controller)),
                      Container(
                          color: Color(ColorConfig.color_efefef), height: 1.w),
                      bottomStatistics(context, controller),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      onWillPop: () async => _back(),
    );
  }

  searchGoodsAppBar() {
    return AppBar(
      title: InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 64.w,
          padding: EdgeInsets.only(left: 11.w),
          margin: EdgeInsets.only(right: 14.w),
          child: pText("添加货品", ColorConfig.color_999999, 28.w),
          decoration: ShapeDecoration(
              color: Color(ColorConfig.color_f5f5f5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              )),
        ),
        onTap: () => toGoodsList(
            controller,
            GoodsListController.TYPE_SALE,
            GoodsListController.map2String(controller.saleSelectMap),
            SaleTypeEnum.NORMAL_SALE,
            SaleEnterController.idSaleTab),
      ),
      backgroundColor: new Color(ColorConfig.color_ffffff),
      centerTitle: true,
      toolbarHeight: 88.w,
      leading: IconButton(
          padding: EdgeInsets.only(left: 20.w),
          icon: pImage("images/black_back.png", 48.w, 34.w),
          tooltip: "返回",
          onPressed: () => _back()),
    );
  }

  bool _back() {
    if (controller.hasReturn || controller.hasOwe || controller.hasSale || controller.customer != null) {
      showDialog(
        context: Get.context as BuildContext,
        barrierDismissible: false,
        builder: (_) => CustomDialog(
          title: '提示',
          type: 1,
          height: 300,
          content: pText("确定返回吗，返回会清空已经录入的数据", ColorConfig.color_333333, 28.w),
          confirmCallback: (value) => BackUtils.back(),
        ),
      );
    } else {
      BackUtils.back();
    }
    return false;
  }

  customerWidget() {
    return GetBuilder<SaleEnterController>(
      id: SaleEnterController.idCustomer,
      builder: (ctl) {
        return Visibility(
          child: Column(
            children: [
              ctl.customerId == null ? emptyCustomer(ctl) : customerInfo(ctl),
              // Container(color: Color(ColorConfig.color_f5f5f5), height: 18.w),
            ],
          ),
          visible: !ctl.showKeyBord,
        );
      },
    );
  }
}
