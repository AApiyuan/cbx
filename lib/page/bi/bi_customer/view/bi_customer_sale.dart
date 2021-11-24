import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/sale_statement.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/statement_body.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/statement_sort.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/widget/statement_tab.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class BiCustomerSale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiCustomerSaleState();
  }
}

class BiCustomerSaleState extends State<BiCustomerSale>
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
      child: GetBuilder<BiCustomerController>(
        builder: (ctl) => EasyRefresh.custom(
          slivers: [
            SliverToBoxAdapter(
              child: GetBuilder<BiCustomerController>(
                builder: (ctl) => DateSelect(
                  callback: (start, end) {
                    _easyRefreshController.resetLoadState();
                    ctl.updateTime(start, end);
                  },
                  startTime: ctl.startTime,
                  endTime: ctl.endTime,
                ),
              ),
            ),
            SliverToBoxAdapter(child: saleStatement()),
            SliverToBoxAdapter(child: statementTab(() => _easyRefreshController.resetLoadState())),
            SliverToBoxAdapter(child: sortWidget(() => _easyRefreshController.resetLoadState())),
            statementBody(),
            SliverToBoxAdapter(child: statementFooter()),
          ],
          header: RefreshUtils.defaultHeader(),
          footer: RefreshUtils.defaultFooter(),
          enableControlFinishLoad: true,
          enableControlFinishRefresh: true,
          taskIndependence: true,
          onLoad: () async {
            await ctl.statementData(next: true).whenComplete(() =>
                _easyRefreshController.finishLoad(
                    noMore: !ctl.statementHasMore, success: true));
          },
          // onRefresh: () async {},
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
}
