import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_owe_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_sale_api.dart';

class BiGoodsController extends SuperController {

  static const SALE_LIST_TYPE_SALE = 0;//销售分析
  static const SALE_LIST_TYPE_OWE = 1;//退欠货
  static const SALE_LIST_TYPE_RETURN = 2;//退实物
  static const SALE_LIST_TYPE_TOTAL = 3;//总交易

  static const TYPE_SALE = 0;
  static const TYPE_OWE = 1;

  /// id
  static const idSaleStatement = "idSaleStatement";
  static const idSaleListSort = "idSaleListSort";
  static const idSaleList = "idSaleList";
  static const idDeptTotal = "idDeptTotal";

  /// 参数
  int topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID)!.toInt();
  int? deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var saleListTab = ArgUtils.getArgument2num(Constant.LIST_TYPE, def: SALE_LIST_TYPE_SALE)!.toInt();
  var type = ArgUtils.getArgument2num(Constant.TYPE, def: TYPE_SALE)!.toInt();
  var startTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
  var endTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

  /// 属性
  var customerDeptIds = <int>[];
  var _orderBy = OrderBy();
  var _currNo = 1;

  var saleListHasMore = true;

  BiSaleSumDo? saleStatementData;
  List<BiSaleGoodsGroupGoodsIdDo> saleGoodsList = [];

  get singleDept => deptId != null;

  get sortType => _orderBy.field;

  get sortByDesc => _orderBy.by == OrderByEnum.OrderBy.DESC;

  /// 方法
  @override
  void onInit() {
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

  /// 获取销售分析（退实物，退欠货，总交易）列表
  Future getSaleListData({bool next = false}) async {
    var param = BasePage();
    param.pageSize = 15;
    if (next) {
      _currNo++;
    } else {
      saleGoodsList.clear();
      _currNo = 1;
    }
    param.pageNo = _currNo;
    var req = BiSaleGoodsPageReqEntity();
    req.topDeptId = topDeptId;
    req.customerDeptIds = customerDeptIds;
    req.customizeStartTime = startTime;
    req.customizeEndTime = endTime;
    req.canceled = CanceledEnum.ENABLE;
    req.orderBy = _orderBy;
    req.filterMerchandiser = singleDept;
    param.param = req;
    return await BiSaleApi.selectSaleGoodsGroupGoodsIdByPage(param)
        .then((value) {
      // var list;
      // switch (saleListTab) {
      //   case SALE_LIST_TYPE_SALE:
      //     list = value.where((element) =>
      //         element.normalSaleGoodsNum != 0 ||
      //         element.normalSaleTaxAmount != 0);
      //     break;
      //   case SALE_LIST_TYPE_OWE:
      //     list = value.where((element) =>
      //         element.changeBackOrderAmount != 0 ||
      //         element.changeBackOrderGoodsNum != 0);
      //     break;
      //   case SALE_LIST_TYPE_RETURN:
      //     list = value.where((element) =>
      //         element.returnAmount != 0 || element.returnGoodsNum != 0);
      //     break;
      //   case SALE_LIST_TYPE_TOTAL:
      //     list = value.where((element) =>
      //         element.saleTaxAmount != 0 || element.saleGoodsNum != 0);
      //     break;
      // }
      saleGoodsList.addAll(value);
      saleListHasMore = value.length == param.pageSize;
      update([idSaleList]);
    });
  }

  /// 获取销售数据
  Future getSaleData() {
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

  /// 更新时间
  updateTime(String start, String end) {
    startTime = start;
    endTime = end;
    getSaleData();
    updateListType(saleListTab);
    // getSaleListData();
  }

  /// 更新店铺列表
  updateDeptIdList(List<int> ids) {
    customerDeptIds = ids;
    update([idDeptTotal]);
    updateTime(startTime, endTime);
    if (Get.isRegistered<BiGoodsOweController>()) {
      Get.find<BiGoodsOweController>().updateCustomerDeptIdList(ids);
    }
  }

  /// 更新列表类型
  updateListType(int index) {
    this.saleListTab = index;
    switch (this.saleListTab) {
      case SALE_LIST_TYPE_SALE:
        _orderBy.field = "normalSaleGoodsNum";
        break;
      case SALE_LIST_TYPE_OWE:
        _orderBy.field = "changeBackOrderGoodsNum";
        break;
      case SALE_LIST_TYPE_RETURN:
        _orderBy.field = "returnGoodsNum";
        break;
      case SALE_LIST_TYPE_TOTAL:
        _orderBy.field = "saleGoodsNum";
        break;
    }
    updateOrderBy(_orderBy.field!, reset: true);
  }

  /// 更新排序相关
  updateOrderBy(String sortType, {bool reset = false}) {
    if (sortType == _orderBy.field && !reset) {
      if (_orderBy.by == OrderByEnum.OrderBy.DESC) {
        _orderBy.by = OrderByEnum.OrderBy.ASC;
      } else {
        _orderBy.by = OrderByEnum.OrderBy.DESC;
      }
    } else {
      _orderBy.field = sortType;
      _orderBy.by = OrderByEnum.OrderBy.DESC;
    }
    update([idSaleListSort]);
    getSaleListData();
  }

  /// 获取列表的左边数据
  String getItemLeftData(BiSaleGoodsGroupGoodsIdDo data) {
    switch (saleListTab) {
      case SALE_LIST_TYPE_SALE:
        return "${data.normalSaleGoodsNum}";
      case SALE_LIST_TYPE_OWE:
        return "${data.changeBackOrderGoodsNum}";
      case SALE_LIST_TYPE_RETURN:
        return "${data.returnGoodsNum}";
      case SALE_LIST_TYPE_TOTAL:
        return "${data.saleGoodsNum}";
    }
    return "";
  }

  /// 获取列表的右边数据
  String getItemRightData(BiSaleGoodsGroupGoodsIdDo data) {
    switch (saleListTab) {
      case SALE_LIST_TYPE_SALE:
        return PriceUtils.priceString(data.normalSaleTaxAmount);
      case SALE_LIST_TYPE_OWE:
        return PriceUtils.priceString(data.changeBackOrderAmount);
      case SALE_LIST_TYPE_RETURN:
        return PriceUtils.priceString(data.returnAmount);
      case SALE_LIST_TYPE_TOTAL:
        return PriceUtils.priceString(data.saleTaxAmount);
    }
    return "";
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
