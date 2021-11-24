/**
 * 销售单生成前商品SKU
 */
class SaleGoodsSkuBeforeReq{

  /**
   * 主键
   */
  int? id;

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

  static SaleGoodsSkuBeforeReq fromMap(Map<String, dynamic> map) {
    SaleGoodsSkuBeforeReq saleGoodsSkuBeforeReq = new SaleGoodsSkuBeforeReq();
    saleGoodsSkuBeforeReq.id = map['id'];
    saleGoodsSkuBeforeReq.goodsId = map['goodsId'];
    saleGoodsSkuBeforeReq.skuId = map['skuId'];
    saleGoodsSkuBeforeReq.goodsNum = map['goodsNum'];
    saleGoodsSkuBeforeReq.salePrice = map['salePrice'];
    saleGoodsSkuBeforeReq.taxSalePrice = map['taxSalePrice'];
    saleGoodsSkuBeforeReq.price = map['price'];
    saleGoodsSkuBeforeReq.taxPrice = map['taxPrice'];
    saleGoodsSkuBeforeReq.originalAmount = map['originalAmount'];
    saleGoodsSkuBeforeReq.taxOriginalAmount = map['taxOriginalAmount'];
    saleGoodsSkuBeforeReq.receivableAmount = map['receivableAmount'];
    saleGoodsSkuBeforeReq.taxAmount = map['taxAmount'];
    saleGoodsSkuBeforeReq.discountAmount = map['discountAmount'];
    saleGoodsSkuBeforeReq.taxReceivableAmount = map['taxReceivableAmount'];
    return saleGoodsSkuBeforeReq;
  }
}