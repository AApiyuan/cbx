import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/difference_controller.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/inventory_goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/difference/ui/report_page.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/button.dart';
import 'package:haidai_flutter_module/widget/hint_dialog.dart';
import 'package:haidai_flutter_module/widget/tab_size_indicator.dart';

/// 查看差异页面
class DifferencePage extends StatelessWidget {
  final List _tabs = ["正品报告", "次品报告"];
  final GlobalKey _tabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: DefaultTabController(
        length: _tabs.length,
        child: Container(
          key: _tabKey,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              _createTabBar(),
              _createTabBarView(),
              bottomButton(
                "打印差异",
                _showPrintHintDialog,
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTabBar() {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 102.w,
            height: 88.w,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.w),
                child: Image(
                  image: AssetImage("images/icon_back_gray.png"),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 65.w),
            child: SizedBox(
              height: 88.w,
              width: 370.w,
              child: TabBar(
                indicator: TabSizeIndicator(
                    wantWidth: 32.w,
                    borderSide:
                        BorderSide(width: 6.w, color: Color(0xFF1678FF))),
                labelColor: Color(ColorConfig.color_1678ff),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30.w),
                unselectedLabelColor: Color(ColorConfig.color_333333),
                unselectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 30.w),
                tabs: _tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTabBarView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 6.w),
        child: TabBarView(
          children: [
            ReportPage(OrderStockGoodsTypeEnum.NORMAL),
            ReportPage(OrderStockGoodsTypeEnum.SUBSTANDARD),
          ],
        ),
      ),
    );
  }

  /// 打印提示弹窗
  void _showPrintHintDialog() {
    final goodsController = _getGoodsController();
    final controller = Get.find<DifferenceController>(tag: goodsController.type);
    if (controller.getInventoryStyleNum() == 0) {
      toastMsg("盘点货品没有差异，不需要打印");
      return;
    }
    if (controller.getInventoryStyleNum() < 50) {
      _intentPrintPage();
      return;
    }
    HintDialogUtil.show(
      title: "确定打印吗？",
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 65.w,
              top: 30.w,
              right: 65.w,
              bottom: 20.w,
            ),
            child: Text("此次打印货品及SKU较多",
                style: textStyle(size: 32, color: ColorConfig.color_999999)),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 65.w),
              child: Text("请确保有足够的打印纸，避免重新打印，造成打印纸浪费",
                  style: textStyle(size: 32, color: ColorConfig.color_999999)),
            ),
          ),
        ],
      ),
      positiveText: "确定打印",
      positiveCallBack: (_) => _intentPrintPage(),
    );
  }

  final MethodChannel _methodChannel = new MethodChannel(ChannelConfig.flutterToNative);

  void _intentPrintPage() {
    InventoryGoodsController controller = _getGoodsController();
    int orderInventoryId = controller.id;
    String isInventory = controller.isInventoryEnum;
    final argument = {
      "orderInventoryId": orderInventoryId,
      "isInventory": isInventory,
      "orderStockGoodsType": controller.type
    };
    _methodChannel.invokeMethod(ChannelConfig.methodPrintDifference, argument);
  }

  InventoryGoodsController _getGoodsController() {
    int index = DefaultTabController.of(_tabKey.currentContext!)!.index;
    String type = index == 0
        ? OrderStockGoodsTypeEnum.NORMAL
        : OrderStockGoodsTypeEnum.SUBSTANDARD;
    InventoryGoodsController controller = Get.find(tag: type);
    return controller;
  }
}
