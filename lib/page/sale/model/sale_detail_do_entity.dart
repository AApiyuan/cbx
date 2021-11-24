import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/discount_template_detail_entity.dart';

class SaleDetailDoEntity with JsonConvert<SaleDetailDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	int? topDeptId;
	int? deptId;
	String? configDistribution;
	int? warehouseId;
	String? orderSaleSerial;
	String? type;
	String? customizeTime;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	String? customerAddress;
	int? tax;
	int? originalAmount;
	int? taxOriginalAmount;
	int? receivableAmount;
	int? taxAmount;
	int? discountAmount;
	int? taxReceivableAmount;
	int? checkAmount;
	int? balanceAmount;
	int? wipeOffAmount;
	int? deliveryNum;
	int? deliveryAmount;
	int? canceledNum;
	int? canceledAmount;
	int? shortageNum;
	int? shortageAmount;
	int? incrementStyleNum;
	int? decrementStyleNum;
	int? incrementNum;
	int? decrementNum;
	int? incrementAmount;
	int? decrementAmount;
	int? incrementTaxAmount;
	int? decrementTaxAmount;
	int? normalSaleStyleNum;
	int? normalSaleNum;
	int? normalSaleAmount;
	int? normalSaleTaxAmount;
	int? returnGoodsStyleNum;
	int? returnGoodsNum;
	int? returnGoodsAmount;
	int? returnGoodsTaxAmount;
	int? changeBackOrderGoodsStyleNum;
	int? changeBackOrderGoodsNum;
	int? changeBackOrderGoodsAmount;
	int? changeBackOrderGoodsTaxAmount;
	String? substandard;
	int? printDistributionNum;
	int? distributionNum;
	String? status;
	String? canceled;
	String? createUserName;
	String? merchandiserName;
	SaleDetailDoStoreCustomer? storeCustomer;
	int? printNum;
	List<SaleDetailDoRemarkList>? remarkList;
	List<SaleDetailDoSaleGoodsList>? saleGoodsList;
}

class SaleDetailDoStoreCustomer with JsonConvert<SaleDetailDoStoreCustomer> {
	int? id;
	String? customerName;
	String? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

class SaleDetailDoRemarkList with JsonConvert<SaleDetailDoRemarkList> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	int? orderId;
	String? orderType;
	String? remark;
}

class SaleDetailDoSaleGoodsList with JsonConvert<SaleDetailDoSaleGoodsList> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? customerId;
	int? orderSaleId;
	String? customizeTime;
	String? type;
	int? relationOrderSaleId;
	int? relationOrderSaleGoodsId;
	int? goodsId;
	/// 款号
	String? goodsSerial;
	int? goodsNum;
	int? deliveryNum;
	int? canceledNum;
	int? shortageNum;
	int? salePrice;
	int? taxSalePrice;
	int? price;
	int? taxPrice;
	int? originalAmount;
	int? taxOriginalAmount;
	int? receivableAmount;
	int? taxAmount;
	int? discountAmount;
	int? taxReceivableAmount;
	String? discountType;
	int? discount;
	int? discountTemplateId;
	String? remark;
	SaleDetailDoSaleGoodsListStoreGoods? storeGoods;
	DiscountTemplateDetailEntity? discountTemplateDetail;
	List<SkuInfoEntity>? orderGoodsVoList;
	List<SaleDetailDoSaleGoodsListSaleGoodsSku>? saleGoodsSku;
	/// 外部加入
	String? relationOrderSaleCustomizeTime;
	String? relationOrderSaleSerial;
}

class SaleDetailDoSaleGoodsListStoreGoods with JsonConvert<SaleDetailDoSaleGoodsListStoreGoods> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
	/// 外部添加
	Goods? goods;
}

class SaleDetailDoSaleGoodsListOrderGoodsVoList with JsonConvert<SaleDetailDoSaleGoodsListOrderGoodsVoList> {
	SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor? goodsColor;
	List<SaleDetailDoSaleGoodsListOrderGoodsVoListSizes>? sizes;
}

class SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor with JsonConvert<SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class SaleDetailDoSaleGoodsListOrderGoodsVoListSizes with JsonConvert<SaleDetailDoSaleGoodsListOrderGoodsVoListSizes> {
	SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize? goodsSize;
	SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData? data;
}

class SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize with JsonConvert<SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData with JsonConvert<SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? customerId;
	int? orderSaleId;
	String? customizeTime;
	int? orderSaleGoodsId;
	String? type;
	int? goodsId;
	int? skuId;
	int? goodsNum;
	int? deliveryNum;
	int? distributionNum;
	int? canceledNum;
	int? shortageNum;
	int? salePrice;
	int? taxSalePrice;
	int? price;
	int? taxPrice;
	int? originalAmount;
	int? taxOriginalAmount;
	int? receivableAmount;
	int? taxAmount;
	int? discountAmount;
	int? taxReceivableAmount;
}

class SaleDetailDoSaleGoodsListSaleGoodsSku with JsonConvert<SaleDetailDoSaleGoodsListSaleGoodsSku> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? customerId;
	int? orderSaleId;
	String? customizeTime;
	int? orderSaleGoodsId;
	String? type;
	int? goodsId;
	int? skuId;
	int? goodsNum;
	int? deliveryNum;
	int? distributionNum;
	int? canceledNum;
	int? shortageNum;
	int? salePrice;
	int? taxSalePrice;
	int? price;
	int? taxPrice;
	int? originalAmount;
	int? taxOriginalAmount;
	int? receivableAmount;
	int? taxAmount;
	int? discountAmount;
	int? taxReceivableAmount;
}
