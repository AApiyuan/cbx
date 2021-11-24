import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

class GoodsPageParam with JsonConvert<GoodsPageParam> {
	dynamic selectType;
	int? deptId;
	bool? isBasePrice;
	int? customerId;
	String? goodsSerial;
	String? goodsName;
	List<int>? goodsIds;
	String? goodsNameSerial;
	String? orderGoodsType	;
	String? onSaleStartTime;
	String? onSaleEndTime;
	dynamic status;
	int? inventoryId;
	int? goodsClassify;
	List<int>? goodsClassifies;
	int? goodsClassifyMiddle;
	List<int>? goodsClassifyMiddles;
	int? goodsClassifySmall;
	List<int>? goodsClassifySmalls;
	int? supplierId;
	int? goodsBrand;
	List<int>? goodsBrands;
	int? goodsYear;
	List<int>? goodsYears;
	int? goodsSeason;
	List<int>? goodsSeasons;
	int? goodsLabel;
	List<int>? goodsLabels;
	bool? returnCustomerDeliveryNum;
	OrderBy? orderBy;
}
