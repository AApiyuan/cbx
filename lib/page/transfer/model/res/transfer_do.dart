import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/customer_do.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';

class TransferDo with JsonConvert<TransferDo> {
	int? id;
	int? topDeptId;
	String? curType;
	int? stockOutDeptId;
	String? stockOutDeptName;
	int? stockInDeptId;
	String? stockInDeptName;
	String? orderSerial;
	String? orderSaleSerial;
	String? orderSaleCustomizeTime;
	int? orderSaleId;
	int? customerId;
	String? customerName;
	int? orderDeliveryId;
	int? orderStockInId;
	int? orderStockOutId;
	int? stockOutNum;
	int? stockInNum;
	int? applyNum;
	int? stockOutStyleNum;
	int? stockInStyleNum;
	int? applyStyleNum;
	int? shortageNum;
	int? shortageStyleNum;
	int? notDistributionNum;
	int? notDistributionStyleNum;
	dynamic? status;
	dynamic? difference;
	int? differanceMore;
	int? differanceLess;
	dynamic? orderType;
	dynamic? deliveryStatus;
	dynamic? substandard;
	dynamic? distribution;
	String? canceled;
	int? canceledUserId;
	String? canceledUserName;
	String? canceledTime;
	String? customizeTime;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	List<TransferDoGoods>? goods;
	List<Remark>? remarks;
	CustomerDo? storeCustomer;
	TransferActionDo? transferActionDo;

}

class TransferDoGoods with JsonConvert<TransferDoGoods> {
	int? orderTransferId;
	int? goodsId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? stockOutNum;
	int? stockInNum;
	int? stockNum;
	int? substandardNum;
	int? applyNum;
	int? notDistributionNum;
	int? shortageNum;
	int? differanceMore;
	int? differanceLess;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	List<Remark>? remarks;
	String? remark;
	Goods? storeGoodsBaseDo;
	List<SkuInfoEntity>? orderGoodsVoList;
}
