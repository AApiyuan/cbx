import 'package:haidai_flutter_module/page/transfer/model/req/transfer_req.dart';

transferReqFromJson(TransferReq data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
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
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['applyStyleNum'] != null) {
		data.applyStyleNum = json['applyStyleNum'] is String
				? int.tryParse(json['applyStyleNum'])
				: json['applyStyleNum'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['stockOutStyleNum'] != null) {
		data.stockOutStyleNum = json['stockOutStyleNum'] is String
				? int.tryParse(json['stockOutStyleNum'])
				: json['stockOutStyleNum'].toInt();
	}
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['stockInStyleNum'] != null) {
		data.stockInStyleNum = json['stockInStyleNum'] is String
				? int.tryParse(json['stockInStyleNum'])
				: json['stockInStyleNum'].toInt();
	}
	if (json['autoFinish'] != null) {
		data.autoFinish = json['autoFinish'];
	}
	if (json['importUnSaleGoods'] != null) {
		data.importUnSaleGoods = json['importUnSaleGoods'];
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => TransferReqGoods().fromJson(v)).toList();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'];
	}
	if (json['distribution'] != null) {
		data.distribution = json['distribution'];
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	return data;
}

Map<String, dynamic> transferReqToJson(TransferReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockInDeptId'] = entity.stockInDeptId;
	data['applyNum'] = entity.applyNum;
	data['applyStyleNum'] = entity.applyStyleNum;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockOutStyleNum'] = entity.stockOutStyleNum;
	data['stockInNum'] = entity.stockInNum;
	data['stockInStyleNum'] = entity.stockInStyleNum;
	data['autoFinish'] = entity.autoFinish;
	data['importUnSaleGoods'] = entity.importUnSaleGoods;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['customizeTime'] = entity.customizeTime;
	data['remark'] = entity.remark;
	data['substandard'] = entity.substandard;
	data['distribution'] = entity.distribution;
	data['orderSaleId'] = entity.orderSaleId;
	data['customerId'] = entity.customerId;
	return data;
}

transferReqGoodsFromJson(TransferReqGoods data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['skus'] != null) {
		data.skus = (json['skus'] as List).map((v) => TransferReqGoodsSkus().fromJson(v)).toList();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> transferReqGoodsToJson(TransferReqGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsId'] = entity.goodsId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['applyNum'] = entity.applyNum;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['skus'] =  entity.skus?.map((v) => v.toJson())?.toList();
	data['remark'] = entity.remark;
	return data;
}

transferReqGoodsSkusFromJson(TransferReqGoodsSkus data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	return data;
}

Map<String, dynamic> transferReqGoodsSkusToJson(TransferReqGoodsSkus entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['applyNum'] = entity.applyNum;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	return data;
}