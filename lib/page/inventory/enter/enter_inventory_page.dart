import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/shop_car_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/sku_operation_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/shop_car_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/sort_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/search_screen_sort_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/simple_dialog.dart';
import 'package:haidai_flutter_module/widget/title_bar.dart';

class EnterInventoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EnterInventoryPageState();
  }
}

class EnterInventoryPageState extends State<EnterInventoryPage> {
  final _easyRefreshController = EasyRefreshController();

  // final _goodsController = Get.put(GoodsController());
  // final _skuController = Get.put(SkuOperationController());
  // final _carController = Get.put(ShopCarController());
  late GoodsController _goodsController;
  late SkuOperationController _skuController;
  late ShopCarController _carController;

  SearchScreenSortWidget? _sortScreenSearchWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.isRegistered<GoodsController>()) {
      // GetInstance().reload<GoodsController>();
      Get.reload<GoodsController>();
    } else {
      Get.lazyPut(() => GoodsController());
    }
    _goodsController = Get.find<GoodsController>();
    if (Get.isRegistered<SkuOperationController>()) {
      // GetInstance().reload<SkuOperationController>();
      Get.reload<SkuOperationController>();
    } else {
      Get.lazyPut(() => SkuOperationController());
    }
    _skuController = Get.find<SkuOperationController>();
    if (Get.isRegistered<ShopCarController>()) {
      // GetInstance().reload<ShopCarController>();
      Get.reload<ShopCarController>();
    } else {
      Get.lazyPut(() => ShopCarController());
    }
    _carController = Get.find<ShopCarController>();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _goodsController.initData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: KeyboardMediaQuery(
          child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: titleView(
                "录入${_goodsController.isSubstandard! ? '次品' : '正品'}盘点数据"),
          ),
          leading: backButton(),
          actions: [
            Visibility(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsetsDirectional.only(end: 24.w),
                child: GestureDetector(
                  child: Text(
                    "删除数据",
                    style: textStyle(color: ColorConfig.color_666666),
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return CheckDialog(
                        "确定删除该盘点数据吗？",
                        checkFunction: () => _goodsController
                            .deleteData()
                            .then((value) => Get.back(result: "delete")),
                      );
                    },
                  ),
                ),
              ),
              visible: _goodsController.recordId != null,
            )
          ],
          toolbarHeight: 88.w,
        ),
        body: Column(
          children: [
            sortScreenSearchWidget(),
            Expanded(
              child: EasyRefresh.custom(
                slivers: [
                  GetBuilder<GoodsController>(
                    builder: (ctl) {
                      if (ctl.goodsList.length == 0) {
                        return SliverToBoxAdapter(
                          child: emptyWidget(),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) =>
                              listItem(_, _goodsController.goodsList[index]),
                          childCount: ctl.goodsList.length,
                        ),
                      );
                    },
                    id: GoodsController.bIdGoodsList,
                  ),
                ],
                header: RefreshUtils.defaultHeader(),
                footer: RefreshUtils.defaultFooter(),
                enableControlFinishLoad: true,
                enableControlFinishRefresh: true,
                taskIndependence: true,
                onLoad: () async {
                  _goodsController.getGoodsList(false).whenComplete(() =>
                      _easyRefreshController.finishLoad(
                          noMore: _goodsController.noMore, success: true));
                },
                onRefresh: () async {
                  Future.wait([_goodsController.getGoodsList(true)])
                      .then((value) {
                    _easyRefreshController.resetLoadState();
                    _easyRefreshController.finishRefresh(success: true);
                  });
                },
                controller: _easyRefreshController,
              ),
            ),
            shopCarWidget(context),
          ],
        ),
        resizeToAvoidBottomInset: false,
      )),
      onWillPop: () async {
        return !(_sortScreenSearchWidget?.hideDialog() ?? false);
      },
    );
  }

  SearchScreenSortWidget sortScreenSearchWidget() {
    _sortScreenSearchWidget = SearchScreenSortWidget(
      sortName: SortDialog.name[0],
      onSortTap: (orderBy) => _goodsController.changeOrderBy(orderBy),
      onScreenTap: (screenData) =>
          _goodsController.changeScreenData(screenData),
      onSearchTap: (text) => _goodsController.searchGoods(text),
    );
    return _sortScreenSearchWidget!;
  }

  Widget shopCarWidget(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1.w,
          color: Color(ColorConfig.color_efefef),
        ),
        GetBuilder<ShopCarController>(
          builder: (ctl) {
            int count = _carController.shopCarCount();
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showShopCarDialog(context),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.w, end: 14.w),
                    child: Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            "images/icon_bottom_shopcar.png",
                            width: 72.w,
                            height: 72.w,
                          ),
                          padding: EdgeInsetsDirectional.only(end: 15.w),
                        ),
                        Positioned(
                          child: Visibility(
                            child: Container(
                              child: Text(
                                "$count",
                                style: textStyle(
                                    size: 24,
                                    bold: true,
                                    color: ColorConfig.color_ffffff),
                              ),
                              padding: EdgeInsetsDirectional.only(
                                  start: 8.w, end: 8.w),
                              decoration: ShapeDecoration(
                                color: Color(ColorConfig.color_ff3715),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(15.w)),
                                ),
                              ),
                            ),
                            visible: count > 0,
                          ),
                          right: 0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${_carController.carGoodsSkuMap.length}款 $count件",
                      style: textStyle(
                          color: ColorConfig.color_1678FF, bold: true),
                    ),
                  ),
                  Opacity(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 194.w,
                        height: 96.w,
                        color: Color(ColorConfig.color_1678FF),
                        child: Text(
                          "提交盘点数",
                          style: textStyle(
                              size: 32, color: ColorConfig.color_ffffff),
                        ),
                      ),
                      onTap: () => showTipDialog(context, count),
                    ),
                    opacity: count > 0 ? 1 : 0.5,
                  ),
                ],
              ),
            );
          },
          id: ShopCarController.bIdCar,
        ),
      ],
    );
  }

  Widget listItem(BuildContext context, Goods goods) {
    String stockText;
    if (_goodsController.isSubstandard!) {
      stockText = "次品库存${goods.substandardNum ?? 0}";
    } else {
      stockText = "正品库存${goods.stockNum ?? 0}";
    }
    return GestureDetector(
      child: Container(
        color: Color(ColorConfig.color_ffffff),
        height: 196.w,
        child: Stack(
          children: [
            Positioned(
              top: 28.w,
              left: 20.w,
              child: NetImageWidget(
                "${goods.imgPath}/${goods.cover}",
                goodsId: goods.id!,
              ),
            ),
            Positioned(
              top: 28.w,
              left: 176.w,
              child: Text(
                "${goods.goodsSerial}${goods.goodsName?.length == 0 ? "" : "-${goods.goodsName}"}",
                style: textStyle(bold: true),
              ),
            ),
            Positioned(
              left: 176.w,
              bottom: 28.w,
              child: Text(
                stockText,
                style: textStyle(size: 24, color: ColorConfig.color_999999),
              ),
            ),
            Positioned(
              right: 120.w,
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  child: Text(
                    "叠加",
                    style: textStyle(size: 24, color: ColorConfig.color_999999),
                  ),
                  padding: EdgeInsetsDirectional.only(
                      start: 28.w, end: 28.w, top: 28.w, bottom: 28.w),
                  color: Colors.transparent,
                ),
                onTap: () => getSkuList(context, goods, true),
              ),
            ),
            Positioned(
              height: 34.w,
              width: 88.w,
              bottom: 28.w,
              right: 24.w,
              child: GetBuilder<ShopCarController>(
                builder: (ctl) {
                  return Image.asset(
                    _carController.hasGoods(goods.id!)
                        ? "images/icon_billing_select_on.png"
                        : "images/icon_billing_select_off.png",
                    width: 88.w,
                    height: 34.w,
                  );
                },
                id: ShopCarController.bIdCarGoodsSelect(goods.id!),
              ),
            ),
          ],
        ),
      ),
      onTap: () => getSkuList(context, goods, false),
    );
  }

  getSkuList(BuildContext context, Goods goods, bool add) {
    print("flutter_tag========getSku");
    if (CommonUtils.isFastClick()) return;
    print("flutter_tag========getSku2");
    _goodsController
        .getSkuList(goods.id!, showLoad: true)
        .then((value) => showSkuDialog(context, goods, value, add));
  }

  showSkuDialog(
      BuildContext context, Goods goods, List<SkuData> skuList, bool add) {
    //转换skuData
    // List<SkuData> skuList =
    //     _goodsController.buildSkuData(goods.id, skuInfoList);
    Map<int, int> selectSkuMap = LinkedHashMap();
    skuList.forEach((element) => selectSkuMap[element.skuId!] = add
        ? 0
        : _carController.goodsSkuSelectCount(goods.id!, element.skuId!));
    _skuController.setSkuData(selectSkuMap);
    //显示
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => GoodsSkuDialog(goods, skuList, add),
    );
  }

  showShopCarDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShopCarDialog(function: () {
        Get.back();
        showTipDialog(context, _carController.shopCarCount());
      }),
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
    );
  }

  showTipDialog(BuildContext context, int count) {
    if (count > 0)
      showDialog(
        context: context,
        builder: (context) => CheckDialog("确定提交这个盘点数据吗？",
            checkFunction: () => _carController
                .createOrUpdateOrder()
                .then((value) => Get.back(result: "update"))),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _goodsController.dispose();
    // _carController.dispose();
    // _skuController.dispose();
    // Get.delete<GoodsController>();
    // Get.delete<ShopCarController>();
    // Get.delete<SkuOperationController>();
    print("flutter_tag====================dispose");
    super.dispose();
  }

  Widget emptyWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image(
            image: AssetImage("images/icon_goods_empty.png"),
            width: 270.w,
          ),
          Text(
            "当前没有数据哦~",
            style: textStyle(size: 28),
          ),
        ],
      ),
    );
  }
}
