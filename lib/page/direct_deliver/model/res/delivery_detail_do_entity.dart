import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class DeliveryDetailDoEntity with JsonConvert<DeliveryDetailDoEntity> {
	int? id;
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? goodsStyleNum;
	int? goodsNum;
	int? customerId;
	String? canceled;
	String? deptName;
	String? warehouseName;
	String? consigneeImg;
	int? logisticsCompanyId;
	String? logisticsCompanyName;
	String? remark;
	String? customizeTime;
	String? logisticsNo;
	DeliveryDetailDoCustomer? customer;
	int? taxReceivableAmount;
	int? receivableAmount;
	int? taxAmount;
	List<DeliveryDetailDoStoreGoodsList>? storeGoodsList;
	List<DeliveryDetailDoDeliveryGoodsList>? deliveryGoodsList;
}

class DeliveryDetailDoCustomer with JsonConvert<DeliveryDetailDoCustomer> {
	int? id;
	String? customerName;
	String? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

class DeliveryDetailDoStoreGoodsList with JsonConvert<DeliveryDetailDoStoreGoodsList> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
	int? goodsNum;
	List<DeliveryDetailDoStoreGoodsListDeliveryGoodsList>? deliveryGoodsList;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsList with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsList> {
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? goodsId;
	int? goodsNum;
	DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo? storeGoodsBaseDo;
	int? price;
	int? taxPrice;
	int? taxReceivableAmount;
	int? receivableAmount;
	int? taxAmount;
	String? orderSaleSerial;
	String? orderSaleCustomizeTime;
	List<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList>? orderGoodsVoList;
	List<DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList>? deliveryGoodsSkuList;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList> {
	DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor? goodsColor;
	List<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes>? sizes;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes> {
	DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize? goodsSize;
	DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData? data;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
	int? styleGroupId;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData> {
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
}

class DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList with JsonConvert<DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList> {
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
}

class DeliveryDetailDoDeliveryGoodsList with JsonConvert<DeliveryDetailDoDeliveryGoodsList> {
	int? id;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? goodsId;
	int? goodsNum;
	DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo? storeGoods;
	int? price;
	int? taxPrice;
	int? taxReceivableAmount;
	int? receivableAmount;
	int? taxAmount;
	String? orderSaleSerial;
	String? orderSaleCustomizeTime;
	String? remark;
	int? shortageNum;
	int? stockNum;
	List<SkuInfoEntity>? orderGoodsVoList;
	List<DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList>? deliveryGoodsSkuList;
}

class DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo with JsonConvert<DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
}

class DeliveryDetailDoDeliveryGoodsListOrderGoodsVoList with JsonConvert<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoList> {
	DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor? goodsColor;
	List<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes>? sizes;
}

class DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor with JsonConvert<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes with JsonConvert<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes> {
	DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize? goodsSize;
	DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData? data;
}

class DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize with JsonConvert<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
	int? styleGroupId;
}

class DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData with JsonConvert<DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData> {
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
}

class DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList with JsonConvert<DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList> {
	int? id;
	int? deptId;
	int? warehouseId;
	int? topDeptId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
}
