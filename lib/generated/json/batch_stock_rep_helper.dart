import 'package:haidai_flutter_module/page/stock/model/req/batch_stock_rep.dart';

batchStockRepFromJson(BatchStockRep data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['stockChangeType'] != null) {
		data.stockChangeType = json['stockChangeType'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => BatchStockRepGoods().fromJson(v)).toList();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['extra'] != null) {
		data.extra = BatchStockRepExtra().fromJson(json['extra']);
	}
	return data;
}

Map<String, dynamic> batchStockRepToJson(BatchStockRep entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['stockChangeType'] = entity.stockChangeType;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['status'] = entity.status;
	data['extra'] = entity.extra?.toJson();
	return data;
}

batchStockRepGoodsFromJson(BatchStockRepGoods data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['skus'] != null) {
		data.skus = (json['skus'] as List).map((v) => BatchStockRepGoodsSkus().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> batchStockRepGoodsToJson(BatchStockRepGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['remark'] = entity.remark;
	data['skus'] =  entity.skus?.map((v) => v.toJson())?.toList();
	return data;
}

batchStockRepGoodsSkusFromJson(BatchStockRepGoodsSkus data, Map<String, dynamic> json) {
	if (json['num'] != null) {
		data.num = json['num'] is String
				? int.tryParse(json['num'])
				: json['num'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	return data;
}

Map<String, dynamic> batchStockRepGoodsSkusToJson(BatchStockRepGoodsSkus entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['num'] = entity.num;
	data['skuId'] = entity.skuId;
	return data;
}

batchStockRepExtraFromJson(BatchStockRepExtra data, Map<String, dynamic> json) {
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['changeReason'] != null) {
		data.changeReason = json['changeReason'].toString();
	}
	if (json['orderLabel'] != null) {
		data.orderLabel = json['orderLabel'] is String
				? int.tryParse(json['orderLabel'])
				: json['orderLabel'].toInt();
	}
	if (json['importUnSaleGoods'] != null) {
		data.importUnSaleGoods = json['importUnSaleGoods'];
	}
	if (json['stockOutDeptId'] != null) {
		data.stockOutDeptId = json['stockOutDeptId'] is String
				? int.tryParse(json['stockOutDeptId'])
				: json['stockOutDeptId'].toInt();
	}
	if (json['stockInDeptId'] != null) {
		data.stockInDeptId = json['stockInDeptId'] is String
				? int.tryParse(json['stockInDeptId'])
				: json['stockInDeptId'].toInt();
	}
	return data;
}

Map<String, dynamic> batchStockRepExtraToJson(BatchStockRepExtra entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customizeTime'] = entity.customizeTime;
	data['remark'] = entity.remark;
	data['changeReason'] = entity.changeReason;
	data['orderLabel'] = entity.orderLabel;
	data['importUnSaleGoods'] = entity.importUnSaleGoods;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockInDeptId'] = entity.stockInDeptId;
	return data;
}