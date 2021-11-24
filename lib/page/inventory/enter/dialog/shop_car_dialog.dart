import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkDetailsMain.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/shop_car_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/shop_car_goods.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/sku_bar.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/sku_item.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/simple_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/goods_controller.dart';

// ignore: must_be_immutable
class ShopCarDialog extends StatefulWidget {
  final bool onlyCheck;
  GestureTapCallback? function;
  final int? orderId;

  ShopCarDialog({
    this.onlyCheck = false,
    this.orderId,
    this.function,
  });

  @override
  State<StatefulWidget> createState() {
    return ShopCarDialogState(
        onlyCheck: onlyCheck, orderId: orderId, function: function);
  }
}

// ignore: must_be_immutable
class ShopCarDialogState extends State<ShopCarDialog>
    with WidgetsBindingObserver {
  late ShopCarController _carController;
  final bool onlyCheck;
  final int? orderId;
  String? tag;
  GestureTapCallback? function;
  TextEditingController? controller;

  ShopCarDialogState(
      {this.onlyCheck = false, required this.orderId, this.function}) {
    tag = onlyCheck ? CheckDetailsMain.cShopCarTag : null;
    if (onlyCheck) {
      _carController = Get.put<ShopCarController>(
          ShopCarController(onlyCheck: true),
          tag: tag);
      GoodsController goodsController = Get.put(
          GoodsController(onlyCheck: true),
          tag: CheckDetailsMain.cGoodsTag);
      goodsController.recordId = orderId ?? 0;
      //goodsController.recordId = orderId;

    } else {
      _carController = Get.find<ShopCarController>(tag: tag);
      _carController.searchGoods(_carController.searchText);
    }
  }

  @override
  void initState() {
    super.initState();
    print("flutter_tag=======+===initState");
    WidgetsBinding.instance?.addObserver(this);
    if (onlyCheck) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        Get.find<GoodsController>(tag: CheckDetailsMain.cGoodsTag)
            .getOrderGoods(tag: CheckDetailsMain.cShopCarTag)
            .then((value) =>
            _carController.searchGoods(_carController.searchText));
      });
    }
  }

  @override
  void dispose() {
    if (onlyCheck) {
      Get.delete<GoodsController>(tag: CheckDetailsMain.cGoodsTag);
      Get.delete<ShopCarController>(tag: CheckDetailsMain.cShopCarTag);
      // Get.find<GoodsController>(tag: CheckDetailsMainState.cGoodsTag).dispose();
      // _carController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print("flutter_tag=======+===didChangeMetrics");
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bool showKeyboard = MediaQuery
          .of(context)
          .viewInsets
          .bottom > 0;
      print(
          "flutter_tag11111=======+===$showKeyboard====+=====${MediaQuery
              .of(context)
              .viewInsets
              .toString()}");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("flutter_tag=======+===didChangeDependencies");
    bool showKeyboard = MediaQuery
        .of(context)
        .viewInsets
        .bottom > 0;
    print(
        "flutter_tag000=======+===$showKeyboard====+=====${MediaQuery
            .of(context)
            .viewInsets
            .toString()}");
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bool showKeyboard = MediaQuery
          .of(context)
          .viewInsets
          .bottom > 0;
      print(
          "flutter_tag333=======+===$showKeyboard====+=====${MediaQuery
              .of(context)
              .viewInsets
              .toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showKeyboard = MediaQuery
        .of(context)
        .viewInsets
        .bottom > 0;
    print(
        "flutter_tag=======+===$showKeyboard====+=====${MediaQuery
            .of(context)
            .viewInsets
            .toString()}");
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Color(0x88000000),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(ColorConfig.color_ffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(30.w),
                        topStart: Radius.circular(30.w),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      _createTitleBar(context),
                      searchWidget(context),
                      goodsList(),
                    ],
                  ),
                  margin: EdgeInsetsDirectional.only(top: 100.w),
                ),
                // margin: EdgeInsetsDirectional.only(bottom: onlyCheck || showKeyboard ? 0 : 96.w),
              ),
            ),
            Visibility(
              child: Container(
                alignment: Alignment.centerRight,
                height: 96.w,
                child: GestureDetector(
                  child: Container(
                    width: 194.w,
                    color: Colors.transparent,
                  ),
                  onTap: function,
                ),
                // color: Color(ColorConfig.color_1678FF),
              ),
              visible: !onlyCheck && !showKeyboard,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _createTitleBar(BuildContext context) {
    return SizedBox(
      height: 108.w,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Visibility(
              child: GestureDetector(
                child: Padding(
                  child: Text(
                    "清空",
                    style: textStyle(color: ColorConfig.color_ff3715),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 38.w),
                ),
                onTap: () =>
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CheckDialog(
                            "确定清空选择的货品吗？",
                            checkStyle: CheckDialog.redCheckStyle,
                            checkFunction: () {
                              _carController.clearShopCar();
                              Get.back();
                            },
                          ),
                    ),
              ),
              visible: !onlyCheck,
            ),
          ),
          Positioned(
            child: Text(
              onlyCheck ? "盘点数据" : "已录入",
              style: textStyle(size: 32, bold: true),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              margin: EdgeInsetsDirectional.only(
                  end: 24.w, top: 24.w, bottom: 24.w),
              child: GestureDetector(
                child: Image.asset(
                  "images/del_pic.png",
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  closeSearch();
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 76.w,
                margin: EdgeInsetsDirectional.only(
                    start: 24.w, end: 24.w, bottom: 20.w),
                padding: EdgeInsetsDirectional.only(end: 20.w),
                decoration: ShapeDecoration(
                  color: Color(ColorConfig.color_efefef),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadiusDirectional.all(Radius.circular(38.w)),
                  ),
                ),
                child: GetBuilder<ShopCarController>(
                  tag: tag,
                  id: ShopCarController.bIdCarSearchClear,
                  builder: (ctl) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: textStyle(),
                            textInputAction: TextInputAction.search,
                            // controller: TextEditingController.fromValue(
                            //   TextEditingValue(
                            //     text: _carController.searchText,
                            //     // 保持光标在最后
                            //     selection: TextSelection.fromPosition(
                            //       TextPosition(
                            //           affinity: TextAffinity.downstream,
                            //           offset: _carController.searchText.length),
                            //     ),
                            //   ),
                            // ),
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: "搜索品名货号",
                              contentPadding:
                              EdgeInsetsDirectional.only(start: 20.w),
                              hintStyle:
                              textStyle(color: ColorConfig.color_999999),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (text) =>
                                _carController.searchGoods(text),
                            onTap: () => _carController.openSearch(),
                          ),
                        ),
                        /*Visibility(
                          child: GestureDetector(
                            child: Icon(
                              Icons.highlight_remove,
                              size: 34.w,
                            ),
                            onTap: () => _carController.clearSearch(),
                          ),
                          visible: _carController.searchText.length > 0,
                        ),*/
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        GetBuilder<ShopCarController>(
          id: ShopCarController.bIdCarSearchClose,
          tag: tag,
          builder: (ctl) {
            return Visibility(
              child: Container(
                height: 76.w,
                alignment: Alignment.center,
                margin: EdgeInsetsDirectional.only(end: 24.w, bottom: 20.w),
                child: GestureDetector(
                  child: Text(
                    "取消",
                    style: textStyle(color: ColorConfig.color_666666),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => closeSearch(),
                ),
              ),
              visible: _carController.isSearch,
            );
          },
        ),
      ],
    );
  }

  Widget goodsList() {
    return Expanded(
      child: GetBuilder<ShopCarController>(
        tag: tag,
        builder: (ctl) {
          return ListView.builder(
            itemCount: _carController.listCount,
            itemBuilder: (_, index) => listItem(index),
          );
        },
        id: ShopCarController.bIdCarFlex,
      ),
    );
  }

  Widget listItem(int index) {
    dynamic item = _carController.getItemData(index);
    String? gTag = onlyCheck ? CheckDetailsMain.cGoodsTag : null;
    GoodsController goodsController = Get.find(tag: gTag);
    if (item is Goods) {
      return ShopCarGoods(
        item,
        onlyCheck: onlyCheck,
        isSubstandard: goodsController.isSubstandard!,
      );
    } else if (item is SkuData) {
      SkuData skuData = item;

      ///判断是否是货品颜色下的最后一个尺寸，用于显示分割线
      bool lastSku = (_carController.listCount - 1 == index) ||
          (_carController.getItemData(index + 1) is Goods) ||
          (_carController.getItemData(index + 1) as SkuData).colorName !=
              skuData.colorName;
      return skuItem(skuData.goodsId!, skuData, lastSku,
          count: _carController.getGoodsSkuCount(
              skuData.goodsId!, skuData.skuId!));
    } else {
      //String gTag = onlyCheck ? CheckDetailsMainState.cGoodsTag : null;
      //GoodsController goodsController = Get.find(tag: gTag);
      return skuBar(
          stockText: goodsController.isSubstandard! ? "次品库存" : "正品库存");
    }
  }

  closeSearch() {
    controller?.clear();
    _carController.closeSearch();
    FocusScope.of(context).unfocus();
  }
}
