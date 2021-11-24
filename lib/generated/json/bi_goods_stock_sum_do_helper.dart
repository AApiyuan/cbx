import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_sum_do.dart';

biGoodsStockSumDoFromJson(BiGoodsStockSumDo data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> biGoodsStockSumDoToJson(BiGoodsStockSumDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	return data;
}