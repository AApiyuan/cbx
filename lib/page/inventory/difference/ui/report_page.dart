import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/enum/is_inventory.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/filter_controller.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/inventory_goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/difference/delegate/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/page/inventory/difference/widget/goods_item.dart';
import 'package:haidai_flutter_module/page/inventory/difference/widget/inventory_report_filter_bar.dart';
import 'package:haidai_flutter_module/page/inventory/difference/widget/plan_data.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/hint_dialog.dart';

import '../controller/difference_controller.dart';

/// 正品/次品 报告 TabBarView
class ReportPage extends StatefulWidget {
  ReportPage(
    this.type, {
    Key? key,
  }) : super(key: key);

  final String type;

  @override
  State createState() {
    Get.put(DifferenceController(type), tag: type);
    Get.put(InventoryGoodsController(type), tag: type);
    Get.put(FilterController(), tag: type);
    return _ReportState();
  }
}

class _ReportState extends State<ReportPage>
    with AutomaticKeepAliveClientMixin {
  late DifferenceController _controller;
  late InventoryGoodsController _goodsController;
  late FilterController _filterController;
  final _scrollController = ScrollController();
  final _refreshController = EasyRefreshController();
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = Get.find(tag: widget.type);
    _goodsController = Get.find(tag: widget.type);
    _filterController = Get.find(tag: widget.type);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _initData();
    });
    _focusNode.addListener(
        () => _controller.showOrHideCancel(hasFocus: _focusNode.hasFocus));
  }

  /// 初始化数据
  void _initData() {
    _showCrateDifferenceReport();
    _controller
        .getInventoryReport()
        .then((value) => _goodsController.getInventoryReportGoods())
        .whenComplete(() => HintDialogUtil.dismiss());
  }

  /// 头部Key
  final _headKey = GlobalKey();

  /// 筛选条件栏Key
  final _filterKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _refreshController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _createContainer();
  }

  /// 创建内容
  Widget _createContainer() {
    return EasyRefresh.custom(
      controller: _refreshController,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      header: RefreshUtils.defaultHeader(),
      footer: RefreshUtils.defaultFooter(),
      taskIndependence: true,
      scrollController: _scrollController,
      slivers: [
        _createHead(),
        _createFilterBar(),
        _createGoodsList(),
        // _fillBlank(),
      ],
      onRefresh: () => _onRefresh(),
      onLoad: () => _onLoad(),
    );
  }

  /// 刷新事件
  Future _onRefresh() async {
    Future.wait([
      _controller.getInventoryReport(),
    ]).then((value) => _goodsController.reset()).whenComplete(() {
      _refreshController.resetLoadState();
      _refreshController.finishRefresh(success: true);
    });
  }

  /// 加载事件
  Future _onLoad() async {
    _goodsController.getInventoryReportGoods().whenComplete(() {
      _refreshController.finishLoad(
          success: true, noMore: _goodsController.noMore);
    });
  }

  /// 创建头部
  Widget _createHead() {
    return SliverToBoxAdapter(
      child: Column(
        key: _headKey,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 24.w),
            width: double.infinity,
            color: Color(ColorConfig.color_fffcd9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<DifferenceController>(
                  builder: (ctl) {
                    return Text(
                      "账面库存快照时间：${ctl.getTime()}",
                      style: TextStyle(
                          fontSize: 24.w,
                          color: Color(ColorConfig.color_ff5d1e)),
                    );
                  },
                  tag: widget.type,
                ),
                Text(
                  "未盘货品默认按盘点数为0计算差异",
                  style: TextStyle(
                      fontSize: 24.w, color: Color(ColorConfig.color_ff5d1e)),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: BorderDirectional(bottom: borderSide()),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 21.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<DifferenceController>(
                    builder: (ctl) {
                      return Text(
                        "账面总库存:${ctl.getTotalGoodsStyleNum()}款/${ctl.getTotalGoodsNum()}",
                        style: TextStyle(
                            fontSize: 24.w,
                            color: Color(ColorConfig.color_333333)),
                      );
                    },
                    tag: widget.type,
                  ),
                  GetBuilder<DifferenceController>(
                    builder: (ctl) {
                      return Text(
                        "总盈亏数：${ctl.getTotalInventoryNum()}",
                        style: TextStyle(
                            fontSize: 24.w,
                            color: Color(ColorConfig.color_333333)),
                      );
                    },
                    tag: widget.type,
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<DifferenceController>(
            builder: (ctl) {
              return PlanData(
                alreadyTitle: _controller.alreadyTaskStockTitle(),
                notYetTitle: _controller.notYeTaskStockTitle(),
                inventoryStyleNum: _controller.getInventoryStyleNum(),
                inventoryNum: _controller.getInventoryNum(),
                noInventoryStyleNum: _controller.getNoInventoryStyleNum(),
                profitStyleNum: _controller.getProfitStyleNum(),
                profitNum: _controller.getProfitNum(),
                lossStyleNum: _controller.getLossStyleNum(),
                lossNum: _controller.getLossNum(),
                noProfitStyleNum: _controller.getNoProfitStyleNum(),
                noProfitNum: _controller.getNoProfitNum(),
                noLossStyleNum: _controller.getNoLossStyleNum(),
                noLossNum: _controller.getNoLossNum(),
              );
            },
            tag: widget.type,
          ),
          Container(
            color: Color(ColorConfig.color_efefef),
            height: 20.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _taskStockTypeChange(
                _controller.alreadyTaskStockTitle(),
                IsInventoryEnum.YES,
                margin: 82,
              ),
              _taskStockTypeChange(
                _controller.notYeTaskStockTitle(),
                IsInventoryEnum.NO,
              ),
            ],
          ),
          _createSearchBar(),
        ],
      ),
    );
  }

  /// 已盘/未盘 切换
  Widget _taskStockTypeChange(String text, String type, {int margin = 0}) {
    return GestureDetector(
      child: Container(
        height: 92.w,
        margin: EdgeInsets.only(right: margin.w),
        alignment: Alignment.center,
        child: GetBuilder<InventoryGoodsController>(
          id: InventoryGoodsController.UPDATE_IS_INVENTORY,
          tag: widget.type,
          builder: (ctl) {
            TextStyle style = ctl.isInventoryEnum == type
                ? textStyle(bold: true, color: ColorConfig.color_1678FF)
                : textStyle(color: ColorConfig.color_999999);
            return Text(text, style: style);
          },
        ),
      ),
      onTap: () async {
        _goodsController.changeTaskStockType(type);
      },
    );
  }

  /// 搜索栏
  Widget _createSearchBar() {
    return Container(
      height: 76.w,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(ColorConfig.color_efefef),
                borderRadius: BorderRadius.circular(38.w),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: TextField(
                          controller: _searchController,
                          maxLength: 20,
                          focusNode: _focusNode,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            counterText: "",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "搜索品名货号",
                            hintStyle:
                                textStyle(color: ColorConfig.color_999999),
                          ),
                          textInputAction: TextInputAction.done,
                          style: textStyle(),
                          onChanged: (content) {
                            _controller.showOrHideClear(content.isNotEmpty);
                            changeSearchContent(content);
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 10.w),
                            child: Image.asset(
                              "images/del_pic.png",
                              width: 30.w,
                              height: 30.w,
                            ),
                          ),
                          onTap: () {
                            _searchController.clear();
                            _controller.showOrHideClear(false);
                            changeSearchContent("");
                          },
                        ),
                        visible: _controller.clearButtonVisible(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text("取消",
                      style: TextStyle(
                          color: Color(ColorConfig.color_333333),
                          fontSize: 28.w)),
                ),
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    changeSearchContent("");
                  }
                  _controller.showOrHideCancel();
                  _controller.showOrHideClear(false);
                  _searchController.clear();
                  _focusNode.unfocus();
                },
              ),
              visible: _controller.cancelTextVisible(),
            ),
          ),
        ],
      ),
    );
  }

  Timer? _timer;

  /// 修改搜索内容
  void changeSearchContent(String content) async {
    _timer?.cancel();
    final timeout = Duration(milliseconds: 500);
    _timer = Timer(timeout, () {
      _filterController.searchContent = content.isEmpty ? null : content;
      _goodsController.reset();
    });
  }

  /// 创建筛选栏
  Widget _createFilterBar() {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
          minHeight: 96.w,
          maxHeight: 96.w,
          child: InventoryReportFilterBar(
            _filterKey,
            widget.type,
            onFilterTap: _scrollFilterBar,
            onFilterConfirmTap: () => _goodsController.reset(showLoading: true),
          )),
    );
  }

  /// 滚动筛选栏到顶部
  void _scrollFilterBar() {
    RenderObject? headBox = _headKey.currentContext?.findRenderObject();
    if (headBox is RenderBox) {
      var off = headBox.size.height;
      if (_scrollController.offset < off) {
        _scrollController.jumpTo(off);
      }
    }
  }

  /// 创建商品列表
  Widget _createGoodsList() {
    return GetBuilder<InventoryGoodsController>(
      tag: widget.type,
      id: InventoryGoodsController.UPDATE_ID,
      builder: (ctl) {
        if (ctl.goods.length == 0) {
          return SliverToBoxAdapter(
            child: Container(
              height: 1080.w,
              alignment: Alignment.center,
              child: Text(
                "暂无有差异商品数据",
                style: textStyle(),
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              final item = ctl.goods[index];
              return GoodsItem(
                item.goodsId!,
                imgPath: item.storeGoodsBaseDo?.imgPath,
                cover: item.storeGoodsBaseDo?.cover,
                name: item.storeGoodsBaseDo?.goodsName ?? "",
                serial: item.storeGoodsBaseDo?.goodsSerial,
                type: widget.type,
                stockNum: item.snapStock ?? 0,
                realNum: item.inventoryStock ?? 0,
                profitNum: item.profit ?? 0,
                lessNum: item.loss ?? 0,
                index: index,
              );
            },
            childCount: ctl.goods.length,
          ),
        );
      },
    );
  }

  /// 填充空白
  Widget _fillBlank() {
    return GetBuilder<InventoryGoodsController>(
      id: InventoryGoodsController.UPDATE_BLANK_HEIGHT,
      tag: widget.type,
      builder: (ctl) {
        double height = (7 - ctl.goods.length) * 200.0;
        if (ctl.goods.length == 0) {
          height = 0;
        }
        return SliverToBoxAdapter(
          child: SizedBox(
            height: height.w,
            width: double.infinity,
          ),
        );
      },
    );
  }

  /// 显示生成差异报告弹窗
  void _showCrateDifferenceReport() {
    HintDialogUtil.show(
      width: 550,
      height: 550,
      title: "生成报告",
      hideButton: true,
      cancelable: false,
      contentWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.w),
            child: Text(
              "差异数据分析中，请稍后…",
              style: textStyle(color: ColorConfig.color_999999),
            ),
          )
        ],
      ),
    );
  }
}
