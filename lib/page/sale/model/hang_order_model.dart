import 'dart:convert';

import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/order_item_model.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

import 'offline_gathering_order_model.dart';

class HangOrderModel {
  int? id;
  CreateSaleReq? saleReq;
  CreateSaleBeforeReq? saleBeforeReq;
  List<SaleDetailDoSaleGoodsList>? saleGoodsList;
  Map<int, List>? saleGoodsSku;
  List<SaleDetailDoSaleGoodsList>? returnGoodsList;
  Map<int, List>? returnGoodsSku;
  List<SaleDetailDoSaleGoodsList>? oweGoodsList;
  Map<int, List>? oweGoodsSku;
  int? type;
  int? customerId;
  int? deptId;
  int? userId;
  String? updateTime;
  StoreCustomerListItemDoEntity? customer;
  Map<int, double>? remitAmountMap;
  Map<int, StoreRemitMethodDo>? remitMethodMap;
  OfflineGatheringOrderModel? offlineGatheringOrderModel;

  List<OrderItemModel>? _orderItemList;

  ///店铺名称
  // String? deptName;

  List<OrderItemModel> get orderItemList {
    if (_orderItemList == null) {
      _orderItemList = [];

      var saleCount = 0;
      var saleStyle = 0;
      var salePrice = 0;
      List<String> saleCovers = [];
      saleGoodsList?.forEach((saleGoods) {
        if (type == SaleEnterController.TYPE_QUOTATION) {
          var orderGoods = saleBeforeReq!.goodsBeforeList
              .firstWhere((element) => element.goodsId == saleGoods.goodsId);
          if (orderGoods.goodsNum != 0) {
            saleCount += orderGoods.goodsNum ?? 0;
            saleStyle++;
            salePrice += orderGoods.receivableAmount ?? 0;
            var goods = saleGoods.storeGoods!;
            if (saleCovers.length < 3) {
              saleCovers
                  .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
            }
          }
        } else {
          var orderGoods = saleReq!.goodsList.firstWhere((element) =>
              element.type == SaleTypeEnum.NORMAL_SALE &&
              element.goodsId == saleGoods.goodsId);
          if (orderGoods.goodsNum != 0) {
            saleCount += orderGoods.goodsNum ?? 0;
            saleStyle++;
            salePrice += orderGoods.receivableAmount ?? 0;
            var goods = saleGoods.storeGoods!;
            if (saleCovers.length < 3) {
              saleCovers
                  .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
            }
          }
        }
      });
      if (saleStyle != 0) {
        _orderItemList!.add(OrderItemModel(SaleTypeEnum.NORMAL_SALE, saleCount,
            saleStyle, salePrice, saleCovers));
      }

      if (type != SaleEnterController.TYPE_QUOTATION) {
        var oweCount = 0;
        var oweStyle = 0;
        var owePrice = 0;
        List<String> oweCovers = [];
        oweGoodsList?.forEach((oweGoods) {
          var orderGoods = saleReq!.goodsList.firstWhere((element) =>
              element.type == SaleTypeEnum.CHANGE_BACK_ORDER &&
              element.oweGoodsId == oweGoods.id);
          if (orderGoods.goodsNum != 0) {
            oweCount += orderGoods.goodsNum ?? 0;
            oweStyle++;
            owePrice += orderGoods.receivableAmount ?? 0;
            var goods = oweGoods.storeGoods;
            if (oweCovers.length < 3) {
              oweCovers
                  .add(GoodsUtils.getGoodsCover(goods?.imgPath, goods?.cover));
            }
          }
        });
        if (oweStyle != 0) {
          _orderItemList!.add(OrderItemModel(SaleTypeEnum.CHANGE_BACK_ORDER,
              oweCount, oweStyle, owePrice, oweCovers));
        }

        var returnCount = 0;
        var returnStyle = 0;
        var returnPrice = 0;
        List<String> returnCovers = [];
        returnGoodsList?.forEach((returnGoods) {
          var orderGoods = saleReq!.goodsList.firstWhere((element) =>
              element.type == SaleTypeEnum.RETURN_GOODS &&
              element.goodsId == returnGoods.goodsId);
          if (orderGoods.goodsNum != 0) {
            returnCount += orderGoods.goodsNum ?? 0;
            returnStyle++;
            returnPrice += orderGoods.receivableAmount ?? 0;
            var goods = returnGoods.storeGoods!;
            if (returnCovers.length < 3) {
              returnCovers
                  .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
            }
          }
        });
        if (returnStyle != 0) {
          _orderItemList!.add(OrderItemModel(SaleTypeEnum.RETURN_GOODS,
              returnCount, returnStyle, returnPrice, returnCovers));
        }
      }
    }
    return _orderItemList!;
  }

  get orderRemark {
    return _isQuotation() ? saleBeforeReq?.remark : saleReq?.remark;
  }

  get balanceAmount {
    return _isQuotation()
        ? saleBeforeReq?.balanceAmount
        : saleReq?.balanceAmount;
  }

  get wipeOffAmount {
    return _isQuotation()
        ? saleBeforeReq?.wipeOffAmount
        : saleReq?.wipeOffAmount;
  }

  get tax {
    return _isQuotation() ? saleBeforeReq?.tax : saleReq?.tax;
  }

  get receivableAmount {
    return _isQuotation()
        ? saleBeforeReq?.receivableAmount
        : saleReq?.receivableAmount;
  }

  bool _isQuotation() => type == SaleEnterController.TYPE_QUOTATION;

  HangOrderModel fromJson(Map jsonMap) {
    this.id = jsonMap["id"];
    this.type = jsonMap["type"];
    this.deptId = jsonMap["deptId"];
    this.userId = jsonMap["userId"];
    this.customer = jsonMap["customer"] == null || jsonMap["customer"] == "null"
        ? null
        : StoreCustomerListItemDoEntity()
            .fromJson(jsonDecode(jsonMap["customer"]));
    this.customerId = jsonMap["customerId"];
    this.updateTime = jsonMap["updateTime"];
    this.saleReq = jsonMap["saleReq"] == null || jsonMap["saleReq"] == "null"
        ? null
        : CreateSaleReq.fromMap(jsonDecode(jsonMap["saleReq"]));
    this.saleBeforeReq =
        jsonMap["saleBeforeReq"] == null || jsonMap["saleBeforeReq"] == "null"
            ? null
            : CreateSaleBeforeReq.fromMap(jsonDecode(jsonMap["saleBeforeReq"]));
    this.saleGoodsList = jsonMap["saleGoodsList"] == null || jsonMap["saleGoodsList"] == "null"
        ? null
        : jsonDecode(jsonMap["saleGoodsList"])
            .map<SaleDetailDoSaleGoodsList>(
                (e) => SaleDetailDoSaleGoodsList().fromJson(e))
            .toList();
    this.returnGoodsList = jsonMap["returnGoodsList"] == null || jsonMap["returnGoodsList"] == "null"
        ? null
        : jsonDecode(jsonMap["returnGoodsList"])
            .map<SaleDetailDoSaleGoodsList>(
                (e) => SaleDetailDoSaleGoodsList().fromJson(e))
            .toList();
    this.oweGoodsList = jsonMap["oweGoodsList"] == null || jsonMap["oweGoodsList"] == "null"
        ? null
        : jsonDecode(jsonMap["oweGoodsList"])
            .map<SaleDetailDoSaleGoodsList>(
                (e) => SaleDetailDoSaleGoodsList().fromJson(e))
            .toList();
    this.saleGoodsSku = {};
    var saleSkuModel = jsonMap["saleGoodsSku"] == null
        ? null
        : jsonDecode(jsonMap["saleGoodsSku"])
            .map((e) => GoodsSkuModel().formJson(e))
            .toList();
    saleSkuModel?.forEach((element) {
      this.saleGoodsSku![element.key!] = element.skuList!;
    });
    this.returnGoodsSku = {};
    var returnSkuModel = jsonMap["returnGoodsSku"] == null
        ? null
        : jsonDecode(jsonMap["returnGoodsSku"])
            .map((e) => GoodsSkuModel().formJson(e))
            .toList();
    returnSkuModel?.forEach((element) {
      this.returnGoodsSku![element.key!] = element.skuList!;
    });
    this.oweGoodsSku = {};
    var oweSkuModel = jsonMap["oweGoodsSku"] == null
        ? null
        : jsonDecode(jsonMap["oweGoodsSku"])
            .map((e) => GoodsSkuModel().formJson(e))
            .toList();
    oweSkuModel?.forEach((element) {
      this.oweGoodsSku![element.key!] = element.skuList!;
    });
    Map<String, dynamic> amountMap = jsonMap["remitAmountMap"] == null
        ? {}
        : jsonDecode(jsonMap["remitAmountMap"]);
    this.remitAmountMap = {};
    amountMap
        .forEach((key, value) => this.remitAmountMap![int.parse(key)] = value);
    Map<String, dynamic> methodMap = jsonMap["remitMethodMap"] == null
        ? {}
        : jsonDecode(jsonMap["remitMethodMap"]);
    this.remitMethodMap = {};
    methodMap.forEach((key, value) => this.remitMethodMap![int.parse(key)] =
        StoreRemitMethodDo().fromJson(value));
    this.offlineGatheringOrderModel = jsonMap["offlineGatheringOrder"] == null
        ? null
        : OfflineGatheringOrderModel()
            .fromJson(jsonDecode(jsonMap["offlineGatheringOrder"]));
    return this;
  }
}

class GoodsSkuModel {
  int? key;
  List? skuList;

  Map toJson() {
    Map map = new Map();
    map["key"] = this.key;
    map["skuList"] = jsonEncode(this.skuList);
    return map;
  }

  formJson(Map json) {
    this.key = json["key"];
    this.skuList = jsonDecode(json["skuList"]);
    return this;
  }
}
