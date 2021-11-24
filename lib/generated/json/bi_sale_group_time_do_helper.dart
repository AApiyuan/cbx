import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_time_do.dart';

biSaleGroupTimeDoFromJson(BiSaleGroupTimeDo data, Map<String, dynamic> json) {
	if (json['timeTitle'] != null) {
		data.timeTitle = json['timeTitle'].toString();
	}
	if (json['merchandiserNum'] != null) {
		data.merchandiserNum = json['merchandiserNum'] is String
				? int.tryParse(json['merchandiserNum'])
				: json['merchandiserNum'].toInt();
	}
	if (json['orderSaleNum'] != null) {
		data.orderSaleNum = json['orderSaleNum'] is String
				? int.tryParse(json['orderSaleNum'])
				: json['orderSaleNum'].toInt();
	}
	if (json['normalSaleGoodsNum'] != null) {
		data.normalSaleGoodsNum = json['normalSaleGoodsNum'] is String
				? double.tryParse(json['normalSaleGoodsNum'])
				: json['normalSaleGoodsNum'].toDouble();
	}
	if (json['normalSaleAmount'] != null) {
		data.normalSaleAmount = json['normalSaleAmount'] is String
				? int.tryParse(json['normalSaleAmount'])
				: json['normalSaleAmount'].toInt();
	}
	if (json['normalSaleTaxAmount'] != null) {
		data.normalSaleTaxAmount = json['normalSaleTaxAmount'] is String
				? double.tryParse(json['normalSaleTaxAmount'])
				: json['normalSaleTaxAmount'].toDouble();
	}
	if (json['timeTitleShorthand'] != null) {
		data.timeTitleShorthand = json['timeTitleShorthand'].toString();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? int.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toInt();
	}
	if (json['returnAmount'] != null) {
		data.returnAmount = json['returnAmount'] is String
				? int.tryParse(json['returnAmount'])
				: json['returnAmount'].toInt();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? int.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toInt();
	}
	if (json['changeBackOrderAmount'] != null) {
		data.changeBackOrderAmount = json['changeBackOrderAmount'] is String
				? int.tryParse(json['changeBackOrderAmount'])
				: json['changeBackOrderAmount'].toInt();
	}
	if (json['saleGoodsNum'] != null) {
		data.saleGoodsNum = json['saleGoodsNum'] is String
				? double.tryParse(json['saleGoodsNum'])
				: json['saleGoodsNum'].toDouble();
	}
	if (json['saleAmount'] != null) {
		data.saleAmount = json['saleAmount'] is String
				? int.tryParse(json['saleAmount'])
				: json['saleAmount'].toInt();
	}
	if (json['saleTaxAmount'] != null) {
		data.saleTaxAmount = json['saleTaxAmount'] is String
				? double.tryParse(json['saleTaxAmount'])
				: json['saleTaxAmount'].toDouble();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? int.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> biSaleGroupTimeDoToJson(BiSaleGroupTimeDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timeTitle'] = entity.timeTitle;
	data['merchandiserNum'] = entity.merchandiserNum;
	data['orderSaleNum'] = entity.orderSaleNum;
	data['normalSaleGoodsNum'] = entity.normalSaleGoodsNum;
	data['normalSaleAmount'] = entity.normalSaleAmount;
	data['normalSaleTaxAmount'] = entity.normalSaleTaxAmount;
	data['timeTitleShorthand'] = entity.timeTitleShorthand;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['returnAmount'] = entity.returnAmount;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['changeBackOrderAmount'] = entity.changeBackOrderAmount;
	data['saleGoodsNum'] = entity.saleGoodsNum;
	data['saleAmount'] = entity.saleAmount;
	data['saleTaxAmount'] = entity.saleTaxAmount;
	data['shortageNum'] = entity.shortageNum;
	data['shortageAmount'] = entity.shortageAmount;
	return data;
}