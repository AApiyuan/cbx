import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreGoodsBaseDoEntity with JsonConvert<StoreGoodsBaseDoEntity> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
}
