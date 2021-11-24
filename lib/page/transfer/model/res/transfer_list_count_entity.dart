import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferListCountEntity with JsonConvert<TransferListCountEntity> {
	int? stockInNum = 0;
	int? applyStockInNum;
	int? directStockInNum;
	int? distributeInNum;
	int? substandardInNum;
	int? stockOutNum = 0;
	int? applyStockOutNum;
	int? directStockOutNum;
	int? distributeOutNum;
	int? substandardOutNum;
}
