import 'package:haidai_flutter_module/common/sale/enums/SaleSubstandardEnum.dart';

import 'SaleGoodsDetail.dart';

/// 销售单明细
class SaleDetail{

  /// 商品款数
  int? goodsStyleNum;

  /// 商品数量
  int? goodsNum;

  /// 商品金额
  int? goodsAmount;

  /// 次品标志 0:否，1：是 {@link com.kelp.customer.order.enums.SaleSubstandardEnum}
  SaleSubstandardEnum? substandard;

  /// 尺码名称
  List<String>? sizeNameList;

  /// 销售单商品明细
  List<SaleGoodsDetail>? saleGoodsDetailList;
}