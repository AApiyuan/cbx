import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerStatisticEntity with JsonConvert<CustomerStatisticEntity> {
	int? expense;
	int? remitAmount;
	int? tradeAmount;
	int? balance;
	int? income;
	int? wipeOffAmount;
	int? orderOweAmount;
	int? oweAmount;
	int? tradeNum;
	int? deliveryNum;
	int? returnOweNum;
	int? returnNum;
	int? oweNum;
}
