import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

class BiSaleGoodsPageReq with JsonConvert<BiSaleGoodsPageReq> {
	int? topDeptId;
	String? customizeStartTime;
	String? customizeEndTime;
	List<int>? customerDeptIds;
	List<int>? customerIds;
	List<MerchandiserUserList>? merchandiserUserList;
	List<BiSaleGoodsPageReqCreateUserUserList>? createUserUserList;
	List<BiSaleGoodsPageReqTypes>? types;
	dynamic? canceled;
	List<BiSaleGoodsPageReqLevelTags>? levelTags;
	List<int>? goodsIds;
	int? goodsClassify;
	int? goodsClassifyMiddle;
	int? goodsClassifySmall;
	List<String>? goodsBrands;
	List<String>? goodsYears;
	List<String>? goodsSeasons;
	List<String>? goodsLabels;
	List<String>? excludeColumnFiledNames;
	String? selectType;
	bool? toAllDept;
	OrderBy? orderBy;
	bool? filterMerchandiser;
}

class BiSaleGoodsPageReqMerchandiserUserList with JsonConvert<BiSaleGoodsPageReqMerchandiserUserList> {
	int? id;
	int? deptId;
}

class BiSaleGoodsPageReqCreateUserUserList with JsonConvert<BiSaleGoodsPageReqCreateUserUserList> {
	int? id;
	int? deptId;
}

class BiSaleGoodsPageReqTypes with JsonConvert<BiSaleGoodsPageReqTypes> {
	int? value;
	String? desc;
}

class BiSaleGoodsPageReqLevelTags with JsonConvert<BiSaleGoodsPageReqLevelTags> {
	int? value;
	String? desc;
}

class BiSaleGoodsPageReqOrderBy with JsonConvert<BiSaleGoodsPageReqOrderBy> {
	String? field;
	String? by;
}
