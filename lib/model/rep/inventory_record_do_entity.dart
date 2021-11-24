import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/enter/inventory_sku_do_entity.dart';
import 'package:haidai_flutter_module/model/enter/store_goods_base_do_entity.dart';

import '../sku_info_entity.dart';

class InventoryRecordDoEntity with JsonConvert<InventoryRecordDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	dynamic updatedBy;
	String? createdByName;
	dynamic updatedByName;
	int? deptId;
	int? topDeptId;
	int? orderInventoryId;
	String? orderGoodsType;
	late List<InventoryRecordGoods> goods;
}

class InventoryRecordGoods with JsonConvert<InventoryRecordGoods> {
	int? id;
	int? goodsId;
	int? stockNum;
	int? substandardNum;
	late StoreGoodsBaseDoEntity storeGoodsBaseDo;
	late List<OrderGoodsVo> orderGoodsVoList;
	late List<InventorySkuDoEntity> skus;

}

class OrderGoodsVo with JsonConvert<OrderGoodsVo> {
	late StoreGoodsStyleBaseDo goodsColor;
	late List<OrderGoodsSize> sizes;
}

class StoreGoodsStyleBaseDo with JsonConvert<StoreGoodsStyleBaseDo> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class OrderGoodsSize with JsonConvert<OrderGoodsSize> {
	StoreGoodsStyleBaseDo? goodsSize;
	OrderGoodsSkuData? data;
}

///不用的，因为删除太麻烦，等有时间再删除
class InventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSize with JsonConvert<InventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class OrderGoodsSkuData with JsonConvert<OrderGoodsSkuData> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	dynamic updatedBy;
	dynamic createdByName;
	dynamic updatedByName;
	int? orderInventoryId;
	int? orderInventoryRecordId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
	String? orderGoodsType;
	dynamic stockNum;
	dynamic substandardNum;
}
