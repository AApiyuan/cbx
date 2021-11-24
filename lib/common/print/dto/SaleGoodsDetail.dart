/// 销售单明细
class SaleGoodsDetail{

  /// 商品ID
  int? goodsId;

  /// 款号
  String? goodsSerial;

  /// 颜色
  String? colorName;

  /// 商品尺码数量
  List<int>? sizeNumList;

  /// 商品数量
  int? goodsNum;

  /// 商品单价
  int? goodsPrice;

  /// 商品金额
  int? goodsAmount;

  /// 商品尺码名称
  List<String>? goodsSizeNameList;

  /// 商品尺码数量
  List<int>? goodsSizeNumList;
}