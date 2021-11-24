import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_remit_method_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_time_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';

class BiRemitApi {
  static final String _selectRemitGroupTime = "/bi/remit/selectRemitGroupTime"; //收支柱状
  static final String _selectRemitGroupRemitMethodId = "/bi/remit/selectRemitGroupRemitMethodId"; //BI 查询收退款单按收款方式汇总
  static final String _selectRemitByPage = "/bi/remit/selectRemitByPage"; //BI 查询收退款单按收款方式汇总
  static final String _selectRemitGroupDeptUser = "/bi/remit/selectRemitGroupDeptUser"; //BI 查询收退款单按收款方式汇总

  //收支 柱状
  static Future<List<BiRemitGroupTimeDo>> selectRemitGroupTime(dynamic param) async {
    var res = await HttpUtils.post(_selectRemitGroupTime, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiRemitGroupTimeDo>((e) => new BiRemitGroupTimeDo().fromJson(e)).toList();
  }

  //BI 查询收退款单按收款方式汇总
  static Future<List<BiRemitGroupRemitMethodIdDo>> selectRemitGroupRemitMethodId(dynamic param) async {
    var res = await HttpUtils.post(_selectRemitGroupRemitMethodId, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiRemitGroupRemitMethodIdDo>((e) => new BiRemitGroupRemitMethodIdDo().fromJson(e)).toList();
  }

  //BI 分页查询收退款单信息
  static Future<List<BiRemitDo>> selectRemitByPage(dynamic param) async {
    var res = await HttpUtils.post(_selectRemitByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiRemitDo>((e) => new BiRemitDo().fromJson(e)).toList();
  }

  //员工销售
  static Future<List<BiSaleGroupDeptUserDo>> selectRemitGroupDeptUser(dynamic param) async {
    var res = await HttpUtils.post(_selectRemitGroupDeptUser, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptUserDo>((e) => new BiSaleGroupDeptUserDo().fromJson(e)).toList();
  }
}
