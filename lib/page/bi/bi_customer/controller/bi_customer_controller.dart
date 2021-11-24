import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_owe_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_sale_api.dart';

class BiCustomerController extends SuperController {

  static const TYPE_SALE = 0;
  static const TYPE_OWE = 1;

  static const SALE_LIST_TYPE_SALE = 0;
  static const SALE_LIST_TYPE_OWE = 1;
  static const SALE_LIST_TYPE_RETURN = 2;
  static const SALE_LIST_TYPE_TOTAL = 3;
  static const SALE_LIST_TYPE_REMIT = 4;

  /// id
  static const idSaleStatement = "saleStatement";
  static const idStatement = "statement";
  static const idStatementSort = "statementSort";
  static const idDeptTotal = "idDeptTotal";

  /// 参数
  var topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID)!.toInt();
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var type = ArgUtils.getArgument2num(Constant.TYPE, def: TYPE_SALE)!.toInt();
  var startTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
  var endTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

  /// 属性
  var listType = 0;
  var _orderBy = OrderBy();
  var customerDeptIds = <int>[];

  get sortType => _orderBy.field;

  get sortByDesc => _orderBy.by == OrderByEnum.OrderBy.DESC;

  get singleDept => deptId != null;

  var _currNo = 1;

  var statementHasMore = true;

  BiSaleSumDo? saleStatementData;
  List<dynamic> statementList = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (deptId != null) {
      updateDeptIdList([deptId!]);
    } else {
      BiDeptApi.getDeptSelected().then((v) {
        updateDeptIdList(v);
      });
    }
  }

  updateTime(String start, String end) {
    endTime = end;
    startTime = start;
    saleData();
    updateListType(listType);
  }

  Future statementData({bool next = false}) async {
    var param = BasePage();
    if (next) {
      ++_currNo;
    } else {
      _currNo = 1;
      statementList.clear();
    }
    param.pageNo = _currNo;
    param.pageSize = 20;
    var req = BiSaleGoodsPageReqEntity();
    req.canceled = CanceledEnum.ENABLE;
    req.customizeEndTime = endTime;
    req.customizeStartTime = startTime;
    req.customerDeptIds = customerDeptIds;
    req.topDeptId = topDeptId;
    req.orderBy = _orderBy;
    req.filterMerchandiser = singleDept;
    param.param = req;
    if (listType == SALE_LIST_TYPE_REMIT) {
      return await BiDeptApi.selectRemitGroupCustomerByPage(param)
          .then((value) => statementList.addAll(value))
          .then((value) => statementHasMore = statementList.isNotEmpty &&
              statementList.length % param.pageSize! == 0)
          .then((value) => update([idStatement]));
    }
    return await BiSaleApi.selectSaleGoodsGroupCustomerByPage(param)
        .then((value) {
      statementHasMore = value.length == param.pageSize;
      // var list = value.where((element) => checkItem(element));
      statementList.addAll(value);
      update([idStatement]);
    });
  }

  checkItem(BiSaleGoodsGroupCustomerDoEntity element) {
    switch (listType) {
      case SALE_LIST_TYPE_SALE:
        return element.normalSaleTaxAmount! != 0 ||
            element.normalSaleGoodsNum! != 0;
      case SALE_LIST_TYPE_OWE:
        return element.changeBackOrderAmount! != 0 ||
            element.changeBackOrderGoodsNum! != 0;
      case SALE_LIST_TYPE_RETURN:
        return element.returnAmount! != 0 || element.returnGoodsNum! != 0;
      case SALE_LIST_TYPE_TOTAL:
        return element.saleTaxAmount! != 0 || element.saleGoodsNum! != 0;
    }
  }

  Future saleData() {
    var param = BasePage();
    var req = BiSalePageReq();
    req.topDeptId = topDeptId;
    req.customerDeptIds = customerDeptIds;
    req.customizeStartTime = startTime;
    req.customizeEndTime = endTime;
    req.canceled = CanceledEnum.ENABLE;
    req.filterMerchandiser = singleDept;
    param.param = req;
    return BiSaleApi.selectSaleByPageSum(param)
        .then((value) => saleStatementData = value)
        .then((value) => update([idSaleStatement]));
  }

  updateDeptIdList(List<int> customerDeptIds) {
    this.customerDeptIds = customerDeptIds;
    update([idDeptTotal]);
    updateTime(startTime, endTime);
    if (Get.isRegistered<BiCustomerOweController>()) {
      Get.find<BiCustomerOweController>().updateDeptIdList(customerDeptIds);
    }
  }

  void updateListType(index) {
    listType = index;
    switch (listType) {
      case SALE_LIST_TYPE_SALE:
        _orderBy.field = "normalSaleGoodsNum"; // : "normalSaleTaxAmount";
        break;
      case SALE_LIST_TYPE_OWE:
        _orderBy.field =
            "changeBackOrderGoodsNum"; // : "changeBackOrderAmount";
        break;
      case SALE_LIST_TYPE_RETURN:
        _orderBy.field = "returnGoodsNum"; // : "returnAmount";
        break;
      case SALE_LIST_TYPE_TOTAL:
        _orderBy.field = "saleGoodsNum"; // : "saleTaxAmount";
        break;
      case SALE_LIST_TYPE_REMIT:
        _orderBy.field = "receivedAmount";
        break;
    }
    updateOrderBy(_orderBy.field!, reset: true);
  }

  void updateOrderBy(String sortType, {bool reset = false}) {
    if (sortType == _orderBy.field && !reset) {
      if (_orderBy.by == OrderByEnum.OrderBy.DESC) {
        _orderBy.by = OrderByEnum.OrderBy.ASC;
      } else {
        _orderBy.by = OrderByEnum.OrderBy.DESC;
      }
    } else {
      _orderBy.field = sortType;
      _orderBy.by = OrderByEnum.OrderBy.DESC; // : OrderByEnum.OrderBy.ASC;
    }
    update([idStatementSort]);
    statementData();
  }

  String getItemLeftData(dynamic data) {
    if (listType == SALE_LIST_TYPE_REMIT) {
      return PriceUtils.priceString((data as BiRemitGroupCustomerDoEntity).receivedAmount);
    }
    data = (data as BiSaleGoodsGroupCustomerDoEntity);
    String left = "";
    switch (listType) {
      case SALE_LIST_TYPE_SALE:
        left = "${data.normalSaleGoodsNum}";
        break;
      case SALE_LIST_TYPE_OWE:
        left = "${data.changeBackOrderGoodsNum}";
        break;
      case SALE_LIST_TYPE_RETURN:
        left = "${data.returnGoodsNum}";
        break;
      case SALE_LIST_TYPE_TOTAL:
        left = "${data.saleGoodsNum}";
        break;
    }
    return left;
  }

  String getItemRightData(dynamic data) {
    if (listType == SALE_LIST_TYPE_REMIT) {
      return PriceUtils.priceString((data as BiRemitGroupCustomerDoEntity).refundAmount);
    }
    data = (data as BiSaleGoodsGroupCustomerDoEntity);
    String left = "";
    switch (listType) {
      case SALE_LIST_TYPE_SALE:
        left = PriceUtils.priceString(data.normalSaleTaxAmount);
        break;
      case SALE_LIST_TYPE_OWE:
        left = PriceUtils.priceString(data.changeBackOrderAmount);
        break;
      case SALE_LIST_TYPE_RETURN:
        left = PriceUtils.priceString(data.returnAmount);
        break;
      case SALE_LIST_TYPE_TOTAL:
        left = PriceUtils.priceString(data.saleTaxAmount);
        break;
    }
    return left;
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
