

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/customer_dept_offline_do.dart';
import 'package:haidai_flutter_module/model/rep/customer_dept_offline_req.dart';

class OfflineApi {
  static final String customerDeptOffline = "/base/customerDept/selectCustomerDeptOfflineByParam";

  static Future<List<CustomerDeptOfflineDo>> selectCustomerDeptOffline(CustomerDeptOfflineReq req) async {
    var res = await HttpUtils.post(customerDeptOffline,
      data:req,
      baseUrl: Config.BASE_API_URL,
    );
    return res.map<CustomerDeptOfflineDo>((e) => new CustomerDeptOfflineDo().fromJson(e)).toList();
  }
}