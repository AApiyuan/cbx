import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_owe_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/owe_list_body.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/owe_list_sort.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class BiCustomerOwe extends StatefulWidget {
  final BiCustomerController biCustomerController;

  BiCustomerOwe(this.biCustomerController);

  @override
  State<StatefulWidget> createState() {
    Get.lazyPut(() => BiCustomerOweController(
          biCustomerController.topDeptId,
          biCustomerController.customerDeptIds,
          biCustomerController.singleDept,
        ));
    return BiCustomerOweState();
  }
}

class BiCustomerOweState extends State<BiCustomerOwe>
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
      child: GetBuilder<BiCustomerOweController>(
        builder: (ctl) => EasyRefresh.custom(
          slivers: [
            SliverToBoxAdapter(child: oweGoods()),
            SliverToBoxAdapter(child: oweAmount()),
            SliverToBoxAdapter(child: oweHeader()),
            SliverToBoxAdapter(
                child:
                    oweListSort(() => _easyRefreshController.resetLoadState())),
            oweListBody(),
            SliverToBoxAdapter(child: oweFooter()),
          ],
          header: RefreshUtils.defaultHeader(),
          footer: RefreshUtils.defaultFooter(),
          enableControlFinishLoad: true,
          enableControlFinishRefresh: true,
          taskIndependence: true,
          onLoad: () async {
            await ctl.oweList(next: true).whenComplete(() =>
                _easyRefreshController.finishLoad(
                    noMore: !ctl.hasMore, success: true));
          },
          // onRefresh: () async {},
          controller: _easyRefreshController,
        ),
      ),
    );
  }

  oweAmount() {
    return GetBuilder<BiCustomerOweController>(
      builder: (ctl) => Container(
        height: 152.w,
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pSizeBoxW(30.w),
            item("单据结欠",
                PriceUtils.priceString(ctl.customerTotalDo?.orderOweAmount)),
            pSizeBoxW(30.w),
            item("客户余额", PriceUtils.priceString(ctl.customerTotalDo?.balance)),
          ],
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          color: Color(ColorConfig.color_393a58),
        ),
      ),
      id: BiCustomerOweController.idOweAmount,
    );
  }

  oweGoods() {
    return GetBuilder<BiCustomerOweController>(
      builder: (ctl) => Container(
        height: 152.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pSizeBoxW(30.w),
            item("欠货", "${ctl.customerTotalDo?.shortageNum??0}"),
            pSizeBoxW(30.w),
            item("欠货金额",
                PriceUtils.priceString(ctl.customerTotalDo?.shortageAmount)),
          ],
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          color: Color(ColorConfig.color_393a58),
        ),
      ),
      id: BiCustomerOweController.idOweGoods,
    );
  }

  item(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pSizeBoxH(35.w),
          pText(title, ColorConfig.color_ffffff, 24.w),
          pSizeBoxH(5.w),
          pText(
            value,
            ColorConfig.color_ffffff,
            36.w,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  oweHeader() {
    return Container(
      height: 92.w,
      alignment: Alignment.centerLeft,
      child: pText(
        "欠款欠货",
        ColorConfig.color_ffffff,
        32.w,
        fontWeight: FontWeight.bold,
      ),
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.only(left: 30.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          ),
        ),
        color: Color(ColorConfig.color_393a58),
      ),
    );
  }

  oweFooter() {
    return Container(
      height: 22.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.w),
            bottomRight: Radius.circular(20.w),
          ),
        ),
        color: Color(ColorConfig.color_393a58),
      ),
    );
  }
}
