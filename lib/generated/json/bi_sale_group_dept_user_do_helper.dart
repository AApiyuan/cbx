import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';

biSaleGroupDeptUserDoFromJson(BiSaleGroupDeptUserDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['bindPhone'] != null) {
		data.bindPhone = json['bindPhone'].toString();
	}
	if (json['entryTime'] != null) {
		data.entryTime = json['entryTime'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
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
	return data;
}

Map<String, dynamic> biSaleGroupDeptUserDoToJson(BiSaleGroupDeptUserDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['merchandiserId'] = entity.merchandiserId;
	data['merchandiserName'] = entity.merchandiserName;
	data['bindPhone'] = entity.bindPhone;
	data['entryTime'] = entity.entryTime;
	data['status'] = entity.status;
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
	return data;
}