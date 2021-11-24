import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class BiGoodsDo with JsonConvert<BiGoodsDo> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
	int? stockNum;
	int? substandardNum;
	int? normalSaleGoodsNum;
	int? returnGoodsNum;
	int? changeBackOrderGoodsNum;
	int? saleGoodsNum;
	int? shortageNum;
	List<SkuInfoEntity>? orderGoodsVoList;
}
