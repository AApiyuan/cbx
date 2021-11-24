import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

class BiSaleGoodsPageReqEntity with JsonConvert<BiSaleGoodsPageReqEntity> {
	int? topDeptId;
	List<int>? customerDeptIds;
	List<int>? customerIds;
	List<MerchandiserUserList>? merchandiserUserList;
	String? customizeStartTime;
	String? customizeEndTime;
	String? canceled;
	OrderBy? orderBy;
	bool? filterMerchandiser;
}
