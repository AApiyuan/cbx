import 'package:haidai_flutter_module/page/sale_detail/models/check_canceled_sale_res.dart';

checkCanceledSaleResFromJson(CheckCanceledSaleRes data, Map<String, dynamic> json) {
	if (json['hasSale'] != null) {
		data.hasSale = json['hasSale'];
	}
	if (json['hasDeliverySale'] != null) {
		data.hasDeliverySale = json['hasDeliverySale'];
	}
	if (json['hasStoreCustomerBalanceChange'] != null) {
		data.hasStoreCustomerBalanceChange = json['hasStoreCustomerBalanceChange'];
	}
	return data;
}

Map<String, dynamic> checkCanceledSaleResToJson(CheckCanceledSaleRes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['hasSale'] = entity.hasSale;
	data['hasDeliverySale'] = entity.hasDeliverySale;
	data['hasStoreCustomerBalanceChange'] = entity.hasStoreCustomerBalanceChange;
	return data;
}