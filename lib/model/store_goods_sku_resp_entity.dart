import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class StoreGoodsSkuRespEntity with JsonConvert<StoreGoodsSkuRespEntity> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
	List<SkuInfoEntity>? orderGoodsVoList;
}
