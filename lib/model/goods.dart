import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class Goods with JsonConvert<Goods> {
  int? deptId;
  int? stockNum;
  int? substandardNum;
  int? saleNum;
  int? oweNum;
  String? goodsSerial;
  String? onSaleTime;
  dynamic status;
  int? sailingPrice;
  int? takingPrice;
  int? packagePrice;
  int? costPrice;
  int? lastBuyPrice;
  int? goodsClassify;
  String? cover;
  String? goodsName;
  String? imgPath;
  int? supplierId;
  int? goodsBrand;
  int? goodsYear;
  int? goodsSeason;
  int? goodsLabel;
  int? customerDeliveryNum;
  int? id;
  String? createdTime;
  String? updatedTime;
  int? createdBy;
  int? updatedBy;
  String? createdByName;
  String? updatedByName;
  List<SkuInfoEntity>? storeGoodsSkuList;//离线需要的
}
