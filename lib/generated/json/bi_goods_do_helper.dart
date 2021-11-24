import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_do.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

biGoodsDoFromJson(BiGoodsDo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['stockNum'] != null) {
		data.stockNum = json['stockNum'] is String
				? int.tryParse(json['stockNum'])
				: json['stockNum'].toInt();
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'] is String
				? int.tryParse(json['substandardNum'])
				: json['substandardNum'].toInt();
	}
	if (json['normalSaleGoodsNum'] != null) {
		data.normalSaleGoodsNum = json['normalSaleGoodsNum'] is String
				? int.tryParse(json['normalSaleGoodsNum'])
				: json['normalSaleGoodsNum'].toInt();
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
	if (json['saleGoodsNum'] != null) {
		data.saleGoodsNum = json['saleGoodsNum'] is String
				? int.tryParse(json['saleGoodsNum'])
				: json['saleGoodsNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> biGoodsDoToJson(BiGoodsDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	data['normalSaleGoodsNum'] = entity.normalSaleGoodsNum;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['saleGoodsNum'] = entity.saleGoodsNum;
	data['shortageNum'] = entity.shortageNum;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	return data;
}