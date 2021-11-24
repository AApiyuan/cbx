import 'package:haidai_flutter_module/model/sku_info_entity.dart';

/**
 * 销售单商品SKU
 */
class SaleGoodsSkuReq{

  /**
   * 主键
   */
  int? id;

  /**
   * 关联的销售单id 标记退货和改欠来源
   */
  int? relationOrderSaleId;

  /**
   * 关联的销售单商品id 标记退货和改欠来源
   */
  int? relationOrderSaleGoodsId;

  /**
   * 关联的销售单商品SKU id 标记退货和改欠来源
   */
  int? relationOrderSaleGoodsSkuId;

  /**
   * 商品id 冗余
   */
  int? goodsId;

  /**
   * skuId
   */
  int? skuId;

  /**
   * 数量 销售单为正，退货单为负数
   */
  int? goodsNum;

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
   * 销售额 (含税)
   */
  int? taxReceivableAmount;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["relationOrderSaleId"] = this.relationOrderSaleId;
    map["relationOrderSaleGoodsId"] = this.relationOrderSaleGoodsId;
    map["relationOrderSaleGoodsSkuId"] = this.relationOrderSaleGoodsSkuId;
    map["goodsId"] = this.goodsId;
    map["skuId"] = this.skuId;
    map["goodsNum"] = this.goodsNum;
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
    return map;
  }

  static SaleGoodsSkuReq fromMap(Map<String, dynamic> map) {
    SaleGoodsSkuReq saleGoodsSkuReq = new SaleGoodsSkuReq();
    saleGoodsSkuReq.id = map['id'];
    saleGoodsSkuReq.relationOrderSaleId = map['relationOrderSaleId'];
    saleGoodsSkuReq.relationOrderSaleGoodsId = map['relationOrderSaleGoodsId'];
    saleGoodsSkuReq.relationOrderSaleGoodsSkuId = map['relationOrderSaleGoodsSkuId'];
    saleGoodsSkuReq.goodsId = map['goodsId'];
    saleGoodsSkuReq.skuId = map['skuId'];
    saleGoodsSkuReq.goodsNum = map['goodsNum'];
    saleGoodsSkuReq.salePrice = map['salePrice'];
    saleGoodsSkuReq.taxSalePrice = map['taxSalePrice'];
    saleGoodsSkuReq.price = map['price'];
    saleGoodsSkuReq.taxPrice = map['taxPrice'];
    saleGoodsSkuReq.originalAmount = map['originalAmount'];
    saleGoodsSkuReq.taxOriginalAmount = map['taxOriginalAmount'];
    saleGoodsSkuReq.receivableAmount = map['receivableAmount'];
    saleGoodsSkuReq.taxAmount = map['taxAmount'];
    saleGoodsSkuReq.discountAmount = map['discountAmount'];
    saleGoodsSkuReq.taxReceivableAmount = map['taxReceivableAmount'];
    return saleGoodsSkuReq;
  }
}