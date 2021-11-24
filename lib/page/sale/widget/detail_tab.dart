import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/widget/tab_owe_body.dart';
import 'package:haidai_flutter_module/page/sale/widget/tab_return_body.dart';
import 'package:haidai_flutter_module/page/sale/widget/tab_sale_body.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class DetailTab extends StatefulWidget {
  SaleEnterController controller;

  DetailTab(this.controller);

  @override
  State<StatefulWidget> createState() {
    return DetailTabState();
  }
}

class DetailTabState extends State<DetailTab>
    with SingleTickerProviderStateMixin {
  List tabs = ["销售", "退欠货", "退实物"];
  List tabIds = [
    SaleEnterController.idSaleTab,
    SaleEnterController.idOweTab,
    SaleEnterController.idReturnTab,
  ];
  List tabColors = [
    ColorConfig.color_1678FF,
    ColorConfig.color_FF7314,
    ColorConfig.color_FF3715
  ];
  late TabController tabController;

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    if (widget.controller.type == SaleEnterController.TYPE_OFFLINE_SALE) {
      tabs.removeAt(1);
      tabIds.removeAt(1);
      tabColors.removeAt(1);
    } else if (widget.controller.type == SaleEnterController.TYPE_QUOTATION) {
      tabs.removeRange(1, 3);
      tabIds.removeRange(1, 3);
      tabColors.removeRange(1, 3);
    }
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() => widget.controller.updateSelectTab(
        tabIds[tabController.index], tabIds[tabController.previousIndex]));
    tabController.index = widget.controller.listType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          child: tabWidget(),
          visible: widget.controller.type != SaleEnterController.TYPE_QUOTATION,
        ),
        searchBar(),
        tabBody(),
      ],
    );
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  tabWidget() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        tabController.animateTo(tabIds.indexOf(ctl.currTab));
        return Container(
          child: Container(
            height: 56.w,
            padding: EdgeInsets.all(4.w),
            margin: EdgeInsets.only(left: 26.w, right: 26.w, bottom: 24.w),
            child: TabBar(
              isScrollable: false,
              controller: tabController,
              indicator: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.w),
                ),
              ),
              tabs: tabs
                  .map((e) => Tab(child: tabItem(e, tabIds[tabs.indexOf(e)])))
                  .toList(),
            ),
            decoration: ShapeDecoration(
              color: Color(ColorConfig.color_f5f5f5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
            ),
          ),
          color: Colors.white,
        );
      },
      id: SaleEnterController.idTabWidget,
    );
  }

  tabBody() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        //创建Tab页
        children: tabs.map((e) => createBody(e)).toList(),
      ),
    );
  }

  tabItem(String e, String id) {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        var color;
        var count;
        if (ctl.currTab == id) {
          color = tabColors[tabIds.indexOf(id)];
        } else {
          color = ColorConfig.color_666666;
        }
        if (id == SaleEnterController.idSaleTab) {
          count = ctl.saleCount;
        } else if (id == SaleEnterController.idOweTab) {
          count = ctl.oweCount.abs();
        } else {
          count = ctl.returnCount.abs();
        }
        return pText("$e${count == 0 ? "" : "($count)"}", color, 26.w,
            fontWeight: FontWeight.bold);
      },
      id: id,
    );
  }

  Widget createBody(String e) {
    var id = tabIds[tabs.indexOf(e)];
    if (id == SaleEnterController.idSaleTab) {
      return TabSaleBody();
    } else if (id == SaleEnterController.idReturnTab) {
      return TabReturnBody();
    } else {
      return TabOweBody();
    }
  }

  searchBar() {
    return Container(
      child: GetBuilder<SaleEnterController>(
        builder: (controller) => GestureDetector(
          child: Container(
            alignment: Alignment.center,
            height: 64.w,
            margin: EdgeInsets.only(left: 26.w, right: 26.w, bottom: 36.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pImage("images/search_icon.png", 24.w, 24.w),
                pSizeBoxW(14.w),
                pText("搜索添加货品", ColorConfig.color_999999, 24.w),
              ],
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
              color: Color(ColorConfig.color_efefef),
            ),
          ),
          onTap: () => toGoodsList(controller, tabIds[tabController.index]),
        ),
      ),
      color: Color(ColorConfig.color_ffffff),
    );
  }

  toGoodsList(SaleEnterController controller, String id) {
    int? type;
    String? skuMap;
    SaleTypeEnum? typeEnum;
    int? orderId;
    switch (id) {
      case SaleEnterController.idOweTab:
        if (controller.customer == null) {
          toastMsg("请选择客户");
          return;
        }
        type = GoodsListController.TYPE_OWE;
        skuMap = GoodsListController.map2String(controller.oweNewSelectMap);
        typeEnum = SaleTypeEnum.CHANGE_BACK_ORDER;
        orderId = controller.orderSaleId;
        break;
      case SaleEnterController.idReturnTab:
        if (controller.customer == null) {
          toastMsg("请选择客户");
          return;
        }
        type = GoodsListController.TYPE_RETURN;
        skuMap = GoodsListController.map2String(controller.returnSelectMap);
        typeEnum = SaleTypeEnum.RETURN_GOODS;
        break;
      case SaleEnterController.idSaleTab:
        type = GoodsListController.TYPE_SALE;
        skuMap = GoodsListController.map2String(controller.saleSelectMap);
        typeEnum = SaleTypeEnum.NORMAL_SALE;
        break;
    }
    controller.updateSelectTab(id, controller.currTab);
    Get.toNamed(
      ArgUtils.map2String(path: Routes.GOODS_LIST, arguments: {
        Constant.DEPT_ID: controller.deptId,
        Constant.CUSTOMER_ID: controller.customer?.id,
        Constant.GOODS_TYPE: type,
        Constant.SELECT_MAP: skuMap,
        Constant.ORDER_ID: orderId,
        Constant.ONLINE: controller.online,
        Constant.SALE_LAST_PRICE: controller.saleLastPrice,
        Constant.RETURN_LAST_PRICE: controller.returnLastPrice,
        GoodsListController.PARAM_SELECT_ALL: type == GoodsListController.TYPE_RETURN,
        "level": controller.customer?.levelTag,
      }),
    )?.then((value) => controller.addGoods(typeEnum!, value));
  }
}
