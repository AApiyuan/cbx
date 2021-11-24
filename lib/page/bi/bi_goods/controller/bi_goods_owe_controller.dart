import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_goods_shortage_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_do_entity.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';

class BiGoodsOweController extends SuperController {

  /// id
  static const idGoodsStock = "idGoodsStock";
  static const idGoodsOwe = "idGoodsOwe";
  static const idOweListSort = "idOweListSort";
  static const idOweList = "idOweList";

  /// 参数
  int topDeptId;
  List<int> customerDeptIds;
  bool singleDept;

  BiGoodsOweController(this.topDeptId, this.customerDeptIds, this.singleDept);

  /// 属性
  var oweListType = 0;
  var listDataHasMore = false;

  var _currNo = 1;
  var _orderBy = OrderBy();

  get sortType => _orderBy.field;

  get sortByDesc => _orderBy.by == OrderByEnum.OrderBy.DESC;

  List<BiGoodsStockDoEntity> listData = [];

  int goodsStock = 0;
  int goodsSubStandardStock = 0;
  int goodsOwe = 0;

  /// 方法
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _orderBy.field = "shortageNum";
    _orderBy.by = OrderByEnum.OrderBy.DESC;
    getGoodsStockData();
    getGoodsOweData();
    getListData();
  }

  Future getListData({bool next = false}) async {
    if (customerDeptIds.isEmpty) return;
    if (next) {
      _currNo++;
    } else {
      listData.clear();
      _currNo = 1;
    }
    var param = BasePage();
    param.pageSize = 15;
    param.pageNo = _currNo;
    var req = BiSaleGoodsPageReqEntity();
    req.customerDeptIds = customerDeptIds;
    req.topDeptId = topDeptId;
    req.orderBy = _orderBy;
    req.filterMerchandiser = singleDept;
    param.param = req;
    if (oweListType == 0) {
      return await BiDeptApi.selectShortageByPage(param).then((value) {
        listDataHasMore = value.length == param.pageSize;
        listData.addAll(value);
        update([idOweList]);
      });
    } else {
      return await BiDeptApi.selectStockByPage(param).then((value) {
        listDataHasMore = value.length == param.pageSize;
        listData.addAll(value);
        update([idOweList]);
      });
    }
  }

  getGoodsOweData() {
    if(customerDeptIds.isEmpty) return;
    var param = BiGoodsShortagePageReqEntity();
    param.topDeptId = topDeptId;
    param.customerDeptIds = customerDeptIds;
    param.filterMerchandiser = singleDept;
    BiDeptApi.selectShortageGroupDept(param).then((value) {
      value.forEach((element) => goodsOwe += element.shortageNum ?? 0);
      update([idGoodsOwe]);
    });
  }

  getGoodsStockData() {
    if (customerDeptIds.isEmpty) return;
    var param = BiSalePageReq();
    param.topDeptId = topDeptId;
    param.customerDeptIds = customerDeptIds;
    param.filterMerchandiser = singleDept;
    BiDeptApi.selectStockGroupDept(param).then((value) {
      value.forEach((element) {
        goodsStock += element.stockNum;
        goodsSubStandardStock += element.substandardNum;
      });
      update([idGoodsStock]);
    });
  }

  updateListType(int listType) {
    this.oweListType = listType;
    switch(listType) {
      case 0:
        _orderBy.field = "shortageNum";
        break;
      case 1:
        _orderBy.field = "stockNum";
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
      _orderBy.by = OrderByEnum.OrderBy.DESC;
    }
    update([idOweListSort]);
    getListData();
  }

  updateCustomerDeptIdList(List<int> ids) {
    this.customerDeptIds = ids;
    getListData();
    getGoodsOweData();
    getGoodsStockData();
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