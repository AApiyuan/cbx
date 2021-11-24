import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/customer_do.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_goods_base_do.dart';

class OrderStockNewDo with JsonConvert<OrderStockNewDo> {
	int? deptId;
	String? deptName;
	int? stockOutDeptId;
	String? stockOutDeptName;
	int? stockInDeptId;
	String? stockInDeptName;
	int? topDeptId;
	int? packageId;
	String? orderSerial;
	String? customizeTime;
	dynamic? orderType;
	int? orderLabel;
	String? orderLabelName;
	int? addNum;
	int? subtractNum;
	int? amount;
	int? addAmount;
	int? subtractAmount;
	int? customerId;
	CustomerDo? customerDo;
	int? supplierId;
	int? supplierName;
	int? orderDeliveryId;
	int? orderSaleId;
	int? orderDistributionId;
	int? orderTransferId;
	dynamic? orderGoodsType;
	dynamic? canceled;
	dynamic? status;
	int? canceledUserId;
	String? canceledUserName;
	String? canceledTime;
	String? remark;
	String? changeReason;
	List<OrderStockNewDoGoods>? goods;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class OrderStockNewDoGoods with JsonConvert<OrderStockNewDoGoods> {
	int? id;
	int? orderStockId;
	int? deptId;
	int? addNum;
	int? subtractNum;
	int? substandardNum;
	int? goodsId;
	Goods? storeGoodsBaseDo;
	String? remark;
	dynamic? orderGoodsType;
	dynamic? canceled;
	int? canceledUserId;
	int? canceledTime;
	List<SkuInfoEntity>? orderGoodsVoList;
}
