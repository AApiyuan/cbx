import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreCustomerListItemDoEntity with JsonConvert<StoreCustomerListItemDoEntity> {
	int? id;
	int? deptId;
	int? merchandiserId;
	String? merchandiserName;
	String? managerUserName;
	String? customerName;
	String? customerPhone;
	String? customerNamePhone;
	String? customerNamePinYin;
	String? levelTag;
	String? star;
	String? status;
	int? balance;
	int? oweAmount;
	int? oweNum;
	int? orderOweAmount;
	int? userId;
	int? tax;
	//离线，0是在线，1是离线
	int? offline;
}
