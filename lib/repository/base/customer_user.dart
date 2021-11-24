import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/enum/CustomerUserStatusEnum.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_user_detail_do.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';

class CustomerUserApi {
  /// 跟单人列表（店铺id查询）
  static final String _selectMerchandiserByCustomerDeptId = "/base/customerUser/selectMerchandiserByCustomerDeptId";

  static final String _customerUserDetail = "/base/customerUser/detail";

  static Future<List<MerchandiserUserDoEntity>> selectMerchandiserByCustomerDeptId(num deptId, {String? statusEnum}) async {
    var res = await HttpUtils.get(_selectMerchandiserByCustomerDeptId,
        params: {"customerDeptId": deptId, "status": statusEnum}, baseUrl: Config.BASE_API_URL, showLoading: true);
    return res.map<MerchandiserUserDoEntity>((e) => new MerchandiserUserDoEntity().fromJson(e)).toList();
  }

  static Future<CustomerDeptUserDetailDo> customerUserDetail(int customerUserId, int customerDeptId, {bool showLoading = false}) async {
    var res = await HttpUtils.get(_customerUserDetail,
        params: {"customerUserId": customerUserId, "customerDeptId": customerDeptId}, baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return CustomerDeptUserDetailDo().fromJson(res);
  }
}
