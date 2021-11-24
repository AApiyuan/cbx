import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BatchStockRep with JsonConvert<BatchStockRep> {
	int? id;
	int? deptId;
	String? stockChangeType;
	String? orderGoodsType;
	List<BatchStockRepGoods>? goods;
	String? status;
	BatchStockRepExtra? extra;
}

class BatchStockRepGoods with JsonConvert<BatchStockRepGoods> {
	int? goodsId;
	String? remark;
	List<BatchStockRepGoodsSkus>? skus;
}

class BatchStockRepGoodsSkus with JsonConvert<BatchStockRepGoodsSkus> {
	int? num;
	int? skuId;
}

class BatchStockRepExtra with JsonConvert<BatchStockRepExtra> {
	String? customizeTime;
	String? remark;
	String? changeReason;
	int? orderLabel;
	bool? importUnSaleGoods;
	int? stockOutDeptId;
	int? stockInDeptId;
}
