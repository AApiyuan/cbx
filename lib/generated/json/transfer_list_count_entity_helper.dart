import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_count_entity.dart';

transferListCountEntityFromJson(TransferListCountEntity data, Map<String, dynamic> json) {
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['applyStockInNum'] != null) {
		data.applyStockInNum = json['applyStockInNum'] is String
				? int.tryParse(json['applyStockInNum'])
				: json['applyStockInNum'].toInt();
	}
	if (json['directStockInNum'] != null) {
		data.directStockInNum = json['directStockInNum'] is String
				? int.tryParse(json['directStockInNum'])
				: json['directStockInNum'].toInt();
	}
	if (json['distributeInNum'] != null) {
		data.distributeInNum = json['distributeInNum'] is String
				? int.tryParse(json['distributeInNum'])
				: json['distributeInNum'].toInt();
	}
	if (json['substandardInNum'] != null) {
		data.substandardInNum = json['substandardInNum'] is String
				? int.tryParse(json['substandardInNum'])
				: json['substandardInNum'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['applyStockOutNum'] != null) {
		data.applyStockOutNum = json['applyStockOutNum'] is String
				? int.tryParse(json['applyStockOutNum'])
				: json['applyStockOutNum'].toInt();
	}
	if (json['directStockOutNum'] != null) {
		data.directStockOutNum = json['directStockOutNum'] is String
				? int.tryParse(json['directStockOutNum'])
				: json['directStockOutNum'].toInt();
	}
	if (json['distributeOutNum'] != null) {
		data.distributeOutNum = json['distributeOutNum'] is String
				? int.tryParse(json['distributeOutNum'])
				: json['distributeOutNum'].toInt();
	}
	if (json['substandardOutNum'] != null) {
		data.substandardOutNum = json['substandardOutNum'] is String
				? int.tryParse(json['substandardOutNum'])
				: json['substandardOutNum'].toInt();
	}
	return data;
}

Map<String, dynamic> transferListCountEntityToJson(TransferListCountEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['stockInNum'] = entity.stockInNum;
	data['applyStockInNum'] = entity.applyStockInNum;
	data['directStockInNum'] = entity.directStockInNum;
	data['distributeInNum'] = entity.distributeInNum;
	data['substandardInNum'] = entity.substandardInNum;
	data['stockOutNum'] = entity.stockOutNum;
	data['applyStockOutNum'] = entity.applyStockOutNum;
	data['directStockOutNum'] = entity.directStockOutNum;
	data['distributeOutNum'] = entity.distributeOutNum;
	data['substandardOutNum'] = entity.substandardOutNum;
	return data;
}