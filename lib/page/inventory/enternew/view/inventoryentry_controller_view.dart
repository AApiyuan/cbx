import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/inventoryentry_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/widget/entry_confirm.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/widget/entry_goodslist_widget.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/stock_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/widget/goods_list_widget.dart';
import 'package:haidai_flutter_module/page/stock/create/widget/stock_confim.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/goods_search_bar.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class InventoryEntryControllerView extends GetView<InventoryEntryController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
            child: GetBuilder<InventoryEntryController>(
                id: "InventoryEntry",
                builder: (ctl) {
                  return KeyboardMediaQuery(
                      child: FutureBuilder(
                          future: ctl.init(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(width: double.infinity, height: double.infinity, color: Color(ColorConfig.color_ffffff));
                            } else {
                              return Scaffold(
                                backgroundColor: Color(ColorConfig.color_ffffff),
                                appBar: GoodsSearchBar(
                                    param: ctl.searchParam,
                                    receiveFunc: (GoodsSkuEntity value) {
                                      //页面返回接收参数
                                      ctl.addGoods(value);
                                    },
                                    backFunction: () {
                                      back(ctl);
                                    }),
                                body:
                                Column(
                                  children: [
                                    // Text('sahdjkisBlank'),
                                    noGoods(),
                                    EntryGoodsListWidget()
                                  ],
                                ),
                                bottomSheet: entryConfirmWidget(),
                              );
                            }
                          }));
                })),
        onWillPop: () {
          back(controller);
          return new Future.value(false);
        });
  }
}

Widget noGoods() {
  return GetBuilder<InventoryEntryController>(
      id: "noGoods",
      builder: (ctl) {
        return Visibility(
            visible: ctl.data.length == 0,
            child: Container(
              padding: EdgeInsets.only(top: 358.w),
              color: Color(ColorConfig.color_ffffff),
              child: Column(
                children: [
                  pImage("images/icon_goods_empty.png", 270.w, 270.w),
                  pSizeBoxH(24.w),
                  pText("请在搜索栏添加货品", ColorConfig.color_999999, 28.w),
                ],
              ),
            ));
      });
}

back(InventoryEntryController ctl) {
  if (ctl.data.length > 0) {
    showDialog(
        context: Get.context as BuildContext,
        barrierDismissible: false,
        builder: (_) {
          return CustomDialog(
              title: '提示',
              type: 1,
              height: 300,
              content: pText("确定返回吗，返回会清空已经录入的数据", ColorConfig.color_333333, 28.w),
              confirmCallback: (value) {
                BackUtils.back();
              });
        });
  } else {
    BackUtils.back();
  }
}
