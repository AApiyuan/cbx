import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/store/req/dept_and_relation_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';

class UserApi {
  /// 查询登录用户
  static final String _getUser = "/base/login/getUser";

  /// 体验账号登录
  static final String _loginExperienceAccount = "/base/login/loginExperienceAccountByPhoneCode";

  /// 手机发送短信验证码
  static final String _sendCode = "/base/login/sendCodeByPhone";

  static const String SELECT_DEPT = "base/customerDept/selectByLoginCustomerUser";

  static const String SELECT_DEPT_BI = "/base/customerDept/selectByLoginCustomerUserAndAppBi";

  static const String SELECT_VIDEO = "/base/video/page";

  static Future<CustomerUserDo> getUser() async {
    var res = await HttpUtils.get(_getUser, baseUrl: Config.BASE_API_URL, showLoading: false);
    return CustomerUserDo().fromJson(res);
  }

  /// 获取登录用户有权限的店铺列表
  static Future<List<CustomerDeptDetailAndRoleDo>> selectDept(DeptAndRelationReq param, {showLoading: false}) async {
    var res = await HttpUtils.post(SELECT_DEPT, data: param, baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return res.map<CustomerDeptDetailAndRoleDo>((e) => new CustomerDeptDetailAndRoleDo().fromJson(e)).toList();
  }

  /// BI获取登录用户有权限的店铺列表
  static Future<List<CustomerDeptDetailAndRoleDo>> selectByLoginCustomerUserAndAppBi(DeptAndRelationReq param, {showLoading: false}) async {
    var res = await HttpUtils.post(SELECT_DEPT_BI, data: param, baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return res.map<CustomerDeptDetailAndRoleDo>((e) => new CustomerDeptDetailAndRoleDo().fromJson(e)).toList();
  }

  static Future<bool> sendCode(dynamic param, {bool showLoad = false}) async {
    var res = await HttpUtils.post(_sendCode, data: param, baseUrl: Config.BASE_API_URL, showLoading: showLoad);
    return res;
  }

  static Future<String> loginExperienceAccount(dynamic param, {bool showLoad = false}) async {
    var res = await HttpUtils.post(_loginExperienceAccount, data: param, baseUrl: Config.BASE_API_URL, showLoading: showLoad);
    return res;
  }

  //查看视频
  static Future<List<AdminVideoDo>> selectVideo({showLoading: false}) async {
    BasePage basePage = new BasePage();
    basePage.pageNo=1;
    basePage.pageSize=999;
    Map param = {"status": CanceledEnum.ENABLE};
    basePage.param = param;
    var res = await HttpUtils.post(SELECT_VIDEO, data: basePage, baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return res.map<AdminVideoDo>((e) => new AdminVideoDo().fromJson(e)).toList();
  }
}
