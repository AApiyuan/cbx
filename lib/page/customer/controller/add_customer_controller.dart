import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/query/hang_order_query.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/star.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/customer_risk_article_page_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_create_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_page_req_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';

class AddCustomerController extends SuperController {
  /// 参数
  var _nameOrPhone = ArgUtils.getArgument(Constant.NAME_OR_PHONE);
  var _deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  var _online = ArgUtils.getArgument2bool(Constant.ONLINE, def: true)!;
  var _customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID)?.toInt();

  /// id
  static const idLevelA = "level_a";
  static const idLevelB = "level_b";
  static const idLevelC = "level_c";
  static const idOften = "often";
  static const idDismiss = "idDismiss";
  static const page = "page";
  static const idTax = "idTax";
  static const idMerchandiser = "idMerchandiser";
  static const idCheck = "idCheck";
  static const idPhone = "idPhone";
  static const idName = "idName";

  /// 检测状态
  static const stateInit = 0;
  static const stateChecking = 1;
  static const stateRecord = 2;
  static const stateEmpty = 3;

  /// 属性
  var _selectLevel = idLevelA;
  var _often = false;
  var _isDismiss = false;
  var _name;
  var _phone;
  var _tax = 0;
  var _checkState = stateInit;
  var _checkRecordNum = 0;
  MerchandiserUserDoEntity? _merchandiserUser;

  bool get online => _online;

  bool get isDismiss => _isDismiss;

  int get tax => _tax;

  int get deptId => _deptId;

  int get checkRecordNum => _checkRecordNum;

  String get merchandiserName => _merchandiserUser?.name ?? "";

  int? get merchandiserId => _merchandiserUser?.id;

  int get checkState => _checkState;

  int? get customerId => _customerId;

  ///方法区
  @override
  void onInit() {
    super.onInit();
    if (_nameOrPhone != null) {
      if (double.tryParse(_nameOrPhone!) == null) {
        _name = _nameOrPhone;
      } else {
        _phone = _nameOrPhone;
      }
    } else if (_customerId != null) {
      loadCustomerToPage();
    }
  }

  bool isSelectLevel(String id) => _selectLevel == id;

  updateLevel(String id) {
    _selectLevel = id;
    update([idLevelC, idLevelB, idLevelA]);
  }

  updateDismiss(bool value) {
    _isDismiss = value;
    update([idDismiss]);
  }

  updateMerchandiser(MerchandiserUserDoEntity merchandiserUserDoEntity) {
    _merchandiserUser = merchandiserUserDoEntity;
    update([idMerchandiser]);
  }

  updateOften(bool often) {
    _often = often;
    update([idOften]);
  }

  updateName(String name) {
    _name = name;
  }

  loadCustomerToPage() async {
    var customer = await CustomerApi.getCustomer(_customerId, online: online);
    switch (customer.levelTag) {
      case "A":
        _selectLevel = idLevelA;
        break;
      case "B":
        _selectLevel = idLevelB;
        break;
      case "C":
        _selectLevel = idLevelC;
        break;
    }
    _name = customer.customerName;
    _phone = customer.customerPhone;
    _often = customer.star == Star.STAR;
    _isDismiss = customer.status == Status.DISABLE;
    _tax = customer.tax ?? 0;
    _merchandiserUser = MerchandiserUserDoEntity();
    _merchandiserUser!.id = customer.merchandiserId;
    _merchandiserUser!.name = customer.merchandiserName;
    update([page]);
  }

  updatePhone(String phone) {
    _phone = phone;
  }

  updateTax(int tax) {
    this._tax = tax;
    update([idTax]);
  }

  bool isOften() => _often;

  get name => _name;

  String? get phone => _phone;

  Future createCustomer() async {
    if (name == null || name.length == 0)
      return Future.error(toastMsg("请输入客户名字"));
    if (await hasName()) return Future.error(toastMsg("客户姓名重复，请修改"));
    if (!checkPhone()) return Future.error(toastMsg("请输入正确的手机号"));
    var req = StoreCustomerCreateReqEntity();
    req.deptId = _deptId;
    req.customerPhone = phone;
    req.customerName = name;
    req.levelTag = "A";
    switch (_selectLevel) {
      case idLevelB:
        req.levelTag = "B";
        break;
      case idLevelC:
        req.levelTag = "C";
        break;
    }
    req.status = _isDismiss ? Status.DISABLE : Status.ENABLE;
    req.star = _often ? Star.STAR : Star.COMMON;
    req.tax = _tax;
    req.merchandiserId = merchandiserId;
    var id;
    if (_customerId == null) {
      id = await CustomerApi.createCustomer(req,
          online: online, customerId: _customerId);
    } else {
      req.id = _customerId;
      return CustomerApi.updateCustomer(req);
    }
    if (_customerId != null) {
      await HangOrderQuery.updateCustomer(_deptId, _customerId!);
    }
    return id;
  }

  bool checkPhone() {
    return phone == null || phone == "" || (phone!.length == 11 && phone!.indexOf("1") == 0);
  }

  Future<bool> hasName() async {
    var param = BasePage();
    var req = StoreCustomerPageReqEntity();
    param.param = req;
    param.pageSize = 10;
    param.pageNo = 1;
    req.customerName = name;
    req.deptId = _deptId;
    var list = await CustomerQuery.select(basePage: param);
    if (list.isEmpty || list.length > 1) {
      return false;
    } else {
      return list[0].id != _customerId;
    }
  }

  Future getCustomerData(int id) {
    return CustomerApi.getCustomer(id, showLoading: true, online: online);
  }

  checkDeadbeat() {
    if (_checkState == stateChecking) return;
    if (phone == null || !checkPhone())
      return Future.error(toastMsg("请输入正确的手机号"));
    _checkState = stateChecking;
    update([idCheck]);
    var page = BasePage();
    var param = CustomerRiskArticlePageReqEntity();
    param.customerDeptId = _deptId;
    param.customerPhone = phone;
    page.param = param;
    CustomerApi.selectCustomerRiskArticleByPageCount(page).then((value) {
      if (value > 0) {
        _checkState = stateRecord;
        _checkRecordNum = value;
      } else {
        _checkState = stateEmpty;
      }
      update([idCheck]);
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
