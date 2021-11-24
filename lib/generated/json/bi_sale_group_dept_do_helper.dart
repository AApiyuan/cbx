import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_do.dart';

biSaleGroupDeptDoFromJson(BiSaleGroupDeptDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
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
	if (json['receivedAmount'] != null) {
		data.receivedAmount = json['receivedAmount'] is String
				? int.tryParse(json['receivedAmount'])
				: json['receivedAmount'].toInt();
	}
	if (json['refundAmount'] != null) {
		data.refundAmount = json['refundAmount'] is String
				? int.tryParse(json['refundAmount'])
				: json['refundAmount'].toInt();
	}
	if (json['totalAmount'] != null) {
		data.totalAmount = json['totalAmount'] is String
				? int.tryParse(json['totalAmount'])
				: json['totalAmount'].toInt();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? int.tryParse(json['oweAmount'])
				: json['oweAmount'].toInt();
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
	if (json['newSaleNum'] != null) {
		data.newSaleNum = json['newSaleNum'] is String
				? int.tryParse(json['newSaleNum'])
				: json['newSaleNum'].toInt();
	}
	return data;
}

Map<String, dynamic> biSaleGroupDeptDoToJson(BiSaleGroupDeptDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['merchandiserNum'] = entity.merchandiserNum;
	data['orderSaleNum'] = entity.orderSaleNum;
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
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	data['totalAmount'] = entity.totalAmount;
	data['balance'] = entity.balance;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['oweAmount'] = entity.oweAmount;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	data['newSaleNum'] = entity.newSaleNum;
	return data;
}