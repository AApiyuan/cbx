import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

class InventoryReportGoodsPage with JsonConvert<InventoryReportGoodsPage> {
	int? orderInventoryId;
	String? orderGoodsType;
	String? isInventory;
	String? goodsNameSerial;
	int? goodsClassify;
	List<int>? goodsClassifies;
	int? goodsClassifyMiddle;
	List<int>? goodsClassifyMiddles;
	int? goodsClassifySmall;
	List<int>? goodsClassifySmalls;
	int? goodsBrand;
	List<int>? goodsBrands;
	int? goodsYear;
	List<int>? goodsYears;
	int? goodsSeason;
	List<int>? goodsSeasons;
	int? goodsLabel;
	List<int>? goodsLabels;
	OrderBy? orderBy;
}
