import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';

class OrderItemModel {

  var goodsCovers = <String>[];// 封面图
  SaleTypeEnum type;// 类型
  var count;// 货品总数
  var style;// 款式总数
  int price;// 总价

  OrderItemModel(this.type, this.count, this.style, this.price, this.goodsCovers);

  goodsCountText() {
    var text = "";
    switch (type) {
      case SaleTypeEnum.NORMAL_SALE:
        text = "销售$count";
        break;
      case SaleTypeEnum.CHANGE_BACK_ORDER:
        text = "退欠货$count";
        break;
      case SaleTypeEnum.RETURN_GOODS:
        text = "退实物$count";
        break;
    }
    return text;
  }

  goodsStylePriceText() => "$style款/${PriceUtils.getPrice(price)}";

  String? getCover(int index) =>
      goodsCovers.length > index ? goodsCovers[index] : null;
}
