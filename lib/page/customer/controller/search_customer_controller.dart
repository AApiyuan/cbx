import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as By;
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_page_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/customer_user.dart';

class SearchCustomerController extends SuperController {
  ///id
  static var idSearchClear = "search_clear";

  static var idAzSort = "az_sort";
  static var idFilterPerson = "filter_person";
  static var idFilterOwe = "filter_owe";
  static var idFilterOweGoods = "filter_owe_goods";
  static var idFilterSearch = "filter_search";

  static var idCustomerList = "customer_list";

  ///参数
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var online = ArgUtils.getArgument2bool(Constant.ONLINE, def: true)!;

  /// 属性
  var _searchText = "";
  var _filterId = idAzSort;
  var _filterState = 0;
  var _selectPersonId;
  var _personListData = <MerchandiserUserDoEntity>[];
  var noMore = false;
  var _customerList = <StoreCustomerListItemDoEntity>[];
  var _page = BasePage();

  ///方法区

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCustomerData(false);
  }

  updateFilter(String id) {
    if (id == _filterId) {
      _filterState = _filterState == 2 ? 1 : (_filterState + 1);
    } else {
      _filterId = id;
      _filterState = 1;
      if (_filterId != idFilterPerson) _selectPersonId = null;
    }
    getCustomerData(false);
    update([idAzSort, idFilterOweGoods, idFilterOwe, idFilterPerson]);
  }

  bool isCurrFilter(String id) => _filterId == id;

  int getCurrFilterState(String id) => isCurrFilter(id) ? _filterState : 0;

  Future<List<MerchandiserUserDoEntity>> getPersonListData() {
    if (_personListData.isEmpty) {
      return CustomerUserApi.selectMerchandiserByCustomerDeptId(deptId!)
          .then((value) => _personListData = value);
    } else {
      return Future.value(_personListData);
    }
  }

  updateSelectPersonId(int? id) {
    _selectPersonId = id;
    updateFilter(idFilterPerson);
  }

  int? selectPersonId() => _selectPersonId;

  /// 更新搜索字段
  void updateSearchText(String searchText) {
    _searchText = searchText;
    update([idSearchClear]);
  }

  search(String text) {
    updateSearchText(text);
    updateFilter(text.isNotEmpty ? idFilterSearch : idAzSort);
  }

  String getSearchText() => _searchText;

  List<StoreCustomerListItemDoEntity> getCustomerList() => _customerList;

  StoreCustomerListItemDoEntity getCustomerItem(int index) => _customerList[index];

  Future getCustomerData(bool next) async {
    if (next) {
      _page.pageNo = _page.pageNo! + 1;
    } else {
      _resetParam();
    }
    return await CustomerApi.customerPage(_page, online: online).then((value) {
      noMore = value.length < _page.pageSize!;
      _customerList.addAll(value);
      update([idCustomerList]);
    });
  }

  _resetParam() {
    _page.pageNo = 1;
    _page.pageSize = 15;
    var param = StoreCustomerPageReqEntity();
    param.deptId = deptId;
    param.selectType = SelectType.BASIC_STATIC;
    param.status = Status.ENABLE;
    if (_filterId == idFilterSearch) {
      param.customerNamePhone = _searchText;
    } else {
      if (idFilterPerson == _filterId) {
        param.merchandiserIds = [_selectPersonId];
      } else {
        var orderBy = OrderBy();
        if (idAzSort == _filterId) {
          orderBy.field = "customerNamePinYin";
          orderBy.by = By.OrderBy.ASC;
        } else {
          orderBy.by = _filterState == 1 ? By.OrderBy.DESC : By.OrderBy.ASC;
          orderBy.field = _filterId == idFilterOwe ? "oweAmount" : "oweNum";
        }
        param.orderBy = orderBy;
      }
    }
    _page.param = param;
    _customerList.clear();
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
