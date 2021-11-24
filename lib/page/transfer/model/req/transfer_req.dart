import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferReq with JsonConvert<TransferReq> {
	int? id;
	int? stockOutDeptId;
	int? stockInDeptId;
	int? applyNum;
	int? applyStyleNum;
	int? stockOutNum;
	int? stockOutStyleNum;
	int? stockInNum;
	int? stockInStyleNum;
	bool? autoFinish;
	bool? importUnSaleGoods;
	List<TransferReqGoods>? goods;
	String? customizeTime;
	String? remark;
	dynamic? substandard;
	dynamic? distribution;
	int? orderSaleId;
	int? customerId;
}

class TransferReqGoods with JsonConvert<TransferReqGoods> {
	int? id;
	int? goodsId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? applyNum;
	int? stockOutNum;
	int? stockInNum;
	List<TransferReqGoodsSkus>? skus;
	String? remark;
}

class TransferReqGoodsSkus with JsonConvert<TransferReqGoodsSkus> {
	int? id;
	int? goodsId;
	int? skuId;
	int? applyNum;
	int? stockOutNum;
	int? stockInNum;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
}
