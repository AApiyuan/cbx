import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_customer_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';

class BiCustomerOweController extends SuperController {

  static const idOweGoods = "idOweGoods";
  static const idOweAmount = "idOweAmount";
  static const idOweList = "idOweList";
  static const idOweSort = "idOweSort";

  int topDeptId;
  List<int> customerDeptIds;
  bool singleDept;

  BiCustomerTotalDo? customerTotalDo;
  List<BiCustomerDo> customerDataList = [];
  bool hasMore = true;

  OrderBy _orderBy = OrderBy();

  get sortType => _orderBy.field;
  get sortByDesc => _orderBy.by == OrderByEnum.OrderBy.DESC;

  int _currNo = 1;

  BiCustomerOweController(this.topDeptId, this.customerDeptIds, this.singleDept);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _orderBy.field = "orderOweAmount";
    _orderBy.by = OrderByEnum.OrderBy.DESC;
    oweGoodsAndAmount();
    oweList();
  }

  oweGoodsAndAmount() {
    if (customerDeptIds.isEmpty) return;
    var param = BiCustomerPageReq();
    param.topDeptId = topDeptId;
    param.customerDeptIds = customerDeptIds;
    param.filterMerchandiser = singleDept;
    BiDeptApi.selectCustomerTotal(param).then((value) {
      customerTotalDo = value;
      update([idOweAmount, idOweGoods]);
    });
  }

  Future oweList({bool next = false}) async {
    if (customerDeptIds.isEmpty) return;
    BasePage page = BasePage();
    page.pageSize = 20;
    if (next) {
      ++_currNo;
    } else {
      _currNo = 1;
      customerDataList.clear();
    }
    page.pageNo = _currNo;
    var param = BiCustomerPageReq();
    param.topDeptId = topDeptId;
    param.customerDeptIds = customerDeptIds;
    param.orderBy = _orderBy;
    param.filterMerchandiser = singleDept;
    page.param = param;
    return await BiCustomerApi.selectCustomerPage(page).then((value) {
      // var list = value.where((element) => element.balance != 0 || element.shortageNum != 0);
      customerDataList.addAll(value);
      hasMore = value.length == page.pageSize;
      update([idOweList]);
    });
  }

  updateOrderBy(String sortType) {
    if (_orderBy.field == sortType) {
      if (sortByDesc) {
        _orderBy.by = OrderByEnum.OrderBy.ASC;
      } else {
        _orderBy.by = OrderByEnum.OrderBy.DESC;
      }
    } else {
      _orderBy.field = sortType;
      _orderBy.by = OrderByEnum.OrderBy.DESC;
    }
    update([idOweSort]);
    oweList();
  }

  updateDeptIdList(List<int> customerDeptIds) {
    this.customerDeptIds = customerDeptIds;
    oweGoodsAndAmount();
    oweList();
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