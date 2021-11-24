import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/sale_and_sale_goods_do_entity.dart';
import 'package:haidai_flutter_module/page/goods/widget/goods_search_widget.dart';
import 'package:haidai_flutter_module/page/goods/widget/goods_widget.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/search_bar.dart';

class GoodsListView extends GetView<GoodsListController> {
  final _easyRefreshController = EasyRefreshController();

  late GoodsListController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsListController>(
      builder: (ctl) {
        controller = ctl;
        return Scaffold(
          appBar: searchBar(), //SearchWidget(cancel: () => Get.back()),
          body: GestureDetector(
            child: Column(
              children: [
                filterWidget(context),
                goodsList(),
              ],
            ),
            behavior: HitTestBehavior.translucent,
            onTap: () => closeKey(context),
          ),
        );
      },
    );
  }

  searchBar() {
    return SearchBar(
      hintText: "搜索品名货号",
      cancel: () => Get.back(),
      onChanged: (text) => controller.updateSearchText(text),
      // onSubmit: (text) => controller.search(text),
      onRealTime: (text) => controller.search(text),
      onClear: () {
        controller.updateSearchText("");
        if (controller.goodsType == GoodsListController.TYPE_SALE) {
          controller.updateFilter(GoodsListController.idFilterHot);
        } else {
          controller.search("");
        }
      },
    );
  }

  Widget goodsList() {
    return Expanded(
      child: EasyRefresh.custom(
        slivers: [
          GetBuilder<GoodsListController>(
            builder: (ctl) {
              if (ctl.goodsList.length == 0) {
                return SliverToBoxAdapter(
                  child: emptyWidget(),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    if (ctl.goodsList.length == 0) {
                      return Container();
                    }
                    return listItem(_, ctl.goodsList[index]);
                  },
                  childCount: ctl.goodsList.length,
                ),
              );
            },
            id: GoodsListController.idGoodsList,
          ),
        ],
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        taskIndependence: true,
        onLoad: () async {
          controller.getGoodsList(true).whenComplete(() =>
              _easyRefreshController.finishLoad(
                  noMore: controller.noMore, success: true));
        },
        onRefresh: () async {
          Future.wait([controller.getGoodsList(false)]).then((value) {
            _easyRefreshController.resetLoadState();
            _easyRefreshController.finishRefresh(success: true);
          });
        },
        controller: _easyRefreshController,
      ),
    );
  }

  listItem(BuildContext buildContext, dynamic goods) {
    if (goods is Goods) {
      var function = () => controller.selectGoods(goods).then(
          (value) => Get.back(result: value),
          onError: (t) => print("flutter_tag======$t"));
      switch (controller.goodsType) {
        case GoodsListController.TYPE_RETURN:
          return returnGoods(buildContext, goods, function);
        case GoodsListController.TYPE_STOCK:
        case GoodsListController.TYPE_TRANSFER:
        case GoodsListController.TYPE_INVENTORY:
          return stockGoods(buildContext, goods, true, function);
        case GoodsListController.TYPE_STOCK_SUBSTANDARD:
        case GoodsListController.TYPE_TRANSFER_SUBSTANDARD:
        case GoodsListController.TYPE_INVENTORY_SUBSTANDARD:
          return stockGoods(buildContext, goods, false, function);
      }
      return saleGoods(buildContext, goods, function, controller);
    } else if (goods is SaleAndSaleGoodsDoEntity) {
      return oweOrderHeader(goods);
    } else if (goods is SaleDetailDoSaleGoodsList) {
      return oweGoods(
          buildContext,
          goods,
          () => controller
              .selectOweGoods(goods)
              .then((value) => Get.back(result: value)));
    }
  }
}
