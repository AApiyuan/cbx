import 'package:haidai_flutter_module/model/enter/store_goods_base_do_entity.dart';

storeGoodsBaseDoEntityFromJson(StoreGoodsBaseDoEntity data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> storeGoodsBaseDoEntityToJson(StoreGoodsBaseDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	return data;
}