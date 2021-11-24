import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

import '../enums/SaleGoodsDiscountTypeEnum.dart';
import 'SaleGoodsSkuReq.dart';
import '../enums/SaleTypeEnum.dart';
import 'StoreDiscountTemplateBaseDo.dart';
import '../util/EnumCoverUtils.dart';

/**
 * 销售单商品
 */
class SaleGoodsReq {
  /**
   * 主键
   */
  int? id;

  /**
   * 订单类型 0：销售：1：改欠货，2：退货
   */
  late SaleTypeEnum type;

  /**
   * 关联的销售单id 标记退货和改欠来源
   */
  int? relationOrderSaleId;

  /**
   * 关联的销售单商品id 标记退货和改欠来源
   */
  int? relationOrderSaleGoodsId;

  /**
   * 货品id
   */
  int? goodsId;

  /**
   * 货品销售价格（A价、B价、C价、最后一次销售价）（不含税）
   */
  int? salePrice;

  /**
   * 货品销售价格（A价、B价、C价、最后一次销售价）（含税）
   */
  int? taxSalePrice;

  /**
   * 货品价格（不含税）
   */
  int? price;

  /**
   * 货品价格（含税）
   */
  int? taxPrice;

  /**
   * 原始销售额（不含税）
   */
  int? originalAmount;

  /**
   * 原始销售额（含税）
   */
  int? taxOriginalAmount;

  /**
   * 销售额（不含税）
   */
  int? receivableAmount;

  /**
   * 税费
   */
  int? taxAmount;

  /**
   * 优惠
   */
  int? discountAmount;

  /**
   *  销售额 (含税)
   */
  int? taxReceivableAmount;

  /**
   * 优惠类型 0：没有促销，1：改价，2：打折，3：优惠模板
   */
  late SaleGoodsDiscountTypeEnum discountType;

  /**
   * 折扣
   */
  int? discount;

  /**
   * 优惠模板
   */
  int? discountTemplateId;

  /**
   * 优惠模板 详情
   */
  StoreDiscountTemplateBaseDo? storeDiscountTemplate;

  /**
   * 备注
   */
  String? remark;

  /**
   * 数量 销售单为正，退货单为负数
   */
  int? goodsNum;

  /**
   * 订单商品 sku
   */
  late List<SaleGoodsSkuReq> goodsSkuList;

  /**
   * 仅录入使用，不是数据内容
   */
  int? oweGoodsId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["type"] = EnumCoverUtils.enumsToString(this.type);
    map["relationOrderSaleId"] = this.relationOrderSaleId;
    map["relationOrderSaleGoodsId"] = this.relationOrderSaleGoodsId;
    map["oweGoodsId"] = this.oweGoodsId;
    map["goodsId"] = this.goodsId;
    map["salePrice"] = this.salePrice;
    map["taxSalePrice"] = this.taxSalePrice;
    map["price"] = this.price;
    map["taxPrice"] = this.taxPrice;
    map["originalAmount"] = this.originalAmount;
    map["taxOriginalAmount"] = this.taxOriginalAmount;
    map["receivableAmount"] = this.receivableAmount;
    map["taxAmount"] = this.taxAmount;
    map["discountAmount"] = this.discountAmount;
    map["taxReceivableAmount"] = this.taxReceivableAmount;
    map["discountType"] = EnumCoverUtils.enumsToString(this.discountType);
    map["discount"] = this.discount;
    map["discountTemplateId"] = this.discountTemplateId;
    map["storeDiscountTemplate"] = this.storeDiscountTemplate;
    map["remark"] = this.remark;
    map["goodsNum"] = this.goodsNum;
    List<Map<String, dynamic>> goodsSkuList = [];
    for (var sku in this.goodsSkuList) {
      goodsSkuList.add(sku.toJson());
    }
    map["goodsSkuList"] = goodsSkuList;
    return map;
  }

  static SaleGoodsReq fromMap(Map<String, dynamic> map) {
    SaleGoodsReq saleGoodsReq = new SaleGoodsReq();
    saleGoodsReq.id = map['id'];
    saleGoodsReq.oweGoodsId = map['oweGoodsId'];
    print(
        "flutter_tag===============================goods=====================================1");
    saleGoodsReq.type =
        EnumCoverUtils.stringToEnums(map['type'], SaleTypeEnum.values)!;
    print(
        "flutter_tag===============================goods=====================================2");
    saleGoodsReq.relationOrderSaleId = map['relationOrderSaleId'];
    print(
        "flutter_tag===============================goods=====================================3");
    saleGoodsReq.relationOrderSaleGoodsId = map['relationOrderSaleGoodsId'];
    print(
        "flutter_tag===============================goods=====================================4");
    saleGoodsReq.goodsId = map['goodsId'];
    print(
        "flutter_tag===============================goods=====================================5");
    saleGoodsReq.salePrice = map['salePrice'];
    print(
        "flutter_tag===============================goods=====================================6");
    saleGoodsReq.taxSalePrice = map['taxSalePrice'];
    print(
        "flutter_tag===============================goods=====================================7");
    saleGoodsReq.price = map['price'];
    print(
        "flutter_tag===============================goods=====================================8");
    saleGoodsReq.taxPrice = map['taxPrice'];
    print(
        "flutter_tag===============================goods=====================================9");
    saleGoodsReq.originalAmount = map['originalAmount'];
    print(
        "flutter_tag===============================goods=====================================10");
    saleGoodsReq.taxOriginalAmount = map['taxOriginalAmount'];
    print(
        "flutter_tag===============================goods=====================================11");
    saleGoodsReq.receivableAmount = map['receivableAmount'];
    print(
        "flutter_tag===============================goods=====================================12");
    saleGoodsReq.taxAmount = map['taxAmount'];
    print(
        "flutter_tag===============================goods=====================================13");
    saleGoodsReq.discountAmount = map['discountAmount'];
    print(
        "flutter_tag===============================goods=====================================14");
    saleGoodsReq.taxReceivableAmount = map['taxReceivableAmount'];
    print(
        "flutter_tag===============================goods=====================================15");
    saleGoodsReq.discountType = EnumCoverUtils.stringToEnums(
        map['discountType'], SaleGoodsDiscountTypeEnum.values)!;
    print(
        "flutter_tag===============================goods=====================================16");
    saleGoodsReq.discount = map['discount'];
    print(
        "flutter_tag===============================goods=====================================17");
    saleGoodsReq.discountTemplateId = map['discountTemplateId'];
    print(
        "flutter_tag===============================goods=====================================18${map['storeDiscountTemplate']}");
    saleGoodsReq.storeDiscountTemplate = map['storeDiscountTemplate'] != null
        ? StoreDiscountTemplateBaseDo.fromMap(map['storeDiscountTemplate'])
        : null;
    print(
        "flutter_tag===============================goods=====================================19");
    saleGoodsReq.remark = map['remark'];
    print(
        "flutter_tag===============================goods=====================================20");
    saleGoodsReq.goodsNum = map['goodsNum'];
    print(
        "flutter_tag===============================goods=====================================21");
    List<SaleGoodsSkuReq> goodsSkuList = [];
    for (Map<String, dynamic> goodsSku in map['goodsSkuList']) {
      goodsSkuList.add(SaleGoodsSkuReq.fromMap(goodsSku));
    }
    saleGoodsReq.goodsSkuList = goodsSkuList;
    print(
        "flutter_tag===============================goods=====================================ok");
    return saleGoodsReq;
  }
}
