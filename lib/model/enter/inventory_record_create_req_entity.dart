import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryRecordCreateReqEntity with JsonConvert<InventoryRecordCreateReqEntity> {
	//int orderInventoryMemberId;
	int? deptId;
	int? id;
	int? orderInventoryId;
	String? orderGoodsType;
	String? recordImg;
	List<InventoryGoodsReq>? goodsList;
}

class InventoryGoodsReq with JsonConvert<InventoryGoodsReq> {
	int? goodsId;
	int? id;
	List<InventorySkuReq>? skuList;
}

class InventorySkuReq with JsonConvert<InventorySkuReq> {
	int? skuId;
	int? id;
	int? goodsNum;
}
