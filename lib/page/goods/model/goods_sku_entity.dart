import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

class GoodsSkuEntity {
  Goods goods;
  SaleDetailDoSaleGoodsList saleGoodsList;
  List<SkuInfoEntity> storeGoodsVos;

  GoodsSkuEntity(this.goods, this.storeGoodsVos, this.saleGoodsList);
}
