

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';

class OssApi {
  static const String OSS_STS = 'base/aliyunOss/getSts';
  static const String OSS_DOMAIN = '/base/aliyunOss/getOssDomain';

  static Future getOssDomain() async {
    var res = await HttpUtils.get(OSS_DOMAIN, baseUrl: Config.BASE_API_URL);
    return res;
  }

  static Future getNewSts() async {
    Map<String, dynamic> map = new Map();
    map['roleSessionName'] = "Flutter";
    var res = await HttpUtils.get(OSS_STS, baseUrl: Config.BASE_API_URL, params: map);
    return res;
  }
}
