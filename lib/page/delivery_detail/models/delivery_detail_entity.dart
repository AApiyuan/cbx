import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class DeliveryDetailEntity with JsonConvert<DeliveryDetailEntity> {
	String? merchandiserName;
	List<DeliveryDetailStoreGoodsList>? storeGoodsList;
	String? updatedTime;
	String? updatedByName;
	String? warehouseName;
	List<DeliveryDetailDeliveryGoodsList>? deliveryGoodsList;
	int? goodsStyleNum;
	int? taxAmount;
	int? warehouseId;
	int? deptId;
	int? customerId;
	String? createUserName;
	String? createdTime;
	int? id;
	int? createdBy;
	String? createdByName;
	int? receivableAmount;
	String? orderSerial;
	int? updatedBy;
	int? topDeptId;
	int? goodsNum;
	String? customizeTime;
	String? deptName;
	String? canceled;
	String? remark;
	String? logisticsCompanyId;
	String? logisticsCompanyName;
	String? logisticsNo;
	String? consigneeImg;
	DeliveryDetailCustomer? customer;
	int? taxReceivableAmount;
	int? merchandiserId;
	int? createUserId;
	DeliveryDetailOrderStock? orderStock;
}

class DeliveryDetailStoreGoodsList with JsonConvert<DeliveryDetailStoreGoodsList> {
	String? imgPath;
	int? id;
	String? goodsNameSerial;
	String? goodsName;
	int? goodsNum;
	String? cover;
	String? goodsSerial;
	List<DeliveryDetailStoreGoodsListDeliveryGoodsList>? deliveryGoodsList;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsList with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsList> {
	String? orderSaleCustomizeTime;
	int? orderDeliveryId;
	List<DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList>? deliveryGoodsSkuList;
	DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo? storeGoodsBaseDo;
	String? updatedTime;
	int? orderSaleGoodsId;
	int? orderSaleId;
	int? warehouseId;
	int? deptId;
	int? goodsId;
	int? taxAmount;
	String? createdTime;
	int? id;
	int? createdBy;
	int? taxPrice;
	int? receivableAmount;
	int? updatedBy;
	int? topDeptId;
	int? goodsNum;
	int? taxReceivableAmount;
	int? price;
	String? orderSaleSerial;
	List<SkuInfoEntity>? orderGoodsVoList;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList> {
	int? id;
	String? createdTime;
	int? orderSaleGoodsSkuId;
	String? updatedTime;
	int? deptId;
	int? warehouseId;
	int? goodsNum;
	int? orderSaleId;
	int? skuId;
	int? createdBy;
	int? orderSaleGoodsId;
	int? orderDeliveryId;
	int? orderDeliveryGoodsId;
	int? updatedBy;
	int? topDeptId;
	int? goodsId;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo> {
	String? cover;
	int? id;
	String? goodsName;
	String? goodsNameSerial;
	String? goodsSerial;
	String? imgPath;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoList with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoList> {
	List<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes>? sizes;
	DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor? goodsColor;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes> {
	DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize? goodsSize;
	DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData? data;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize> {
	int? id;
	int? styleGroupId;
	String? name;
	int? sort;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData> {
	int? id;
	String? createdTime;
	int? orderSaleGoodsSkuId;
	String? updatedTime;
	int? deptId;
	int? warehouseId;
	int? goodsNum;
	int? orderSaleId;
	int? skuId;
	int? createdBy;
	int? orderSaleGoodsId;
	int? orderDeliveryId;
	int? orderDeliveryGoodsId;
	int? updatedBy;
	int? topDeptId;
	int? goodsId;
}

class DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor with JsonConvert<DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor> {
	String? code;
	int? id;
	String? name;
	int? sort;
}

class DeliveryDetailDeliveryGoodsList with JsonConvert<DeliveryDetailDeliveryGoodsList> {
	String? orderSaleCustomizeTime;
	int? orderDeliveryId;
	List<DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList>? deliveryGoodsSkuList;
	DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo? storeGoodsBaseDo;
	String? updatedTime;
	String? remark;
	int? orderSaleGoodsId;
	int? orderSaleId;
	int? warehouseId;
	int? deptId;
	int? goodsId;
	int? taxAmount;
	String? createdTime;
	int? id;
	int? createdBy;
	int? taxPrice;
	int? receivableAmount;
	int? updatedBy;
	int? topDeptId;
	int? goodsNum;
	int? taxReceivableAmount;
	int? price;
	String? orderSaleSerial;
	List<DeliveryDetailDeliveryGoodsListOrderGoodsVoList>? orderGoodsVoList;
}

class DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList with JsonConvert<DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList> {
	int? id;
	String? createdTime;
	int? orderSaleGoodsSkuId;
	String? updatedTime;
	int? deptId;
	int? warehouseId;
	int? goodsNum;
	int? orderSaleId;
	int? skuId;
	int? createdBy;
	int? orderSaleGoodsId;
	int? orderDeliveryId;
	int? orderDeliveryGoodsId;
	int? updatedBy;
	int? topDeptId;
	int? goodsId;
}

class DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo with JsonConvert<DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo> {
	String? cover;
	int? id;
	String? goodsName;
	String? goodsNameSerial;
	String? goodsSerial;
	String? imgPath;
}

class DeliveryDetailDeliveryGoodsListOrderGoodsVoList with JsonConvert<DeliveryDetailDeliveryGoodsListOrderGoodsVoList> {
	List<DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes>? sizes;
	DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor? goodsColor;
}

class DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes with JsonConvert<DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes> {
	DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize? goodsSize;
	DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData? data;
}

class DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize with JsonConvert<DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize> {
	int? id;
	int? styleGroupId;
	String? name;
	int? sort;
}

class DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData with JsonConvert<DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData> {
	int? id;
	String? createdTime;
	int? orderSaleGoodsSkuId;
	String? updatedTime;
	int? deptId;
	int? warehouseId;
	int? goodsNum;
	int? orderSaleId;
	int? skuId;
	int? createdBy;
	int? orderSaleGoodsId;
	int? orderDeliveryId;
	int? orderDeliveryGoodsId;
	int? updatedBy;
	int? topDeptId;
	int? goodsId;
}

class DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor with JsonConvert<DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor> {
	String? code;
	int? id;
	String? name;
	int? sort;
}

class DeliveryDetailCustomer with JsonConvert<DeliveryDetailCustomer> {
	int? orderOweAmount;
	int? id;
	String? levelTag;
	int? oweAmount;
	int? balance;
	String? customerName;
}
class DeliveryDetailOrderStock with JsonConvert<DeliveryDetailOrderStock> {
	int? orderOweAmount;
	int? id;
	String? createdTime;
	String? updatedTime;
	String? orderSerial;
	String? customizeTime;
	String? orderType;
	String? canceled;
	String? status;
	String? orderGoodsType;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? addNum;
	int? subtractNum;
	int? amount;
	int? addAmount;
	int? subtractAmount;
	int? customerId;
	int? orderDeliveryId;
}