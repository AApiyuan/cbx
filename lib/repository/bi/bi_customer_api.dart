import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_group_dept_user_do.dart';

class BiCustomerApi {
  static final String _selectCustomerGroupDeptUser = "/bi/customer/selectCustomerGroupDeptUser";// BI 查询客户按店铺员工汇总
  static final String _selectCustomerPageCount = "/bi/customer/selectCustomerPageCount";// 客户 条数
  static final String _selectCustomerPage = "/bi/customer/selectCustomerPage";//BI 管理后台-- 分页查询客户信息

  //BI 查询客户按店铺员工汇总
  static Future<List<BiCustomerGroupDeptUserDo>> selectCustomerGroupDeptUser(dynamic param) async {
    var res = await HttpUtils.post(_selectCustomerGroupDeptUser, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiCustomerGroupDeptUserDo>((e) => new BiCustomerGroupDeptUserDo().fromJson(e)).toList();
  }

  static Future<int> selectCustomerPageCount(dynamic param) async {
    var res = await HttpUtils.post(_selectCustomerPageCount, data: param, baseUrl: Config.BI_API_URL);
    return res;
  }

  static Future<List<BiCustomerDo>> selectCustomerPage(dynamic param) async {
    var res = await HttpUtils.post(_selectCustomerPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiCustomerDo>((e) => new BiCustomerDo().fromJson(e)).toList();
  }

}
