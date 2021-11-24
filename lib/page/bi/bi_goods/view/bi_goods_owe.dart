import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_owe_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/owe_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/owe_list_sort.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/owe_list_tab.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class BiGoodsOwe extends StatefulWidget {
  final BiGoodsController controller;

  BiGoodsOwe(this.controller);

  @override
  State<StatefulWidget> createState() {
    Get.lazyPut(() => BiGoodsOweController(
          controller.topDeptId,
          controller.customerDeptIds,
          controller.singleDept,
        ));
    return BiGoodsOweState();
  }
}

class BiGoodsOweState extends State<BiGoodsOwe>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final _easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      color: Color(ColorConfig.color_282940),
      child: GetBuilder<BiGoodsOweController>(
        builder: (ctl) => EasyRefresh.custom(
          slivers: [
            SliverToBoxAdapter(child: goodsStockAndOwe()),
            SliverToBoxAdapter(
                child:
                    oweListTab(() => _easyRefreshController.resetLoadState())),
            SliverToBoxAdapter(
                child:
                    oweListSort(() => _easyRefreshController.resetLoadState())),
            oweList(),
            SliverToBoxAdapter(child: statementFooter()),
          ],
          header: RefreshUtils.defaultHeader(),
          footer: RefreshUtils.defaultFooter(),
          enableControlFinishLoad: true,
          enableControlFinishRefresh: true,
          taskIndependence: true,
          onLoad: () async {
            await ctl.getListData(next: true).whenComplete(() =>
                _easyRefreshController.finishLoad(
                    noMore: !ctl.listDataHasMore, success: true));
          },
          controller: _easyRefreshController,
        ),
      ),
    );
  }

  statementFooter() {
    return Container(
      height: 22.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.w),
            bottomRight: Radius.circular(16.w),
          ),
        ),
        color: Color(ColorConfig.color_393a58),
      ),
    );
  }

  goodsStockAndOwe() {
    return Container(
      height: 202.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<BiGoodsOweController>(
            builder: (ctl) => Row(
              children: [
                pSizeBoxW(30.w),
                stockItem("正品库存", "${ctl.goodsStock}"),
                pSizeBoxW(30.w),
                stockItem("次品库存", "${ctl.goodsSubStandardStock}"),
              ],
            ),
            id: BiGoodsOweController.idGoodsStock,
          ),
          oweItem(),
        ],
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
        color: Color(ColorConfig.color_393a58),
      ),
    );
  }

  stockItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pSizeBoxH(35.w),
          pText(
            title,
            ColorConfig.color_ffffff,
            24.w,
          ),
          pSizeBoxH(5.w),
          pText(
            value,
            ColorConfig.color_ffffff,
            36.w,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  oweItem() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
        color: Color(ColorConfig.color_3F4064),
      ),
      height: 60.w,
      child: Row(
        children: [
          pSizeBoxW(30.w),
          pText("欠货", ColorConfig.color_ffffff, 24.w),
          pSizeBoxW(8.w),
          GetBuilder<BiGoodsOweController>(
            builder: (ctl) => pText(
              "${ctl.goodsOwe}",
              ColorConfig.color_ffffff,
              24.w,
              fontWeight: FontWeight.bold,
            ),
            id: BiGoodsOweController.idGoodsOwe,
          ),
        ],
      ),
    );
  }
}
