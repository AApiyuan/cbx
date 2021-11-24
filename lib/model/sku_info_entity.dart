import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/store_goods_sku_stock_do_entity.dart';

class SkuInfoEntity with JsonConvert<SkuInfoEntity> {
	SkuInfoGoodsColor? goodsColor;
	List<SkuInfoSize>? sizes;
}

class SkuInfoGoodsColor with JsonConvert<SkuInfoGoodsColor> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class SkuInfoSize with JsonConvert<SkuInfoSize> {
	SkuInfoSizesGoodsSize? goodsSize;
	SkuInfoSizesData? data;
}

class SkuInfoSizesGoodsSize with JsonConvert<SkuInfoSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
	///分组id
	int? styleGroupId;
}

class SkuInfoSizesData with JsonConvert<SkuInfoSizesData> {
	int? id;
	int? goodsId;
	int? orderSaleId;
	int? orderSaleGoodsId;
	int? orderSaleGoodsSkuId;
	int? skuId;
	int? num;
	int? stockNum;
	int? stockOutNum;
	int? stockInNum;
	int? applyNum;
	int? notDistributionNum;
	int? shortageNum;
	int? substandardNum;
	int? oweNum;
	int? notArrivedNum;
	int? saleNum;
	int? returnNum;
	int? trade;
	int? customerDeliveryNum;
	int? snapStock;
	int? inventoryStock;
	int? canSell;
	int? goodsNum;
	int? relationOrderSaleId;
	int? relationOrderSaleGoodsId;
	int? relationOrderSaleGoodsSkuId;
	int? returnGoodsNum;
	int? changeBackOrderGoodsNum;
	int? normalSaleGoodsNum;
	int? canceledNum;
	StoreGoodsSkuStockDoEntity? storeGoodsSkuStockDo;
}
