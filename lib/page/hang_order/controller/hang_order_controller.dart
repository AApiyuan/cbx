import 'dart:async';

import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/query/hang_order_query.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/page/hang_order/model/filter_customer_model.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/hang_order_model.dart';
import 'package:haidai_flutter_module/repository/base/customer_dept_api.dart';

class HangOrderController extends SuperController {
  /// 参数
  var depId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var online = (ArgUtils.getArgument(Constant.ONLINE) ?? "true") == "true";

  /// id
  static const idDataList = "dataList";

  static String idFilterOrderType(int type) => "filterOrderType$type";

  /// 属性
  static const filterAll = -1;
  var _dataList = <HangOrderModel>[];
  var _orderTypeCount = <int, int>{};
  var _selectOrderType = filterAll;
  var _selectCustomerId = filterAll;
  var _filterCustomers = <FilterCustomerModel>[];

  List<HangOrderModel> get dataList => _dataList;

  List<FilterCustomerModel> get filterCustomer => _filterCustomers;

  StreamSubscription<UpdateHangOrderEvent>? _subscription;

  /// 方法
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateHangOrderList();

    _subscription = eventBus.on<UpdateHangOrderEvent>().listen((event) async {
      updateHangOrderList();
    });
  }

  int getOrderTypeCount(int type) => _orderTypeCount[type] ?? 0;

  bool isSelectOrderType(int type) => _selectOrderType == type;

  updateSelectOrderType(int type) {
    _selectOrderType = type;
    updateHangOrderList();
  }

  bool isSelectCustomer(int? id) => _selectCustomerId == id;

  updateSelectCustomer(int id) {
    _selectCustomerId = id;
    updateHangOrderList();
  }

  updateHangOrderList() {
    HangOrderQuery.getHangOrderList(
      depId!,
      customerId: _selectCustomerId == filterAll ? null : _selectCustomerId,
      type: _selectOrderType == filterAll ? null : _selectOrderType,
    ).then((value) {
      dataList.clear();
      dataList.addAll(value);
      if (_selectOrderType == filterAll) _updateOrderTypeCount(value);
      if (_selectCustomerId == filterAll) _updateFilterCustomer(value);
      update([idDataList]);
    });
  }

  _updateFilterCustomer(List<HangOrderModel> value) {
    _filterCustomers.clear();
    value.forEach((order) {
      _filterCustomers.firstWhere((element) {
        if (element.isCurrCustomer(order.customerId)) {
          element.addCount();
          return true;
        }
        return false;
      }, orElse: () {
        var model = FilterCustomerModel(order.customer);
        model.addCount();
        if (order.customer != null) _filterCustomers.add(model);
        return model;
      });
    });
    var count = 0;
    _filterCustomers.forEach((element) => count += element.count);
    _filterCustomers.insert(0, FilterCustomerModel.all(filterAll, "全部", count));
  }

  _updateOrderTypeCount(List<HangOrderModel> value) {
    _orderTypeCount.clear();
    value.forEach((element) => _orderTypeCount[element.type!] =
        (_orderTypeCount[element.type!] ?? 0) + 1);
    var count = 0;
    _orderTypeCount.forEach((key, value) => count += value);
    _orderTypeCount[filterAll] = count;
  }

  Future<List<CustomerDeptRelationDo>> getRelationList(int type) {
    if (type == SaleEnterController.TYPE_SALE) {
      return CustomerDeptApi.selectRelation(depId!);
    }
    return Future.value([]);
  }

  deleteOrder(int? id) {
    HangOrderQuery.delete(id: id).then((value) => updateHangOrderList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel();
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
