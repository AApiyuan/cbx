import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_dept_do.dart';

biSaleGoodsGroupDeptDoFromJson(BiSaleGoodsGroupDeptDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['normalSaleGoodsNum'] != null) {
		data.normalSaleGoodsNum = json['normalSaleGoodsNum'] is String
				? int.tryParse(json['normalSaleGoodsNum'])
				: json['normalSaleGoodsNum'].toInt();
	}
	if (json['normalSaleAmount'] != null) {
		data.normalSaleAmount = json['normalSaleAmount'] is String
				? int.tryParse(json['normalSaleAmount'])
				: json['normalSaleAmount'].toInt();
	}
	if (json['normalSaleTaxAmount'] != null) {
		data.normalSaleTaxAmount = json['normalSaleTaxAmount'] is String
				? int.tryParse(json['normalSaleTaxAmount'])
				: json['normalSaleTaxAmount'].toInt();
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
				? int.tryParse(json['saleGoodsNum'])
				: json['saleGoodsNum'].toInt();
	}
	if (json['saleAmount'] != null) {
		data.saleAmount = json['saleAmount'] is String
				? int.tryParse(json['saleAmount'])
				: json['saleAmount'].toInt();
	}
	if (json['saleTaxAmount'] != null) {
		data.saleTaxAmount = json['saleTaxAmount'] is String
				? int.tryParse(json['saleTaxAmount'])
				: json['saleTaxAmount'].toInt();
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

Map<String, dynamic> biSaleGoodsGroupDeptDoToJson(BiSaleGoodsGroupDeptDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['normalSaleGoodsNum'] = entity.normalSaleGoodsNum;
	data['normalSaleAmount'] = entity.normalSaleAmount;
	data['normalSaleTaxAmount'] = entity.normalSaleTaxAmount;
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