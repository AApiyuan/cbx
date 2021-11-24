import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enter/order_goods_vo_entity.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/shop_car_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/sku_operation_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/sku_bar.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/sku_item.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/button.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/sku_list.dart';

// ignore: must_be_immutable
class GoodsSkuDialog extends StatefulWidget {
  Goods goods;
  List<SkuData> skuList = [];
  bool add;

  GoodsSkuDialog(this.goods, this.skuList, this.add);

  @override
  State<StatefulWidget> createState() {
    return GoodsSkuDialogState();
  }
}

class GoodsSkuDialogState extends State<GoodsSkuDialog> {
  final skuController = Get.find<SkuOperationController>();
  final goodsController = Get.find<GoodsController>();
  String? _stockText;

  @override
  Widget build(BuildContext context) {
    bool showKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;
    print("flutter_tag=======+===$showKeyboard");
    _stockText = goodsController.isSubstandard! ? "次品库存" : "正品库存";
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _closeIcon(),
            _goodsInfo(),
            _skuList(),
            selectButton(showKeyboard),
          ],
        ),
        margin: EdgeInsetsDirectional.only(
          top: 100.w,
        ),
        padding: EdgeInsetsDirectional.only(
          bottom: showKeyboard && Config.isIOS ? 56.w : 0,
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget selectButton(bool showKeyboard) {
    return Visibility(
      child: bottomButton(
        "选好了",
        () {
          if (skuController.selectCount() == 0) {
            toastMsg("请输入数量");
          } else {
            ShopCarController carController = Get.find<ShopCarController>();
            carController.addGoods(
                widget.goods.id!, skuController.skuData, widget.add);
            Get.back();
          }
        },
        padding: EdgeInsetsDirectional.only(
            bottom: 18.w, start: 24.w, end: 24.w, top: 18.w),
      ),
      visible: !showKeyboard,
    );
  }

  Widget _goodsInfo() {
    return Row(
      children: [
        Container(
          child: NetImageWidget(
            "${widget.goods.imgPath}/${widget.goods.cover}",
            goodsId: widget.goods.id!,
          ),
          margin: EdgeInsetsDirectional.only(
              start: 24.w, end: 16.w, top: 44.w, bottom: 17.w),
        ),
        Container(
          height: 140.w,
          margin: EdgeInsetsDirectional.only(top: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.goods.goodsSerial}${widget.goods.goodsName?.length == 0 ? "" : "-${widget.goods.goodsName}"}",
                style: textStyle(bold: true),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GetBuilder<SkuOperationController>(
                    builder: (ctl) {
                      return Text(
                        "${widget.add ? "叠加" : "盘点"}${ctl.selectCount()}",
                        style: textStyle(
                            size: 24,
                            color: ColorConfig.color_1678FF,
                            bold: true),
                      );
                    },
                    id: SkuOperationController.bIdGoods(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _closeIcon() {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 24.w, top: 24.w, bottom: 24.w),
      alignment: Alignment.topRight,
      child: GestureDetector(
        child: Image.asset(
          "images/del_pic.png",
          width: 60.w,
          height: 60.w,
          fit: BoxFit.fill,
        ),
        onTap: () => Get.back(),
      ),
    );
  }

  List<FocusNode>? focusNodes;
  bool _inserted = false;
  late OverlayEntry _overlayEntry;
  FocusNode? currFocus;

  Widget _skuList() {
    if (focusNodes == null) {
      focusNodes = [];
      widget.skuList.forEach((element) {
        var node = FocusNode();
        node.addListener(() => changeFocus());
        focusNodes?.add(node);
      });
    }
    return Expanded(
      child: SkuListView(
          skuBar(stockText: _stockText!),
          (sku, i) => skuItem(
                widget.goods.id!,
                sku,
                _isSkuLast(i),
                isBottom: i == widget.skuList.length - 1,
                focusNode: focusNodes?[i],
              ),
          widget.skuList),
    );
  }

  void changeFocus() {
    bool hasFocus = false;
    focusNodes?.forEach((element) {
      if (element.hasFocus) {
        hasFocus = true;
        currFocus = element;
      }
    });
    // if (Config.isIOS) {
    //   if (hasFocus) {
    //     _insertOverlay();
    //   } else {
    //     _removeOverlay();
    //   }
    // }
  }

  void _insertOverlay() {
    if (_inserted) return;
    OverlayState os = Overlay.of(context)!;
    _inserted = true;
    _overlayEntry = OverlayEntry(builder: (context) {
      final queryData = MediaQuery.of(context);
      return Positioned(
        bottom: queryData.viewInsets.bottom,
        left: 0,
        right: 0,
        child: Container(
          alignment: Alignment.centerRight,
          color: Color(ColorConfig.color_999999),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () => _clearFocus(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  "Done",
                  style: textStyle(size: 30, color: ColorConfig.color_333333),
                ),
              ),
            ),
          ),
        ),
      );
    });
    os.insert(_overlayEntry);
  }

  void _removeOverlay() {
    _inserted = false;
    _overlayEntry.remove();
    /*if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }*/
  }

  _clearFocus() {
    if (currFocus != null) currFocus?.unfocus();
  }

  bool _isSkuLast(int i) {
    return i == widget.skuList.length - 1 || widget.skuList[i + 1].isHeader;
  }
}

class SkuData {
  String? colorName;
  String? sizeName;
  int? goodsId;
  late bool isHeader;
  int? skuId;
  num? stockNum;
  num? inventoryNum;

  SkuData(this.goodsId, this.colorName, this.sizeName, this.isHeader,
      OrderGoodsVoSizesData data) {
    this.skuId = data.skuId!;
    this.stockNum = data.snapStock;
  }

  SkuData.inventory(this.goodsId, this.sizeName, this.skuId, this.stockNum,
      this.inventoryNum) {
    this.isHeader = false;
  }

  SkuData.create(SkuData skuData, bool isHeader) {
    this.colorName = skuData.colorName;
    this.sizeName = skuData.sizeName;
    this.goodsId = skuData.goodsId;
    this.skuId = skuData.skuId;
    this.stockNum = skuData.stockNum;
    this.isHeader = isHeader;
  }
}
