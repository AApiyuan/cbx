import '../enums/SaleGoodsDiscountTypeEnum.dart';
import 'SaleGoodsSkuBeforeReq.dart';
import 'StoreDiscountTemplateBaseDo.dart';
import '../util/EnumCoverUtils.dart';

/**
 * 销售单生成前商品
 */
class SaleGoodsBeforeReq {
  /**
   * 主键
   */
  int? id;

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
  late List<SaleGoodsSkuBeforeReq> goodsSkuBeforeList;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = this.id;
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
    List<Map<String, dynamic>> goodsSkuBeforeList = [];
    for (var goodsSkuBefore in this.goodsSkuBeforeList) {
      goodsSkuBeforeList.add(goodsSkuBefore.toJson());
    }
    map["goodsSkuBeforeList"] = goodsSkuBeforeList;
    return map;
  }

  static SaleGoodsBeforeReq fromMap(Map<String, dynamic> map) {
    SaleGoodsBeforeReq saleGoodsBeforeReq = new SaleGoodsBeforeReq();
    saleGoodsBeforeReq.id = map['id'];
    print(
        "flutter_tag===============================goods=====================================4");
    saleGoodsBeforeReq.goodsId = map['goodsId'];
    print(
        "flutter_tag===============================goods=====================================5");
    saleGoodsBeforeReq.salePrice = map['salePrice'];
    print(
        "flutter_tag===============================goods=====================================6");
    saleGoodsBeforeReq.taxSalePrice = map['taxSalePrice'];
    print(
        "flutter_tag===============================goods=====================================7");
    saleGoodsBeforeReq.price = map['price'];
    print(
        "flutter_tag===============================goods=====================================8");
    saleGoodsBeforeReq.taxPrice = map['taxPrice'];
    print(
        "flutter_tag===============================goods=====================================9");
    saleGoodsBeforeReq.originalAmount = map['originalAmount'];
    print(
        "flutter_tag===============================goods=====================================10");
    saleGoodsBeforeReq.taxOriginalAmount = map['taxOriginalAmount'];
    print(
        "flutter_tag===============================goods=====================================11");
    saleGoodsBeforeReq.receivableAmount = map['receivableAmount'];
    print(
        "flutter_tag===============================goods=====================================12");
    saleGoodsBeforeReq.taxAmount = map['taxAmount'];
    print(
        "flutter_tag===============================goods=====================================13");
    saleGoodsBeforeReq.discountAmount = map['discountAmount'];
    print(
        "flutter_tag===============================goods=====================================14");
    saleGoodsBeforeReq.taxReceivableAmount = map['taxReceivableAmount'];
    print(
        "flutter_tag===============================goods=====================================15");
    saleGoodsBeforeReq.discountType = EnumCoverUtils.stringToEnums(
        map['discountType'], SaleGoodsDiscountTypeEnum.values)!;
    print(
        "flutter_tag===============================goods=====================================16");
    saleGoodsBeforeReq.discount = map['discount'];
    print(
        "flutter_tag===============================goods=====================================17");
    saleGoodsBeforeReq.discountTemplateId = map['discountTemplateId'];
    print(
        "flutter_tag===============================goods=====================================18${map['storeDiscountTemplate']}");
    saleGoodsBeforeReq.storeDiscountTemplate =
        map["storeDiscountTemplate"] != null
            ? StoreDiscountTemplateBaseDo.fromMap(map['storeDiscountTemplate'])
            : null;
    print(
        "flutter_tag===============================goods=====================================19");
    saleGoodsBeforeReq.remark = map['remark'];
    print(
        "flutter_tag===============================goods=====================================20");
    saleGoodsBeforeReq.goodsNum = map['goodsNum'];
    print(
        "flutter_tag===============================goods=====================================21");
    List<SaleGoodsSkuBeforeReq> goodsSkuBeforeList = [];
    for (Map<String, dynamic> goodsSkuBefore in map['goodsSkuBeforeList']) {
      goodsSkuBeforeList.add(SaleGoodsSkuBeforeReq.fromMap(goodsSkuBefore));
    }
    saleGoodsBeforeReq.goodsSkuBeforeList = goodsSkuBeforeList;
    print(
        "flutter_tag===============================goods=====================================ok");
    return saleGoodsBeforeReq;
  }
}
