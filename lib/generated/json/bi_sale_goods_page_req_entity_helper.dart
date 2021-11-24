import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

biSaleGoodsPageReqEntityFromJson(BiSaleGoodsPageReqEntity data, Map<String, dynamic> json) {
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['customerDeptIds'] != null) {
		data.customerDeptIds = (json['customerDeptIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['customerIds'] != null) {
		data.customerIds = (json['customerIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['merchandiserUserList'] != null) {
		data.merchandiserUserList = (json['merchandiserUserList'] as List).map((v) => MerchandiserUserList().fromJson(v)).toList();
	}
	if (json['customizeStartTime'] != null) {
		data.customizeStartTime = json['customizeStartTime'].toString();
	}
	if (json['customizeEndTime'] != null) {
		data.customizeEndTime = json['customizeEndTime'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	if (json['filterMerchandiser'] != null) {
		data.filterMerchandiser = json['filterMerchandiser'];
	}
	return data;
}

Map<String, dynamic> biSaleGoodsPageReqEntityToJson(BiSaleGoodsPageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['customerIds'] = entity.customerIds;
	data['merchandiserUserList'] =  entity.merchandiserUserList?.map((v) => v.toJson())?.toList();
	data['customizeStartTime'] = entity.customizeStartTime;
	data['customizeEndTime'] = entity.customizeEndTime;
	data['canceled'] = entity.canceled;
	data['orderBy'] = entity.orderBy?.toJson();
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}