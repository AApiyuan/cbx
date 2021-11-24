import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/sale_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/sale_list_sort.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/sale_list_tab.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/widget/sale_statement.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class BiGoodsSale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiGoodsSaleState();
  }
}

class BiGoodsSaleState extends State<BiGoodsSale>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late TabController _tabController;

  final _easyRefreshController = EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: Get.find<BiGoodsController>().saleListTab,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      color: Color(ColorConfig.color_282940),
      child: GetBuilder<BiGoodsController>(
        builder: (ctl) => EasyRefresh.custom(
          slivers: [
            SliverToBoxAdapter(
              child: DateSelect(
                callback: (start, end) {
                  _easyRefreshController.resetLoadState();
                  ctl.updateTime(start, end);
                },
                startTime: ctl.startTime,
                endTime: ctl.endTime,
              ),
            ),
            SliverToBoxAdapter(child: saleStatement()),
            SliverToBoxAdapter(
              child: saleListTab(
                () => _easyRefreshController.resetLoadState(),
                _tabController,
              ),
            ),
            SliverToBoxAdapter(
                child: saleListSort(
                    () => _easyRefreshController.resetLoadState())),
            saleList(),
            SliverToBoxAdapter(child: statementFooter()),
          ],
          header: RefreshUtils.defaultHeader(),
          footer: RefreshUtils.defaultFooter(),
          enableControlFinishLoad: true,
          enableControlFinishRefresh: true,
          taskIndependence: true,
          onLoad: () async {
            await ctl.getSaleListData(next: true).whenComplete(() =>
                _easyRefreshController.finishLoad(
                    noMore: !ctl.saleListHasMore, success: true));
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
