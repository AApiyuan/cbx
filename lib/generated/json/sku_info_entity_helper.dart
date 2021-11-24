import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_goods_sku_stock_do_entity.dart';

skuInfoEntityFromJson(SkuInfoEntity data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = SkuInfoGoodsColor().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => SkuInfoSize().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> skuInfoEntityToJson(SkuInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor?.toJson();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	return data;
}

skuInfoGoodsColorFromJson(SkuInfoGoodsColor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> skuInfoGoodsColorToJson(SkuInfoGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

skuInfoSizeFromJson(SkuInfoSize data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = SkuInfoSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = SkuInfoSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> skuInfoSizeToJson(SkuInfoSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

skuInfoSizesGoodsSizeFromJson(SkuInfoSizesGoodsSize data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	return data;
}

Map<String, dynamic> skuInfoSizesGoodsSizeToJson(SkuInfoSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	data['styleGroupId'] = entity.styleGroupId;
	return data;
}

skuInfoSizesDataFromJson(SkuInfoSizesData data, Map<String, dynamic> json) {
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
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['num'] != null) {
		data.num = json['num'] is String
				? int.tryParse(json['num'])
				: json['num'].toInt();
	}
	if (json['stockNum'] != null) {
		data.stockNum = json['stockNum'] is String
				? int.tryParse(json['stockNum'])
				: json['stockNum'].toInt();
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
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['notDistributionNum'] != null) {
		data.notDistributionNum = json['notDistributionNum'] is String
				? int.tryParse(json['notDistributionNum'])
				: json['notDistributionNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'] is String
				? int.tryParse(json['substandardNum'])
				: json['substandardNum'].toInt();
	}
	if (json['oweNum'] != null) {
		data.oweNum = json['oweNum'] is String
				? int.tryParse(json['oweNum'])
				: json['oweNum'].toInt();
	}
	if (json['notArrivedNum'] != null) {
		data.notArrivedNum = json['notArrivedNum'] is String
				? int.tryParse(json['notArrivedNum'])
				: json['notArrivedNum'].toInt();
	}
	if (json['saleNum'] != null) {
		data.saleNum = json['saleNum'] is String
				? int.tryParse(json['saleNum'])
				: json['saleNum'].toInt();
	}
	if (json['returnNum'] != null) {
		data.returnNum = json['returnNum'] is String
				? int.tryParse(json['returnNum'])
				: json['returnNum'].toInt();
	}
	if (json['trade'] != null) {
		data.trade = json['trade'] is String
				? int.tryParse(json['trade'])
				: json['trade'].toInt();
	}
	if (json['customerDeliveryNum'] != null) {
		data.customerDeliveryNum = json['customerDeliveryNum'] is String
				? int.tryParse(json['customerDeliveryNum'])
				: json['customerDeliveryNum'].toInt();
	}
	if (json['snapStock'] != null) {
		data.snapStock = json['snapStock'] is String
				? int.tryParse(json['snapStock'])
				: json['snapStock'].toInt();
	}
	if (json['inventoryStock'] != null) {
		data.inventoryStock = json['inventoryStock'] is String
				? int.tryParse(json['inventoryStock'])
				: json['inventoryStock'].toInt();
	}
	if (json['canSell'] != null) {
		data.canSell = json['canSell'] is String
				? int.tryParse(json['canSell'])
				: json['canSell'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['relationOrderSaleId'] != null) {
		data.relationOrderSaleId = json['relationOrderSaleId'] is String
				? int.tryParse(json['relationOrderSaleId'])
				: json['relationOrderSaleId'].toInt();
	}
	if (json['relationOrderSaleGoodsId'] != null) {
		data.relationOrderSaleGoodsId = json['relationOrderSaleGoodsId'] is String
				? int.tryParse(json['relationOrderSaleGoodsId'])
				: json['relationOrderSaleGoodsId'].toInt();
	}
	if (json['relationOrderSaleGoodsSkuId'] != null) {
		data.relationOrderSaleGoodsSkuId = json['relationOrderSaleGoodsSkuId'] is String
				? int.tryParse(json['relationOrderSaleGoodsSkuId'])
				: json['relationOrderSaleGoodsSkuId'].toInt();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? int.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toInt();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? int.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toInt();
	}
	if (json['normalSaleGoodsNum'] != null) {
		data.normalSaleGoodsNum = json['normalSaleGoodsNum'] is String
				? int.tryParse(json['normalSaleGoodsNum'])
				: json['normalSaleGoodsNum'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['storeGoodsSkuStockDo'] != null) {
		data.storeGoodsSkuStockDo = StoreGoodsSkuStockDoEntity().fromJson(json['storeGoodsSkuStockDo']);
	}
	return data;
}

Map<String, dynamic> skuInfoSizesDataToJson(SkuInfoSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsId'] = entity.goodsId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['skuId'] = entity.skuId;
	data['num'] = entity.num;
	data['stockNum'] = entity.stockNum;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['applyNum'] = entity.applyNum;
	data['notDistributionNum'] = entity.notDistributionNum;
	data['shortageNum'] = entity.shortageNum;
	data['substandardNum'] = entity.substandardNum;
	data['oweNum'] = entity.oweNum;
	data['notArrivedNum'] = entity.notArrivedNum;
	data['saleNum'] = entity.saleNum;
	data['returnNum'] = entity.returnNum;
	data['trade'] = entity.trade;
	data['customerDeliveryNum'] = entity.customerDeliveryNum;
	data['snapStock'] = entity.snapStock;
	data['inventoryStock'] = entity.inventoryStock;
	data['canSell'] = entity.canSell;
	data['goodsNum'] = entity.goodsNum;
	data['relationOrderSaleId'] = entity.relationOrderSaleId;
	data['relationOrderSaleGoodsId'] = entity.relationOrderSaleGoodsId;
	data['relationOrderSaleGoodsSkuId'] = entity.relationOrderSaleGoodsSkuId;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['normalSaleGoodsNum'] = entity.normalSaleGoodsNum;
	data['canceledNum'] = entity.canceledNum;
	data['storeGoodsSkuStockDo'] = entity.storeGoodsSkuStockDo?.toJson();
	return data;
}