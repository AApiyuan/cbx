import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BasePage with JsonConvert<BasePage> {
	int? pageSize;
	dynamic param;
	int? pageNo;
}
