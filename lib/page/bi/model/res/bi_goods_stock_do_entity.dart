import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiGoodsStockDoEntity with JsonConvert<BiGoodsStockDoEntity> {
	int? goodsId;
	String? goodsSerial;
	String? goodsName;
	String? cover;
	String? imgPath;
	int? stockNum;
	int? substandardNum;
	int? shortageNum;
}
